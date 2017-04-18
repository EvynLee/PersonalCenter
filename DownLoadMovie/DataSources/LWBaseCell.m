//
//  MovieTableViewCell.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/21.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "LWBaseCell.h"
#define kBaseCellHeight 44.0f
@implementation LWBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}




/**
 *  通过数据item更新UI
 *
 *  @param item 数据模型
 */
- (void)configureCellContentWithItem:(id)item baseCell:(LWBaseCell *)baseCell{
    
    
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
