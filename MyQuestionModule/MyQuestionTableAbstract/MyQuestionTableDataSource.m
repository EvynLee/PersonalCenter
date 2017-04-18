//
//  FYDataSource.m
//  FYMenuExample
//
//  Created by 李炜 on 15/11/23.
//  Copyright © 2015年 evyn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "MyQuestionTableDataSource.h"
#import "MyQuestionBaseCell.h"

#define kTeacherSummeryViewHeight 150

@interface MyQuestionTableDataSource()

@property (nonatomic, strong)       MyQuestionBaseCell * baseCell;
@property (nonatomic, copy)         NSString *cellIdentifier;
@property (nonatomic, copy)         NSString *cellIClassName;
@property (nonatomic, assign)       kFYCellType cellType;



@end

@implementation MyQuestionTableDataSource

- (instancetype)initWithItems:(NSArray *)items
                     cellName:(NSString *)cellClassName
               cellIdentifier:(NSString *)cellIdentifier
                     cellType:(kFYCellType)cellType{
    self = [super init];
    if (self) {
    
        self.items          = items;
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

#pragma mark
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyQuestionBaseCell *cell = (MyQuestionBaseCell *)[tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (_cellType == kFYCellTypeDefault) {
        
        if (!cell) {
             Class cellClass = NSClassFromString(_cellIClassName);
            // 创建对象
             cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellIdentifier];
           
      }
    }
    
    id item = [self itemAtIndexPath:indexPath];
    [cell  cellIndexPathAndRow:indexPath.row];
    [cell  configureCellContentWithItem:item];
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
    
    id item = [self itemAtIndexPath:indexPath];
    return [self.baseCell configureCellHeightWithItem:item];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     id item = [self itemAtIndexPath:indexPath];
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedCellWithItem:tableView:)]) {
        [self.delegate didSelectedCellWithItem:item tableView:tableView];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForHeaderInSection:tableView:)]) {
        return [self.delegate heightForFooterInSection:section tableView:tableView];
    }
    
    return 1.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForFooterInSection:tableView:)]) {
        return [self.delegate heightForFooterInSection:section tableView:tableView];
    }
    
    return 1.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewForHeaderInSection:tableView:)]) {
        return [self.delegate viewForHeaderInSection:section tableView:tableView];
    }
    
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewForFooterInSection:tableView:)]) {
        return [self.delegate viewForFooterInSection:section tableView:tableView];
    }
    
    return nil;
}

#pragma mark - getter
- (NSArray *)items{
    
    if (_items == nil) {
        NSArray *tempItems = [[NSArray alloc]init];
        _items = tempItems;
    }
    return _items;
}


#pragma mark - private
- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    return _items[indexPath.row];
}


// 根据cell。获取对应的 tableview
- (UITableView*)myTableView:(MyQuestionBaseCell *)baseCell{
    for (UIView* next = [baseCell superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UITableView class]]) {
            return (UITableView*)nextResponder;
        }
    }
    return nil;
}


@end
