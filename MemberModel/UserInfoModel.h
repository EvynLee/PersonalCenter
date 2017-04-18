//
//  UserInfoModel.h
//  ZWEducation
//
//  Created by 李炜 on 2017/3/22.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (copy, nonatomic) NSString *birthday;
@property (assign, nonatomic) int sex;
@property (assign, nonatomic) int status;
@property (assign, nonatomic) int regTime;


@property (copy, nonatomic) NSString *passWord;
@property (copy, nonatomic) NSString *city;
@property (assign, nonatomic) int id;


@property (assign, nonatomic) int vip;
@property (assign, nonatomic) int credits;
@property (copy, nonatomic) NSString *headImg;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *inviteCode;

@property (copy, nonatomic) NSString *province;
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *mobile;


@end
