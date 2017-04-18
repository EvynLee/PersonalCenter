//
//  DetailMovieTableViewDataSource.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/21.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "MemberDownLoadTableViewDataSource.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "LWBaseCell.h"
#import "DowmLoadSectionInfo.h"
#import "DownLoadCell.h"
#import "DownLoadTabHeaderView.h"
#import "Definition.h"
#import "Video.h"
#define ROW_HEIGHT 184/2

@interface MemberDownLoadTableViewDataSource()<DownSectionHeaderViewDelegate,DownLoadBtnClickDelegate>

@property (nonatomic, strong)       LWBaseCell * baseCell;
@property (nonatomic, copy)         NSString *cellIdentifier;
@property (nonatomic, copy)         NSString *cellIClassName;
@property (nonatomic, assign)       kFYCellType cellType;
@property (nonatomic, strong) NSMutableArray* sectionInfoArray;
@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, strong) NSMutableArray* netDataArray;





/*      cell单元的删除状态点击       */
@property (nonatomic, assign)   NSIndexPath *choose_indexPathAll;
@property (nonatomic, assign) NSInteger  choose_section;
@property (nonatomic, assign) BOOL choose_action;
@property (nonatomic, strong) MemDownLoadSectionModel *choose_targetModel;
@property (nonatomic, strong) DowmLoadSectionInfo *choose_sectionInfo;
@property (nonatomic, strong) NSArray *choose_chapterArr;
@property (nonatomic, assign) NSInteger choose_chapterIndex;
@property (nonatomic, assign) NSInteger choose_cellIndex;
@property (nonatomic, copy) NSString * sectionLabelTxt;
@end

@implementation MemberDownLoadTableViewDataSource
- (instancetype)initWithItems:(NSArray *)items
                       uitems:(NSArray *)uiItems
                     cellName:(NSString *)cellClassName
               cellIdentifier:(NSString *)cellIdentifier
                     cellType:(kFYCellType)cellType{
    
    self = [super init];
    if (self) {
        self.openSectionIndex = NSNotFound;
        self.items          = items;
        self.uiItems        = uiItems;
        [self configSessionInfo];
        self.cellIClassName = cellClassName;
        self.cellIdentifier = cellIdentifier;
        self.cellType       = cellType;
        if (cellType == kFYCellTypeDefault) {
            // 控制器类对象 字符串转类！
            Class cellClass = NSClassFromString(cellClassName);
            // 创建对象
            self.baseCell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
        }
    }
    return self;
}

- (void)configSessionInfo{
    
    if (self.sectionInfoArray == nil) {
        
        //从程序入口设置的tableViewController.plays中获取数据，分区数据包括play、open
        NSMutableArray *infoArray = [[NSMutableArray alloc] init];
        
        for (MemDownLoadSectionModel *play in self.items) {
            
            DowmLoadSectionInfo *sectionInfo = [[DowmLoadSectionInfo alloc] init];
            sectionInfo.selectPlay = play;
            sectionInfo.open = NO;//设置分区默认不打开，就是分组处于收缩状态
            
            NSNumber *defaultRowHeight = [NSNumber numberWithInteger:80/2];
          //  NSInteger countOfQuotations = [[sectionInfo.selectPlay chapterList] count];
            
            
            NSArray *array = [sectionInfo.selectPlay chapterList];
            NSArray *videoListArray;
            NSInteger arrCount = 0;
            for (NSDictionary *videoListDic in array) {
                videoListArray = videoListDic[@"videolist"];
                arrCount = arrCount + videoListArray.count;
            }
            
            NSLog(@"==countOfQuotations=%zd",arrCount);
            //获取每个分区中的行数据
            for (NSInteger i = 0; i < arrCount + array.count; i++) {
                [sectionInfo insertObject:defaultRowHeight inRowHeightsAtIndex:i];//设置数组的值
            }
            [infoArray addObject:sectionInfo];
        }
        self.sectionInfoArray = infoArray;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.items count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DowmLoadSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:section];
    NSArray *array = [sectionInfo.selectPlay chapterList];
    NSArray *videoListArray;
    NSInteger arrCount = 0;
    for (NSDictionary *videoListDic in array) {
        videoListArray = videoListDic[@"videolist"];
         arrCount = arrCount + videoListArray.count;
     }
    
   // NSInteger numStoriesInSection = [[sectionInfo.selectPlay chapterList] count];
   //如果分区是打开的，则返回该分区的行数，否则返回0，默认均未打开
    return sectionInfo.open ? arrCount + array.count : 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"section-----%ld   row---------%ld",indexPath.section,indexPath.row);
    DownLoadCell *cell = (DownLoadCell *)[tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (_cellType == kFYCellTypeDefault) {
        
        if (!cell) {
            Class cellClass = NSClassFromString(_cellIClassName);
            // 创建对象
            cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellIdentifier];
            cell.delegate = self;
        }
    }

    MemDownLoadSectionModel *model = [self.uiItems objectAtIndex:indexPath.section];
    [cell configureCellContentWithItem:model.chapterList[indexPath.row] baseCell:nil];
    return cell;
    
}


- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        return [self.delegate sectionIndexTitlesForTableView:tableView];
    }
    
    return nil;
}

#pragma mark
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DowmLoadSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:indexPath.section];
    return [[sectionInfo objectInRowHeightsAtIndex:indexPath.row] floatValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  /*
   1-- 点击的是 chapter 直接return
   */
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) return;
    MemDownLoadSectionModel *model = self.uiItems[indexPath.section];
    NSMutableDictionary *tempDic = model.chapterList[indexPath.row];
    if ([tempDic[@"normal"] isKindOfClass:[NSString class]]) return;
    Video *video = tempDic[@"normal"];
    NSLog(@"section-----%ld   row---------%ld",indexPath.section,indexPath.row);
      if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedCellWithItem:didSelectRowAtIndexPath:)]) {
        [self.delegate didSelectedCellWithItem:video didSelectRowAtIndexPath:indexPath];
    }
   
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return ROW_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForFooterInSection:tableView:)]) {
        return [self.delegate heightForFooterInSection:section tableView:tableView];
    }
    
    return 1.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    DowmLoadSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:section];
    //NSDictionary *modelDic = [self.uiItems objectAtIndex:section];
    if (!sectionInfo.headerView) {
        //调用自定义控件SectionHeaderView来设置分区head   isSelect:sectionInfo.selectPlay.isSelect
        sectionInfo.headerView = [[DownLoadTabHeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth,ROW_HEIGHT) title:sectionInfo.selectPlay.mainName image:sectionInfo.selectPlay.mainimage section:section delegate:self];
     //   sectionInfo.headerView = [[DownLoadTabHeaderView alloc]initwi];
        sectionInfo.headerView.section = section;
    }
    [sectionInfo.headerView isSelect:sectionInfo.selectPlay.isSelect];
    return sectionInfo.headerView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewForFooterInSection:tableView:)]) {
        return [self.delegate viewForFooterInSection:section tableView:tableView];
    }
    
    return nil;
}


#pragma mark --HeaderView Delegate
-(void)sectionHeaderView:(DownLoadTabHeaderView*)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {

    DowmLoadSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:sectionOpened];
    
    sectionInfo.open = YES;

    NSArray *array = [sectionInfo.selectPlay chapterList];
    NSArray *videoListArray;
    NSInteger arrCount = 0;
    for (NSDictionary *videoListDic in array) {
        videoListArray = videoListDic[@"videolist"];
        arrCount = arrCount + videoListArray.count;
    }
    //设置展开分区的数据行
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < arrCount + array.count; i++) {
        
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
    }
    
    //前一个打开的分区或者分组
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    NSInteger previousOpenSectionIndex = self.openSectionIndex;
    //如果存在已经打开的分区，就将该分区关闭
    if (previousOpenSectionIndex != NSNotFound) {
        DowmLoadSectionInfo *previousOpenSection = [self.sectionInfoArray objectAtIndex:previousOpenSectionIndex];
        //关机打开的分组
        previousOpenSection.open = NO;
        [previousOpenSection.headerView mem_toggleOpenWithUserAction:NO];
        
        NSArray *prearray = previousOpenSection.selectPlay.chapterList;
        NSArray *prevideoListArray;
        NSInteger prearrCount = 0;
        for (NSDictionary *prevideoListDic in prearray) {
            prevideoListArray = prevideoListDic[@"videolist"];
            prearrCount = prearrCount + prevideoListArray.count;
        }
        //将打开的分区下的行存入delete
        for (NSInteger i = 0; i < prearrCount + prearray.count; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenSectionIndex]];
        }
    }
    //设置展开和收缩分组的动画效果.
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousOpenSectionIndex == NSNotFound || sectionOpened < previousOpenSectionIndex) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    //动态插入和删除数据
    [self.currentTableView beginUpdates];
    [self.currentTableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self.currentTableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.currentTableView endUpdates];
    //设置当前展开分组的序号
    self.openSectionIndex = sectionOpened;
    
}

//点击收缩分区的head
-(void)sectionHeaderView:(DownLoadTabHeaderView*)sectionHeaderView sectionClosed:(NSInteger)sectionClosed {
    //关闭点击分组，同时删除该分组下的数据行
    DowmLoadSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:sectionClosed];
    
    sectionInfo.open = NO;
    NSInteger countOfRowsToDelete = [self.currentTableView numberOfRowsInSection:sectionClosed];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
        }
        [self.currentTableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
    //设置当前没有展开的分组
    self.openSectionIndex = NSNotFound;
}


