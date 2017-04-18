//
//  CityPickerView.h
//  ZWEducation
//
//  Created by 李炜 on 2017/3/30.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CityPickerViewDelegate <NSObject>

-(void)chooseCityClick:(NSDictionary *)cityDic;

@end

@interface CityPickerView : UIView
//- (void)loading;
@property(nonatomic,weak)id<CityPickerViewDelegate> delegate;
@end
