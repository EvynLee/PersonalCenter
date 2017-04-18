//
//  ShopAddressModel.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/22.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "ShopAddressModel.h"

@implementation ShopAddressModel

- (instancetype)initWithDict:(NSDictionary *)dic{
    
    if (self =[super init]) {
//        self.addr = dic[@"addr"];
//        self.city=dic[@"city"];
//        
//        self.name = dic[@"name"];
//        self.phone=dic[@"phone"];
//        
//        self.province = dic[@"province"];
//        self.isDefault= dic[@"isDefault"];
//        self.memberId= dic[@"isDefault"];
        [self setValuesForKeysWithDictionary:dic];
    
    }
    return self;

}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
    
        self.shopId = value;
    }
}


+ (instancetype)instanceShopModel:(NSDictionary *)dic{

    // 注意要先 alloc 才能调方法
    return [[self alloc]initWithDict:dic];

}
@end