#pragma mark-- cell Delegate
// chapter上的 被点击
- (void)chapterChooseButtonClick:(NSString *)sectionLabelTxt cell:(DownLoadCell *)cell button:(UIButton *)button{
    
//-------------------------------------UI 变化

    /*
     点击的 cell 分两种 1 chapter cell 2 video cell 无论哪一种 都需要在自己cell点击完后检查同级别的是否都被 来决定是否将上一级选中
         1--如 video cell 选中后需要 检查所有的 video cell是否被选中 来确定 1-chapter cell是否要被选中 2-再根据 chapter cell是否被
            全部选中 来确定headerView是否被选中 所以 video cell 需要检查两次（因为如果用户不直接选任何一个chapter的情况下将所有的video cell选中，也是需要将上极按钮全部置为选中状态才行）
         2--如果点击的是 chapter cell 则直接将它的 video cell 全部选中 再检查 chapter cell 是否都被选中了 来确定是否更改 headerView
     */
     _choose_indexPathAll = [self.currentTableView indexPathForCell:cell];
     _choose_section = _choose_indexPathAll.section;
     _choose_action = ((UIButton *)button).selected;
     _choose_targetModel = self.uiItems[_choose_section];
     _choose_sectionInfo = [self.sectionInfoArray objectAtIndex:_choose_section];
     _choose_chapterArr =_choose_targetModel.chapterList;
     _choose_chapterIndex = 0;
     _choose_cellIndex = 0;
    for (NSMutableDictionary *dic in _choose_chapterArr) {
        
        /*
                video cell
         */
        if ([dic[@"normal"] isKindOfClass:[Video class]]) {
            
            if ([((Video *)dic[@"normal"]).title isEqualToString:sectionLabelTxt]){
                 _choose_cellIndex = [_choose_chapterArr indexOfObject:dic];
                if (_choose_action==YES) {
                    dic[@"isSelect"] = @"yes";
                }else{
                    dic[@"isSelect"] = @"no";
                    _choose_sectionInfo.selectPlay.isSelect = @"no";// 将 header view状态直接取消
                    NSMutableDictionary *lineChapter = [NSMutableDictionary dictionary];
                    for (NSInteger index =_choose_cellIndex -1 ; _choose_chapterArr.count; index --) {
                        NSMutableDictionary *forwordDic =_choose_chapterArr[index];
                        if ([forwordDic[@"normal"] isKindOfClass:[NSString class]]) {
                            lineChapter = forwordDic;
                            break;
                        }
                    }
                    lineChapter[@"isSelect"] = @"no";// 将上级 chapter直接取消
                    [self.currentTableView reloadData];
                    break;
                }
                
                // 1--找到此cell的兄弟
                NSMutableArray *judgArray = [NSMutableArray array];
                NSMutableDictionary *forwordChapter = [NSMutableDictionary dictionary];
                //  向后遍历 直到走到下一个chapter 跳出循环
                for (NSInteger index =_choose_cellIndex +1 ; _choose_chapterArr.count; index ++) {
                    NSMutableDictionary *backDic;
                    if (index == _choose_chapterArr.count) {
                        [judgArray addObject:_choose_chapterArr[index-1][@"isSelect"]];
                        break;
                    }else{
                        backDic =_choose_chapterArr[index];
                        if ([backDic[@"normal"] isKindOfClass:[NSString class]]) {
                            break;
                        }
                         [judgArray addObject:backDic[@"isSelect"]];
                    }
                }
                    
                //  向前遍历 直到走到下它chapter 跳出循环
                for (NSInteger index =_choose_cellIndex -1 ; _choose_chapterArr.count; index --) {
                    NSMutableDictionary *forwordDic =_choose_chapterArr[index];
                    if ([forwordDic[@"normal"] isKindOfClass:[NSString class]]) {
                        forwordChapter = forwordDic;
                        break;
                    }else{
                       [judgArray addObject:forwordDic[@"isSelect"]];
                    
                    }
            }
                //检查chapter 是否需要被选中
               for (NSInteger tag = 0; tag<judgArray.count; tag++) {
                    if ([judgArray[tag] isEqualToString:@"no"]) {
                        //   forwordChapter[@"isSelect"] = @"no";
                        break;
                    }else if (tag == judgArray.count-1){
                        forwordChapter[@"isSelect"] = @"yes";
                    }
                }
                
                
                // 检查 headerview是否需要被选中
                NSMutableArray *judgChapterArray = [NSMutableArray array];
                //检查 chapter 是不是全都被点击过了 ？将headerview的ui刷新：不做操作
                for (NSMutableDictionary *tempDic in _choose_targetModel.chapterList) {
                    if ([([tempDic valueForKey:@"normal"]) isKindOfClass:[NSString class]]) {
                        [judgChapterArray addObject:tempDic[@"isSelect"]];
                    }
                }
                
                
                for (NSInteger tagIndex = 0; tagIndex<judgChapterArray.count; tagIndex++) {
                    if ([judgChapterArray[tagIndex] isEqualToString:@"no"]) {
                        //   forwordChapter[@"isSelect"] = @"no";
                        break;
                    }else if ( tagIndex == judgChapterArray.count-1 && [judgChapterArray[tagIndex] isEqualToString:@"yes"]){
                        NSLog(@"---%zd",judgChapterArray.count-1);
                        _choose_sectionInfo.selectPlay.isSelect = @"yes";
                    }
                }
            [self.currentTableView reloadData];
                
        }
        }
        
        
        /*
                  chapter Cell
         */
        else{
            
            if ([dic[@"normal"] isKindOfClass:[NSString class]]) {
                if ([dic[@"normal"] isEqualToString:sectionLabelTxt]) {
                    _choose_chapterIndex = [_choose_chapterArr indexOfObject:dic];
                    for (NSInteger index = _choose_chapterIndex + 1; index<_choose_chapterArr.count; index ++) {
                        if ([([_choose_chapterArr[index] valueForKey:@"normal"]) isKindOfClass:[Video class]]) {
                            if (_choose_action==YES) {
                                _choose_chapterArr[index][@"isSelect"] = @"yes";
                                dic[@"isSelect"] = @"yes";
                            }else{
                                _choose_chapterArr[index][@"isSelect"] = @"no";
                                dic[@"isSelect"] = @"no";
                                _choose_sectionInfo.selectPlay.isSelect = @"no";
                            }
                        }else {
                            break;
                        }
                    }
                    
                    NSMutableArray *judgChapterArray = [NSMutableArray array];
                    //检查 chapter 是不是全都被点击过了 ？将headerview的ui刷新：不做操作
                    for (NSMutableDictionary *tempDic in _choose_targetModel.chapterList) {
                        if ([([tempDic valueForKey:@"normal"]) isKindOfClass:[NSString class]]) {
                            [judgChapterArray addObject:tempDic[@"isSelect"]];
                        }
                    }
                    
                    
                    for (NSInteger tagIndex = 0; tagIndex<judgChapterArray.count; tagIndex++) {
                        if ([judgChapterArray[tagIndex] isEqualToString:@"no"]) {
                            //   forwordChapter[@"isSelect"] = @"no";
                            break;
                        }else if ( tagIndex == judgChapterArray.count-1 && [judgChapterArray[tagIndex] isEqualToString:@"yes"]){
                            NSLog(@"---%zd",judgChapterArray.count-1);
                            _choose_sectionInfo.selectPlay.isSelect = @"yes";
                        }
                    }
                    [self.currentTableView reloadData];
                    break;
                }
            }
        }
        
        
        
//----------------------------------  需要的数据源变化
}
}
- (void)allChooseHeaderBtClick:(UIButton *)btn section:(NSInteger)section{
    
        BOOL action = ((UIButton *)btn).selected;
        MemDownLoadSectionModel *targetModel = self.uiItems[section];
        DowmLoadSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:section];
    
        NSArray *chapterArr =targetModel.chapterList;
        for (NSMutableDictionary *cellDic in chapterArr) {
            if (action) {
                // 选中所有
                cellDic[@"isSelect"] = @"yes";
                sectionInfo.selectPlay.isSelect = @"yes";
            }else{
            // 所有的取消选中
                cellDic[@"isSelect"] = @"no";
                sectionInfo.selectPlay.isSelect = @"no";
            }
    }
    [self.currentTableView reloadData];

}

#pragma mark - getter
- (NSArray *)items{
    
    if (_items == nil) {
        NSArray *tempItems = [[NSArray alloc]init];
        _items = tempItems;
    }
    return _items;
}

- (NSArray *)uiItems{
    
    if (_uiItems == nil) {
        NSArray *tempItems = [[NSArray alloc]init];
        _uiItems = tempItems;
    }
    return _uiItems;
}

#pragma mark - private
- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    return _items[indexPath.row];
}

// 根据cell。获取对应的 tableview
- (UITableView*)myTableView:(DownLoadCell *)baseCell{
    for (UIView* next = [baseCell superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UITableView class]]) {
            return (UITableView*)nextResponder;
        }
    }
    return nil;
}
- (NSMutableArray *)netDataArray{
    
    if (_netDataArray == nil) {
        _netDataArray  = [NSMutableArray array];
    }
    
    return _netDataArray;
}

@end
