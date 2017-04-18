//
//  DownLoadViewController.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/24.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "DownLoadViewController.h"
#import "FMDBHelper.h"
#import "Definition.h"
#import "Masonry.h"
#import "MemberDownLoadTableViewDataSource.h"
#import "MJExtension.h"
#import "MemDownLoadSectionModel.h"
#import "SkinVideoViewController.h"
#import "PolyvSettings.h"
#import "FMDBHelper.h"
#import "NetworkManager.h"
#import "PvUrlSessionDownload.h"
#import "NetRequestUrl.h"

@interface DownLoadViewController ()<MemDownLoadDataSourceDelegate>
@property (nonatomic, strong) NSMutableArray *realVideolist;// 从数据库取出的
@property (nonatomic, strong) NSMutableArray *mainNameArray;// 大课名数组
@property (nonatomic, strong) NSMutableArray *wholeArray;// 存放所有模型的数组
@property (nonatomic, strong) NSMutableArray *lasetWholeArray;// 最终调好的数组集合
@property (nonatomic, strong) NSMutableArray *chapterNameArray;//
@property (nonatomic, strong) NSMutableArray *chapterDicArray;//
@property (nonatomic, strong) NSMutableArray *modelArray;//_
@property (nonatomic, strong) NSMutableArray *ui_modelArray;
@property (nonatomic, strong) NSMutableArray *ui_ChapterDicArray;
@property (nonatomic, strong) NSMutableArray *ui_LasetWholeArray;
@property (nonatomic, strong) MemberDownLoadTableViewDataSource *dataSource;
@property (nonatomic, strong) SkinVideoViewController *downLoadVideoPlayer;


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MemDownLoadSectionModel *memDownLoadSectionModel;//

@end

@implementation DownLoadViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.000]];
    title.text = @"下载管理";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    self.navigationItem.titleView = title;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
// 是否登录
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self isLogin:^(BOOL isLogin) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!isLogin) return;
            
            [self orderDataSources];
            [self createTable];
        });
    }];
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}
- (void)viewDidDisappear:(BOOL)animated {
    // 主动调用 cancel 方法销毁播放器
    [self.downLoadVideoPlayer cancel];    // cancel方法中调用了cancelObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidDisappear:animated];
}



/**
 将数据转换成模型
 */
