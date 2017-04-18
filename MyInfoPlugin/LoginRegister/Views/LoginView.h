//
//  LoginView.h
//  ZWEducation
//
//  Created by 李炜 on 2017/3/13.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LoginViewDelegate <NSObject>

- (void)forgetPassWord:(UIButton *)button;
- (void)registerAccount:(UIButton *)button;
-(void)loginClick:(NSString *)userName
            passWord:(NSString *)passWord;
- (void)rembPassWord:(UIButton *)button;

@end
@interface LoginView : UIView

@property (nonatomic, weak) id <LoginViewDelegate>delegate;

@end
