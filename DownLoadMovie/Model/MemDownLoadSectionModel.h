//
//  MemDownLoadSectionModel.h
//  ZWEducation
//
//  Created by 李炜 on 2017/3/27.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemDownLoadSectionModel : NSObject

@property (copy, nonatomic) NSString *mainName;//课程简介
@property (copy, nonatomic) NSString *mainimage;
@property (copy, nonatomic) NSString *isSelect;
@property (copy, nonatomic) NSMutableArray *chapterList;


@end
