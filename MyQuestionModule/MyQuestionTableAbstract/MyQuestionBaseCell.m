//
//  FYBaseCell.m
//  FYMenuExample
//
//  Created by 李炜 on 15/11/23.
//  Copyright © 2015年 evyn. All rights reserved.
//

#import "MyQuestionBaseCell.h"

#define kBaseCellHeight 44.0f

@implementation MyQuestionBaseCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


/**
 *  通过数据item更新UI
 *
 *  @param item 数据模型
 */
- (void)configureCellContentWithItem:(id)item{


}

- (CGFloat)configureCellHeightWithItem:(id)item{
    return kBaseCellHeight;
}

- (void)didSelectedWithItem:(id)item{
    NSLog(@"******点击了cell--item:%@******",item);
}

/**
 *  当前是第几个cell
 *
 *  @param row 第几个
 */
- (void)cellIndexPathAndRow:(NSInteger)row{


}

// cell 已经完成赋值
- (void)cellHaveFinishLayout{


}


@end
