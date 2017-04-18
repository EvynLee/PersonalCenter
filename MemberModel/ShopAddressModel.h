//
//  ShopAddressModel.h
//  ZWEducation
//
//  Created by 李炜 on 2017/3/22.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopAddressModel : NSObject



@property (copy, nonatomic) NSString *addr;
@property (strong, nonatomic) NSNumber * shopId;
@property (strong, nonatomic) NSNumber * isDefault;
@property (strong, nonatomic) NSNumber * memberId;


@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *province;

+ (instancetype)instanceShopModel:(NSDictionary *)dic;

@end
