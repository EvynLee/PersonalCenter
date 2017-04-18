//
//  RegisterView.h
//  ZWEducation
//
//  Created by 李炜 on 2017/3/13.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterViewDelegate <NSObject>

-(void)registerClick:(NSString *)userName
            passWord:(NSString *)passWord
          inviteCode:(NSString *)inviteCode
    verificationCode:(NSString *)verificationCode
            province:(NSString *)province
                city:(NSString *)city
                area:(NSString *)area;


-(void)verficateNumClick:(NSNumber *)flag phoneNum:(NSString *)phoneNum;

@end


@interface RegisterView : UIView


@property(nonatomic,weak)id<RegisterViewDelegate> delegate;
@property (nonatomic, strong) UIButton *verificatNumBt;

@end
