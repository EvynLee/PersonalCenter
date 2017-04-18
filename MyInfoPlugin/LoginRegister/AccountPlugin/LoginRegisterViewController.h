//
//  LoginRegisterViewController.h
//  ZWEducation
//
//  Created by 李炜 on 2017/3/13.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "ZWBaseViewController.h"

typedef void(^loginBlock)(BOOL loginSuccess);
@interface LoginRegisterViewController : ZWBaseViewController
@property(nonatomic,copy)loginBlock loginblock;

@end
