//
//  LoginRegisterViewController.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/13.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "LoginRegisterViewController.h"
#import "LoginView.h"
#import "Definition.h"
#import "ForgetPassWordViewViewController.h"
#import "RegisterViewController.h"
#import "NetworkManager.h"
#import "ZLAlertView.h"
#import "NetRequestUrl.h"
#import "AppDelegate.h"
@interface LoginRegisterViewController ()<LoginViewDelegate>

@end

@implementation LoginRegisterViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"登陆";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    self.navigationItem.titleView = title;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    LoginView * loginView = [[LoginView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    loginView.delegate = self;
    UIImageView *backGroundImge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_bg"]];
    backGroundImge.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    backGroundImge.userInteractionEnabled = YES;
    [self.view addSubview:backGroundImge];
    [backGroundImge addSubview:loginView];
}

#pragma mark --LoginView Delegate
- (void)forgetPassWord:(UIButton *)button{

    ForgetPassWordViewViewController * forget = [[ForgetPassWordViewViewController alloc]init];
    [self.navigationController pushViewController:forget animated:YES];

}

- (void)registerAccount:(UIButton *)button{

    RegisterViewController * reg = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:reg animated:YES];

}

- (void)loginClick:(NSString *)userName passWord:(NSString *)passWord{

    NSDictionary *postParamDict = @{
                                    @"action" : @"appMemberAction",
                                    @"method" : @"login",
                                    @"data" : @{@"userName":userName,
                                                @"passWord":passWord}
                                    };
    LWWeakSelf(self);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [NetworkManager POST:HomePageUrl params:postParamDict success:^(NSURLSessionDataTask *task, id responseObject, AFHTTPSessionManager *manager) {
            NSLog(@"description===%@",responseObject[@"description"]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself showToseMessage:responseObject[@"description"]];
                 weakself.view.userInteractionEnabled =YES;
            });
            
            
            if ([responseObject[@"code"] isEqualToNumber:@0]) {
               
                NSDictionary *data = responseObject[@"data"];
                // 获取相应头的内容
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                NSDictionary *allHeaders = response.allHeaderFields;//x-auth-token
                [AppDelegate shareAppDelegate].userToken = allHeaders[@"x-auth-token"];
                [[NSUserDefaults standardUserDefaults]setObject:allHeaders[@"x-auth-token"] forKey:@"userToken"];
                [[NSUserDefaults standardUserDefaults]setObject:data[@"id"] forKey:@"userid"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.navigationController popViewControllerAnimated:YES];
                });
                
                
                
               self.loginblock(YES);
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error, AFHTTPSessionManager *manager) {
                DLog(@"--deng lu 失败---%@",error);
        }];
    });
}


- (void)rembPassWord:(UIButton *)button{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

@end
