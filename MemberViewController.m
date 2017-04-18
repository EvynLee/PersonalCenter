//
//  MemberViewController.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/1.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "MemberViewController.h"
#import "LoginRegisterViewController.h"
#import "MemberView.h"
#import "Definition.h"
#import "NetworkManager.h"
#import "NetRequestUrl.h"
#import "UIButton+WebCache.h"
#import "Notification.h"
#import "MemberMediator+MemberMediatorModuleAActions.h"//模块化组件试用

@interface MemberViewController ()<MemberViewDelegate,UINavigationControllerDelegate>
@property (nonatomic, assign)  BOOL loginValid;
/*
 userinfo
 */
@property (nonatomic, copy)  NSString *headerIconImage;
@property (nonatomic, copy)  NSString *name;
@property (nonatomic, strong)  MemberView *member;
@property (nonatomic, strong)  NSDictionary *responeDic;

@end

@implementation MemberViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"会员中心";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showActivityView:MBProgressHUDModeIndeterminate text:@"加载中..."];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self netWrokRequest];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logOutClick) name:logOutNotification  object:nil];
}

- (void)logOutClick{

    [self netWrokRequest];
}

- (void)netWrokRequest{

    NSDictionary *postParamDict = @{
                                    @"action" : @"appMemberAction",
                                    @"method" : @"getMemberInfo",
                                    @"data" : @{}
                                    };
    LWWeakSelf(self);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    [NetworkManager POSTWithHeader:HomePageUrl params:postParamDict header:@{@"x-auth-token":[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userToken"]]} success:^(NSURLSessionDataTask *task, id responseObject, AFHTTPSessionManager *manager) {
            weakself.loginValid = NO;
           weakself.responeDic = responseObject;
            if ([[NSString stringWithFormat:@"%@",responseObject[@"description"]] hasPrefix:@"需要登录"]) {
                
                weakself.loginValid = NO;
                weakself.headerIconImage = nil;
                weakself.name = nil;
            }else{
                weakself.loginValid = YES;
                weakself.headerIconImage = responseObject[@"data"][@"headImg"];
                weakself.name = responseObject[@"data"][@"nickName"];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself removeActivity];
                [weakself displayUI];
            });
        } fail:^(NSURLSessionDataTask *task, NSError *error, AFHTTPSessionManager *manager) {
                DLog(@"error:---------%@",error);
        }];
    });
}

- (void)displayUI{

    self.member = [[MemberView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.member.delegate = self;
    self.member.iconImgStr = self.headerIconImage;
    self.member.name = self.name;
    [self.view addSubview:self.member];

}
#pragma mark -- View Click Delagate
- (void)iconChooseBtClick{
    
    LWWeakSelf(self);
    [self isLogin:^(BOOL isLogin) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!isLogin) return;
          [[MemberMediator sharedInstance]openCameraOrPicture:weakself];
        });
    }];
}

-(void)myRecordClick{
    UIViewController *viewController = [[MemberMediator sharedInstance]MemberMediator_getTargetVC:kMemberStudyRecordViewController params:nil];
     [self pushVC:viewController];
 }
-(void)myCourceClick{
    
    UIViewController *viewController = [[MemberMediator sharedInstance]MemberMediator_getTargetVC:kMemberMyCourcesViewController params:nil];
    [self pushVC:viewController];

}
-(void)myQuestionClick{

    UIViewController *viewController = [[MemberMediator sharedInstance]MemberMediator_getTargetVC:kMemberMyQuestionViewController params:nil];
     [self pushVC:viewController];
}

- (void)myDownLoadClick{
    UIViewController *viewController = [[MemberMediator sharedInstance]MemberMediator_getTargetVC:kMemberMyDownLoadViewController params:nil];
    [self pushVC:viewController];
}
-(void)myOrderClick{

    [self isLogin:^(BOOL isLogin) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!isLogin) return;
            UIViewController *viewController = [[MemberMediator sharedInstance]MemberMediator_getTargetVC:kMemberMyOrderViewController params:nil];
            [self presentViewController:viewController animated:YES completion:nil];
        });
    }];
}
-(void)myFavableClick{

}
-(void)myAccountClick{
    UIViewController *viewController = [[MemberMediator sharedInstance]MemberMediator_getTargetVC:kMemberPassWordModiflyVC params:nil];
     [self pushVC:viewController];
}

-(void)setClick{
    
    UIViewController *viewController = [[MemberMediator sharedInstance]MemberMediator_getTargetVC:kMemberSettingViewController params:nil];
   [self pushVC:viewController];
}
- (void)loginClick{
    /*
     1--判断登陆状态是否有效 ？进入个人信息页面 ：进入登陆页面
        1.1-进入个人信息则不要再进行网络请求。直接传值过去
     */
    if (self.loginValid) {
        UIViewController *viewController = [[MemberMediator sharedInstance]MemberMediator_getTargetVC:kMemberMyInfomationVC params:self.responeDic];
        [self pushVC:viewController];
    }else{
       LoginRegisterViewController *loginVc = [[LoginRegisterViewController alloc]init];
        LWWeakSelf(self);
        loginVc.loginblock = ^(BOOL loginSuccess){
            [weakself netWrokRequest];
        };
        [self pushVC:loginVc];
    }
}

#pragma mark -- imagePicker Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    LWWeakSelf(self);
    [[MemberMediator sharedInstance]receiveDelegateCameraOrPicture:picker didFinishPickingMediaWithInfo:info retuenblock:^(id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.member.iconBt sd_setImageWithURL:[NSURL URLWithString:responseObject[@"data"][@"url"]] forState:UIControlStateNormal placeholderImage:nil];
        });
    }];
}
#pragma mark - public Method
- (void)pushVC:(UIViewController *)ctrl{
    [self.navigationController pushViewController:ctrl animated:YES];
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

@end
