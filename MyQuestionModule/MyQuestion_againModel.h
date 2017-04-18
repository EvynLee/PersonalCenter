//
//  MyQuestion_againModel.h
//  ZWEducation
//
//  Created by 李炜 on 2017/4/13.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyQuestion_againModel : NSObject
@property (strong, nonatomic) NSNumber *id;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *parent_id;
@property (copy, nonatomic) NSString *created_at;
@property (copy, nonatomic) NSString *updated_at;
@end
