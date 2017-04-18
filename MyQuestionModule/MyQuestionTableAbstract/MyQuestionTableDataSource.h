//
//  FYDataSource.h
//  FYMenuExample
//
//  Created by 李炜 on 15/11/23.
//  Copyright © 2015年 evyn. All rights reserved.
//



#import <Foundation/Foundation.h>

@class MyQuestionBaseCell;

typedef NS_ENUM(NSInteger, kFYCellType){
    kFYCellTypeDefault = 0,
};

@protocol MyQuestionDataSourceDelegate <NSObject>

#pragma mark-- 用代理方法将FYDataSource 与 视图控制器绑定事件传递
@optional

- (void)didSelectedCellWithItem:(id)item tableView:(UITableView *)tableView;
- (CGFloat)heightForHeaderInSection:(NSInteger)section tableView:(UITableView *)tableView;
- (UIView *)viewForHeaderInSection:(NSInteger)section tableView:(UITableView *)tableView;
- (CGFloat)heightForFooterInSection:(NSInteger)section tableView:(UITableView *)tableView;
- (UIView *)viewForFooterInSection:(NSInteger)section tableView:(UITableView *)tableView;
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView;

@end

@interface MyQuestionTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)       NSArray *items;
@property (nonatomic, assign) id<MyQuestionDataSourceDelegate>  delegate;

/**
 *  创建一个FYDataSource对象
 *
 *  @param items          模型数组
 *  @param cellIdentifier cell的缓存标识符
 *  @param cellType       cell类型
 *  @return 实例好的FYDataSource对象
 */
- (instancetype)initWithItems:(NSArray *)items
                     cellName:(NSString *)cellClassName
               cellIdentifier:(NSString *)cellIdentifier
                     cellType:(kFYCellType)cellType;

@end
