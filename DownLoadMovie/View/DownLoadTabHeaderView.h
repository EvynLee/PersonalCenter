//
//  TabViewHeaderView.h
//  ZWEducation
//
//  Created by 李炜 on 2017/3/20.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DownLoadTabHeaderView;
/*
 定义委托方法
 */
@protocol DownSectionHeaderViewDelegate <NSObject>
-(void)sectionHeaderView:(DownLoadTabHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section;
-(void)sectionHeaderView:(DownLoadTabHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section;
-(void)allChooseHeaderBtClick:(UIButton *)btn section:(NSInteger)section;
@end

@interface DownLoadTabHeaderView : UIView
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, weak) id <DownSectionHeaderViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame
             title:(NSString*)title
             image:(NSString*)imageStr
           section:(NSInteger)sectionNumber
          delegate:(id <DownSectionHeaderViewDelegate>)delegate;

-(void)isSelect:(NSString *)isSelect;

-(void)mem_toggleOpenWithUserAction:(BOOL)userAction;

@end


