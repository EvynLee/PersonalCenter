//
//  DownLoadCell.h
//  ZWEducation
//
//  Created by 李炜 on 2017/3/27.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "LWBaseCell.h"
@class DownLoadCell;
@protocol DownLoadBtnClickDelegate <NSObject>

- (void)chapterChooseButtonClick:(NSString *)sectionLabelTxt cell:(DownLoadCell *)cell button:(UIButton *)button;
//- (void)singleCellChooseClick:(UIView *)button;
@end
@interface DownLoadCell : LWBaseCell
@property (nonatomic, weak) id <DownLoadBtnClickDelegate>delegate;
@end
