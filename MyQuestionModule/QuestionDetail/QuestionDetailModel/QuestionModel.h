//
//  QuestionModel.h
//  ZWEducation
//
//  Created by 李炜 on 2017/4/14.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyQuestion_againModel;
@class MyQuestionCategoryModel;
@class UserModel;
@interface QuestionModel : NSObject

@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSNumber *user_id;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *descrip;
@property (strong, nonatomic) NSNumber *answers;
@property (copy, nonatomic) NSString *created_at;
@property (copy, nonatomic) NSString *updated_at;
@property (strong, nonatomic) NSNumber  *views;

@property (strong, nonatomic) MyQuestion_againModel *question_again;
@property (strong, nonatomic) MyQuestionCategoryModel *category;
@property (strong, nonatomic) UserModel   *user;
@end
