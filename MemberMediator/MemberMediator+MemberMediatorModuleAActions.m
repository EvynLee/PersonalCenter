//
//  MemberMediator+MemberMediatorModuleAActions.m
//  ZWEducation
//
//  Created by 李炜 on 2017/4/13.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "MemberMediator+MemberMediatorModuleAActions.h"
#import "Definition.h"
#import "NetworkManager.h"
#import "NetRequestUrl.h"
NSString * const kMemberMediatorTargetA = @"A";

@implementation MemberMediator (MemberMediatorModuleAActions)

- (UIViewController *)MemberMediator_getTargetVC:(MyMemberPushMethod)methodName params:(NSDictionary *)params
{
    UIViewController *viewController = [self performTarget:kMemberMediatorTargetA
                                                    action:[self enumTransLateToString:methodName]
                                                    params:params
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}



- (void)openCameraOrPicture:(UIViewController *)contrl{
    UIAlertController *alertController = [[UIAlertController alloc]init];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"拍照获取" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear] || [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            UIImagePickerController * camePicker = [[UIImagePickerController alloc]init];
            camePicker.delegate = contrl;
            camePicker.allowsEditing = YES;
            camePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
           [contrl presentViewController:camePicker animated:YES completion:nil];
            
        }else{
          //  [self showToseMessage:@"未检测到摄像头"];
        }
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"像册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
        
        [contrl presentViewController:imagePicker animated:YES completion:^{
            imagePicker.delegate=contrl;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [contrl presentViewController:alertController animated:YES completion:nil];

}





- (void)receiveDelegateCameraOrPicture:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info retuenblock:(void (^)(id responseObject))responeDelegate{

    UIImage * image  = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    // 设置比例（比例放大）
    NSData * data  = UIImagePNGRepresentation(image);
    float scale = 0.0;
    if (data.length>30) {
        scale=30.0/data.length;
    }
    
    NSData * fixedData = UIImageJPEGRepresentation(image, scale);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NetworkManager POSTImageData:POSTImageDataUrl data:fixedData params:nil header:@{@"x-auth-token":[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userToken"]]} success:^(NSURLSessionDataTask *task, id responseObject, AFHTTPSessionManager *manager) {
            responeDelegate(responseObject);
            NSDictionary *postParamDict = @{
                                            @"action" : @"appMemberAction",
                                            @"method" : @"updateMemberBean",
                                            @"data" : @{@"headImg":responseObject[@"data"][@"url"]}
                                            };
            [NetworkManager POSTWithHeader:HomePageUrl params:postParamDict header:@{@"x-auth-token":[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userToken"]]} success:^(NSURLSessionDataTask *task, id responseObject, AFHTTPSessionManager *manager) {
              //  DLog(@"更新结果-----%@",responseObject[@"description"]);
            } fail:^(NSURLSessionDataTask *task, NSError *error, AFHTTPSessionManager *manager) {
               // DLog(@"error:---------%@",error);
            }];
        } fail:^(NSURLSessionDataTask *task, NSError *error, AFHTTPSessionManager *manager) {
              //  NSLog(@"error==========%@",error);
        }];
    });
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
   
    
}


- (NSString *)enumTransLateToString:(MyMemberPushMethod)methodNmae{
    switch (methodNmae) {
        case kMemberMyQuestionViewController:
            return @"MyQuestionViewController";
        case kMemberMyDownLoadViewController:
            return @"MyDownLoadViewController";
        case kMemberMyOrderViewController:
            return @"MyOrderViewController";
        case kMemberMyInfomationVC:
            return @"MyInfoViewController";
        case kMemberLoginRegisterViewController:
            return @"MyLoginController";
        case kMemberStudyRecordViewController:
            return @"StudyRecordViewController";
        case kMemberMyCourcesViewController:
            return @"MyCourcesViewController";
        case kMemberPassWordModiflyVC:
            return @"PassWordModiflyVC";
        case kMemberSettingViewController:
            return @"SettingViewController";
        default:
            return @"";
    }
}
@end
