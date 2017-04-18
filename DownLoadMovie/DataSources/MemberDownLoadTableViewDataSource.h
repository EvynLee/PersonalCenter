//
//  DetailMovieTableViewDataSource.h
//  ZWEducation
//
//  Created by 李炜 on 2017/3/21.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Video.h"

typedef NS_ENUM(NSInteger, kFYCellType){
    kFYCellTypeDefault = 0,
};

@protocol MemDownLoadDataSourceDelegate <NSObject>

#pragma mark-- 用代理方法将FYDataSource 与 视图控制器绑定事件传递
@optional
- (void)didSelectedCellWithItem:(Video *)video didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForHeaderInSection:(NSInteger)section tableView:(UITableView *)tableView;
- (UIView *)viewForHeaderInSection:(NSInteger)section tableView:(UITableView *)tableView;
- (CGFloat)heightForFooterInSection:(NSInteger)section tableView:(UITableView *)tableView;
- (UIView *)viewForFooterInSection:(NSInteger)section tableView:(UITableView *)tableView;
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView;

@end

@interface MemberDownLoadTableViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *currentTableView;
@property (nonatomic, strong)       NSArray *items;
@property (nonatomic, strong)       NSArray *uiItems;
@property (nonatomic, assign) id<MemDownLoadDataSourceDelegate>  delegate;

/**
 *  创建一个DetailMovieTableViewDataSource对象
 *
 *  @param items          模型数组
 *  @param cellIdentifier cell的缓存标识符
 *  @param cellType       cell类型
 *
 *  @return 实例好的FYDataSource对象
 */
- (instancetype)initWithItems:(NSArray *)items
                       uitems:(NSArray *)uiItems
                     cellName:(NSString *)cellClassName
               cellIdentifier:(NSString *)cellIdentifier
                     cellType:(kFYCellType)cellType;


@end