- (void)orderDataSources{

    /*
     在下载中心读取我下载的视频时
     1--将所有 大课名称相同的video 装在一个数组中
    Model------------------------
   { mainName:   "税法一"，
     mainimage:  "www.baidu.com.jpg",
     chapterList:[{
     chapter:"简介"，
     videolist:[
     video1,
     vodeo2,
     video3
     ]
     },{
     chapter:"第二章"，
     videolist:[
     video4,
     vodeo5,
     video6
     ]
     }]
     }
     
     
     Ui------------------------
     
   { mainName:   "税法一"，
     mainimage:  "www.baidu.com.jpg",
     chapterList:[
     chapter:"简介"
     video1,
     vodeo2,
     video3
   
    
     chapter:"第二章"，
     videolist:
     video4,
     vodeo5,
     video6
    
     }
     }
     
     2--提取出 image封面 和课程名称
     3--在将这个数组中的video、对象按照 章节名 划分成 不同的数组进行归类
     */
    
    self.realVideolist = [[FMDBHelper sharedInstance] listDownloadVideo];
    for (int i = 0;i < self.realVideolist.count;  i++) {
        Video *video = [self.realVideolist objectAtIndex:i];
        [self.mainNameArray addObject:video.mainName];
    }
    //提取出 mianName ,再将所有 video 按照 mainName 归类
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] initWithCapacity:self.mainNameArray.count];
    for (NSString *item in self.mainNameArray) {
        [resultDict setObject:item forKey:item];
    }
    NSArray *resultArray = resultDict.allValues;
    NSLog(@"%@", resultArray);
    /*
     将 video  归类 成 大课的类
     */
    for (int  index = 0; index <resultArray.count; index ++) {
        NSMutableArray *mainNameVideoArray = [NSMutableArray array];
        for (int i = 0;i < self.realVideolist.count;  i++){
            Video *video = [self.realVideolist objectAtIndex:i];
            if ([video.mainName isEqualToString:resultArray[index]]) {
                [mainNameVideoArray addObject:video];
            }
        }
        [self.wholeArray addObject:mainNameVideoArray];
    }
    
    /*
     将video 按照具体章节归类
     for循环导致拿到的 第二组数据不对
     */
    for (int k = 0; k < self.wholeArray.count; k ++) {
        self.chapterNameArray =nil;
        self.chapterDicArray = nil;
        self.ui_ChapterDicArray = nil;
        for (int m = 0; m < ((NSArray *)self.wholeArray[k]).count; m ++) {
            //拿到每个 video
            Video *video = self.wholeArray[k][m];
            //获取大课 内所有的章节名
            [self.chapterNameArray addObject:video.chapterName];
        }
        NSMutableDictionary *chapterDict = [[NSMutableDictionary alloc] initWithCapacity:self.chapterNameArray.count];
        for (NSString *item in self.chapterNameArray) {
            [chapterDict setObject:item forKey:item];
        }
        NSArray *resultChapterArray = chapterDict.allValues;
        

        for (int index = 0; index <resultChapterArray.count; index ++) {
            NSMutableArray *chapVideoArray = [NSMutableArray array];
            NSMutableArray *ui_chapVideoArray = [NSMutableArray array];
            NSMutableDictionary *chapterDiction = [NSMutableDictionary dictionaryWithCapacity:2];
            for (int w = 0;w < ((NSArray *)self.wholeArray[k]).count; w ++){
                Video *video = self.wholeArray[k][w];
                if ([video.chapterName isEqualToString:resultChapterArray[index]]) {
                    if (![ui_chapVideoArray containsObject:chapterDiction]) {
                        
                        [chapterDiction setObject:video.chapterName forKey:@"normal"];
                        [chapterDiction setObject:@"no" forKey:@"isSelect"];
                        
                        [ui_chapVideoArray addObject:chapterDiction];
                    }
                    [chapVideoArray addObject:video];
                    
                    
                    NSMutableDictionary *videoDiction = [NSMutableDictionary dictionaryWithCapacity:2];
                    [videoDiction setObject:video forKey:@"normal"];
                    [videoDiction setObject:@"no" forKey:@"isSelect"];
                   
                    [ui_chapVideoArray addObject:videoDiction];
                }
              }
            
            NSDictionary *chapterDic = @{@"chapter":resultChapterArray[index],@"videolist":chapVideoArray};
            [self.chapterDicArray addObject:chapterDic];
            
            for (id yuansu in ui_chapVideoArray) {
                [self.ui_ChapterDicArray addObject:yuansu];
            }
        }
        NSDictionary *singleDic = @{@"mainName":((Video *)self.wholeArray[k][0]).mainName,@"isSelect":@"no",@"mainimage":((Video *)self.wholeArray[k][0]).fengMianImage,@"chapterList":self.chapterDicArray};
        
        NSMutableDictionary *ui_SingleDic = [NSMutableDictionary dictionaryWithCapacity:3];
        [ui_SingleDic setObject:((Video *)self.wholeArray[k][0]).mainName forKey:@"mainName"];
        [ui_SingleDic setObject:@"no" forKey:@"isSelect"];
        [ui_SingleDic setObject:((Video *)self.wholeArray[k][0]).fengMianImage forKey:@"mainimage"];
        [ui_SingleDic setObject:self.ui_ChapterDicArray forKey:@"chapterList"];
        
        [self.lasetWholeArray addObject:singleDic];
        [self.ui_LasetWholeArray addObject:ui_SingleDic];
    }
    // 字典转模型、
    for (NSDictionary *tempDic in self.lasetWholeArray) {
       self.memDownLoadSectionModel = [MemDownLoadSectionModel mj_objectWithKeyValues:tempDic];
       [self.modelArray addObject: self.memDownLoadSectionModel];
    }
    for (NSMutableDictionary *tempDic in self.ui_LasetWholeArray) {
        self.memDownLoadSectionModel = [MemDownLoadSectionModel mj_objectWithKeyValues:tempDic];
        [self.ui_modelArray addObject: self.memDownLoadSectionModel];
    }
    
}

- (void)createTable{

    self.tableView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    MemberDownLoadTableViewDataSource *dataSource = [[MemberDownLoadTableViewDataSource alloc] initWithItems:self.modelArray uitems:self.ui_modelArray  cellName:@"DownLoadCell" cellIdentifier:@"DownLoadCell" cellType:kFYCellTypeDefault];
    dataSource.delegate = self;
    dataSource.currentTableView = self.tableView;
    self.tableView.dataSource = dataSource;
    self.tableView.delegate = dataSource;
    self.dataSource = dataSource;


}

- (UITableView *)tableView{
    
    if (_tableView==nil) {
        
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_tableView];
        LWWeakSelf(self);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.view.mas_top);
            make.left.equalTo(weakself.view.mas_left);
            make.width.equalTo(weakself.view);
            make.height.equalTo(weakself.view);
            
        }];
    }
    return _tableView;
}

