//
//  ForgetPassWordView.h
//  ZWEducation
//
//  Created by 李炜 on 2017/3/13.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ForgetPassWordViewDelegate <NSObject>

-(void)resetClick:(NSString *)userName
            passWord:(NSString *)passWord
          verficNumCode:(NSString *)verficNumCode;


-(void)verficateNumClick:(NSNumber *)flag phoneNum:(NSString *)phoneNum;


@end

@interface ForgetPassWordView : UIView

@property(nonatomic,weak)id<ForgetPassWordViewDelegate> delegate;
@property (nonatomic, strong) UIButton *verificatNumBt;

@end
