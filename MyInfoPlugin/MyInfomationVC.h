//
//  MyInfomationVC.h
//  ZWEducation
//
//  Created by 李炜 on 2017/3/22.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "ZWBaseViewController.h"

@interface MyInfomationVC : ZWBaseViewController

@property (nonatomic, copy) NSString *iconImageStr;
@property (nonatomic, copy) NSString *accountStr;
@property (nonatomic, copy) NSString *nickNameStr;
@property (nonatomic, copy) NSString *sexStr;
@property (nonatomic, copy) NSString *birthStr;
@property (nonatomic, copy) NSString *cityStr;
@property (nonatomic, copy) NSString *provinceStr;
@property (nonatomic, copy) NSString *inventStr;
@property (nonatomic, strong) NSDictionary *addressDic;
@end