#pragma  mark--- dataSourceDelegate
- (void)didSelectedCellWithItem:(Video *)video didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

  
   // 有些视频是无法播放的 会崩溃
    [self.downLoadVideoPlayer setVid:video.vid];
    NSLog(@"--------%@",video.vid);
    [self.view addSubview:self.downLoadVideoPlayer.view];
    [self.downLoadVideoPlayer setParentViewController:self];
    
    // 需要保留导航栏
    [self.downLoadVideoPlayer keepNavigationBar:YES];
    [self.downLoadVideoPlayer setNavigationController:self.navigationController];
    
    // 设置附加组件
    [self.downLoadVideoPlayer setHeadTitle:video.title];
    [self.downLoadVideoPlayer setEnableDanmuDisplay:NO];      // 不显示弹幕按钮
    [self.downLoadVideoPlayer setEnableRateDisplay:NO];       // 不显示播放速率按钮
    // 开启片头播放
    self.downLoadVideoPlayer.teaserEnable = YES;
    // 自动续播, 是否继续上次观看的位置
 //   self.downLoadVideoPlayer.autoContinue = YES;
    
    // 开启弹幕
    [self.downLoadVideoPlayer enableDanmu:YES];
    
    // 是否开启截图
    self.downLoadVideoPlayer.enableSnapshot = YES;
    
    /**
     *  ---- 回调代码块 ----
     */
    
    [self.downLoadVideoPlayer setPlayButtonClickBlock:^{
        NSLog(@"user click play button");
    }];
    [self.downLoadVideoPlayer setPauseButtonClickBlock:^{
        NSLog(@"user click pause button");
    }];
    
    
    [self.downLoadVideoPlayer setFullscreenBlock:^{
        NSLog(@"should hide toolbox in this viewcontroller if needed");
        
    }];
    LWWeakSelf(self);
    [self.downLoadVideoPlayer setShrinkscreenBlock:^{
        [weakself.downLoadVideoPlayer stop];
        [weakself.downLoadVideoPlayer.view removeFromSuperview];
       // [[NSNotificationCenter defaultCenter] removeObserver:weakself];
       // weakself.downLoadVideoPlayer = nil;
        
    }];
    // 视频播放完成的回调代码块
    [self.downLoadVideoPlayer setWatchCompletedBlock:^{
        NSLog(@"user watching completed");
    }];


    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
            
        case UIInterfaceOrientationPortraitUpsideDown:{ // 电池栏在下
            //			NSLog(@"fullScreenAction第3个旋转方向---电池栏在下");
            [self interfaceOrientation:UIInterfaceOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationPortrait:{ // 电池栏在上
            //			NSLog(@"fullScreenAction第0个旋转方向---电池栏在上");
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{ // 电池栏在右
            //			NSLog(@"fullScreenAction第2个旋转方向---电池栏在右");
            [self interfaceOrientation:UIInterfaceOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{ // 电池栏在左
            //			NSLog(@"fullScreenAction第1个旋转方向---电池栏在左");
            [self interfaceOrientation:UIInterfaceOrientationPortrait];
        }
            break;
            
        default:
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
            break;
    }


}

/// 旋转按钮事件
- (void)fullScreenAction:(UIButton *)sender{
    //	NSLog(@"%s", __FUNCTION__);
    
}


/// 强制转屏
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}



- (SkinVideoViewController *)downLoadVideoPlayer{
    if (!_downLoadVideoPlayer) {
        CGFloat width = self.view.bounds.size.width;
        _downLoadVideoPlayer = [[SkinVideoViewController alloc] initWithFrame:CGRectMake(0, 0, width, ScreenHeight/3)];
        [_downLoadVideoPlayer configObserver];
        
        __weak typeof(self)weakSelf = self;
        [self.downLoadVideoPlayer setDimissCompleteBlock:^{
            [weakSelf.downLoadVideoPlayer stop];
            [weakSelf.downLoadVideoPlayer cancel];
            [weakSelf.downLoadVideoPlayer cancelObserver];
            weakSelf.downLoadVideoPlayer = nil;
        }];
    }
    return _downLoadVideoPlayer;
}
- (NSMutableArray *)mainNameArray{
    if (_mainNameArray ==nil) {
        _mainNameArray = [NSMutableArray array];
    }
    return _mainNameArray;
}

- (NSMutableArray *)wholeArray{
    if (_wholeArray ==nil) {
        _wholeArray = [NSMutableArray array];
    }
    return _wholeArray;
}

- (NSMutableArray *)chapterNameArray{
    if (_chapterNameArray ==nil) {
        _chapterNameArray = [NSMutableArray array];
    }
    return _chapterNameArray;
}
- (NSMutableArray *)chapterDicArray{
    if (_chapterDicArray ==nil) {
        _chapterDicArray = [NSMutableArray array];
    }
    return _chapterDicArray;
}

- (NSMutableArray *)ui_ChapterDicArray{
    if (_ui_ChapterDicArray ==nil) {
        _ui_ChapterDicArray = [NSMutableArray array];
    }
    return _ui_ChapterDicArray;
}

- (NSMutableArray *)lasetWholeArray{
    if (_lasetWholeArray ==nil) {
        _lasetWholeArray = [NSMutableArray array];
    }
    return _lasetWholeArray;
}

- (NSMutableArray *)ui_LasetWholeArray{
    if (_ui_LasetWholeArray ==nil) {
        _ui_LasetWholeArray = [NSMutableArray array];
    }
    return _ui_LasetWholeArray;
}

- (NSMutableArray *)modelArray{
    if (_modelArray ==nil) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (NSMutableArray *)ui_modelArray{
    if (_ui_modelArray ==nil) {
        _ui_modelArray = [NSMutableArray array];
    }
    return _ui_modelArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
