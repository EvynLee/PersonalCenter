//
//  Target_A.m
//  CTMediator
//
//  Created by casa on 16/3/13.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "Target_A.h"
#import "MyQuestionModuleViewController.h"
#import "DownLoadViewController.h"
#import "OrderFormViewController.h"
#import "MyInfomationVC.h"
#import "LoginRegisterViewController.h"
#import "MyCourcesViewController.h"
#import "PassWordModiflyVC.h"
#import "StudyRecordViewController.h"
#import "SettingViewController.h"
typedef void (^CTUrlRouterCallbackBlock)(NSDictionary *info);

@implementation Target_A

- (UIViewController *)Action_MyQuestionViewController:(NSDictionary *)params
{
    // 因为action是从属于ModuleA的，所以action直接可以使用ModuleA里的所有声明
    MyQuestionModuleViewController *viewController = [[MyQuestionModuleViewController alloc] init];
   
    return viewController;
}

- (UIViewController *)Action_MyDownLoadViewController:(NSDictionary *)params{

    // 因为action是从属于ModuleA的，所以action直接可以使用ModuleA里的所有声明
    DownLoadViewController *viewController = [[DownLoadViewController alloc] init];
    
    return viewController;


}
- (UIViewController *)Action_MyOrderViewController:(NSDictionary *)params{

    // 因为action是从属于ModuleA的，所以action直接可以使用ModuleA里的所有声明
    OrderFormViewController *viewController = [[OrderFormViewController alloc] init];
    
    return viewController;
 
}

- (UIViewController *)Action_MyLoginController:(NSDictionary *)params{
    
    LoginRegisterViewController *loginVc = [[LoginRegisterViewController alloc]init];
    return loginVc;
}

- (UIViewController *)Action_MyInfoViewController:(NSDictionary *)params{

            MyInfomationVC *info = [[MyInfomationVC alloc]init];
            info.iconImageStr = params[@"data"][@"headImg"];
            info.accountStr = [NSString stringWithFormat:@"%@",params[@"data"][@"userName"]];
            info.nickNameStr = params[@"data"][@"nickName"];
            info.sexStr = [params[@"data"][@"sex"] stringValue];
            info.birthStr = params[@"data"][@"birthday"];
            info.cityStr = params[@"data"][@"city"];
            info.provinceStr = params[@"data"][@"province"];
            info.inventStr = params[@"data"][@"inviteCode"];
            info.addressDic =  params[@"data"][@"shopAddr"];

    
    return info;
}

- (UIViewController *)Action_StudyRecordViewController:(NSDictionary *)params{
    StudyRecordViewController *recVC = [[StudyRecordViewController alloc]init];
    return recVC;
    
}
- (UIViewController *)Action_MyCourcesViewController:(NSDictionary *)params{

    MyCourcesViewController * myCou = [[MyCourcesViewController alloc]init];
    return myCou;
}
- (UIViewController *)Action_PassWordModiflyVC:(NSDictionary *)params{
    PassWordModiflyVC * passWord = [[PassWordModiflyVC alloc]init];
    return passWord;

}

- (UIViewController *)Action_SettingViewController:(NSDictionary *)params{
    SettingViewController * setting = [[SettingViewController alloc]init];
    return setting;
}
- (id)Action_nativePresentImage:(NSDictionary *)params
{
        return nil;
}

- (id)Action_showAlert:(NSDictionary *)params
{
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CTUrlRouterCallbackBlock callback = params[@"cancelAction"];
        if (callback) {
            callback(@{@"alertAction":action});
        }
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CTUrlRouterCallbackBlock callback = params[@"confirmAction"];
        if (callback) {
            callback(@{@"alertAction":action});
        }
    }];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"alert from Module A" message:params[@"message"] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    return nil;
}

- (id)Action_nativeNoImage:(NSDictionary *)params
{
//    DemoModuleADetailViewController *viewController = [[DemoModuleADetailViewController alloc] init];
//    viewController.valueLabel.text = @"no image";
//    viewController.imageView.image = [UIImage imageNamed:@"noImage"];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:nil];
    
    return nil;
}

- (UITableViewCell *)Action_cell:(NSDictionary *)params
{
    UITableView *tableView = params[@"tableView"];
    NSString *identifier = params[@"identifier"];
    
    // 这里的TableViewCell的类型可以是自定义的，我这边偷懒就不自定义了。
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)Action_configCell:(NSDictionary *)params
{
    NSString *title = params[@"title"];
    NSIndexPath *indexPath = params[@"indexPath"];
    UITableViewCell *cell = params[@"cell"];
    
    // 这里的TableViewCell的类型可以是自定义的，我这边偷懒就不自定义了。
    cell.textLabel.text = [NSString stringWithFormat:@"%@,%ld", title, (long)indexPath.row];
    
//    if ([cell isKindOfClass:[XXXXXCell class]]) {
//        正常情况下在这里做特定cell的赋值，上面就简单写了
//    }
    
    return nil;
}

@end
