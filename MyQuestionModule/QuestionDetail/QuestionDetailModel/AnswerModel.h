//
//  AnswerModel.h
//  ZWEducation
//
//  Created by 李炜 on 2017/4/14.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
@interface AnswerModel : NSObject
@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSNumber *user_id;
@property (strong, nonatomic) NSNumber *question_id;

@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *comments;
@property (copy, nonatomic) NSString *created_at;
@property (copy, nonatomic) NSString *updated_at;
@property (strong, nonatomic) NSNumber  *views;

@property (strong, nonatomic) UserModel  *user;

@end
