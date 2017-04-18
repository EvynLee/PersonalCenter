//
//  FYBaseCell.h
//  FYMenuExample
//
//  Created by 李炜 on 15/11/23.
//  Copyright © 2015年 evyn. All rights reserved.//

#import <UIKit/UIKit.h>

@interface MyQuestionBaseCell : UITableViewCell
/**
 *  通过数据item更新UI
 *     
 *  @param item 数据模型
 */
- (void)configureCellContentWithItem:(id)item;

/**
 *  获取某个cell的高度
 *
 *  @param item 数据模型
 *
 *  @return cell的高度
 */
- (CGFloat)configureCellHeightWithItem:(id)item;

/**
 *  cell点击事件,传入item
 *
 *  @param item 数据模型
 */
- (void)didSelectedWithItem:(id)item;

/**
 *  当前是第几个cell
 *
 *  @param row 第几个
 */
- (void)cellIndexPathAndRow:(NSInteger)row;

/**
 *  cell已经完成赋值
 */
- (void)cellHaveFinishLayout;

@end
