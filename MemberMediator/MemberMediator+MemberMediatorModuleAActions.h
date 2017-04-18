//
//  MemberMediator+MemberMediatorModuleAActions.h
//  ZWEducation
//
//  Created by 李炜 on 2017/4/13.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "MemberMediator.h"
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, MyMemberPushMethod) {
    kMemberMyQuestionViewController,
    kMemberMyDownLoadViewController,
    kMemberMyOrderViewController,
    kMemberMyInfomationVC,
    kMemberLoginRegisterViewController,
    kMemberStudyRecordViewController,
    kMemberMyCourcesViewController,
    kMemberPassWordModiflyVC,
    kMemberSettingViewController,
};

@interface MemberMediator (MemberMediatorModuleAActions)


/**
 页面之间跳转的统一方法

 @param methodName 目标控制器的枚举
 @return 将生成的 vc 对象交付给调用者
 */
- (UIViewController *)MemberMediator_getTargetVC:(MyMemberPushMethod)methodName params:(NSDictionary *)params;

/**
 调用相机或者相册

 @param contrl 控制器 用于设置代理和 present vc
 */
- (void)openCameraOrPicture:(UIViewController *)contrl;


/**
 控制器响应代理后传递事件
 @param responeDelegate 将数据通过block传递给调用者
 */
- (void)receiveDelegateCameraOrPicture:(UIImagePickerController *)picker
         didFinishPickingMediaWithInfo:(NSDictionary *)info
                           retuenblock:(void (^)(id responseObject))responeDelegate;
@end
