//
//  Target_A.h
//  CTMediator
//
//  Created by casa on 16/3/13.
//  Copyright © 2016年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Target_A : NSObject

- (UIViewController *)Action_MyQuestionViewController:(NSDictionary *)params;
- (UIViewController *)Action_MyDownLoadViewController:(NSDictionary *)params;
- (UIViewController *)Action_MyOrderViewController:(NSDictionary *)params;
- (UIViewController *)Action_MyLoginController:(NSDictionary *)params;
- (UIViewController *)Action_MyInfoViewController:(NSDictionary *)params;
- (UIViewController *)Action_StudyRecordViewController:(NSDictionary *)params;
- (UIViewController *)Action_MyCourcesViewController:(NSDictionary *)params;
- (UIViewController *)Action_PassWordModiflyVC:(NSDictionary *)params;
- (UIViewController *)Action_SettingViewController:(NSDictionary *)params;

- (id)Action_nativePresentImage:(NSDictionary *)params;
- (id)Action_showAlert:(NSDictionary *)params;

// 容错
- (id)Action_nativeNoImage:(NSDictionary *)params;

@end
