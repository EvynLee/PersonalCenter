//
//  MemberView.h
//  ZWEducation
//
//  Created by 李炜 on 2017/3/22.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MemberViewDelegate <NSObject>

-(void)myRecordClick;
-(void)myCourceClick;
-(void)myQuestionClick;
-(void)myDownLoadClick;
-(void)myOrderClick;
-(void)myFavableClick;
-(void)myAccountClick;
-(void)setClick;
-(void)loginClick;
-(void)iconChooseBtClick;

@end
@interface MemberView : UIView

@property(nonatomic,weak)id<MemberViewDelegate> delegate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSString *iconImgStr;
@property (nonatomic, strong) UIButton *  iconBt;

@end
