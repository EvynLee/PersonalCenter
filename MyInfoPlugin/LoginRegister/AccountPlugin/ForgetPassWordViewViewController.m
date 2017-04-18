//
//  ForgetPassWordViewViewController.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/13.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "ForgetPassWordViewViewController.h"
#import "ForgetPassWordView.h"
#import "Definition.h"
#import "NetworkManager.h"
#import "ZLAlertView.h"
#import "NetRequestUrl.h"
#import "AppDelegate.h"
@interface ForgetPassWordViewViewController ()<ForgetPassWordViewDelegate>
@property (nonatomic, strong) ForgetPassWordView * forgetView;
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, assign)  NSInteger countDown;
@end

@implementation ForgetPassWordViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.forgetView = [[ForgetPassWordView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.forgetView.delegate = self;
    UIImageView *backGroundImge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_bg"]];
    backGroundImge.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:backGroundImge];
     backGroundImge.userInteractionEnabled = YES;
    [backGroundImge addSubview:self.forgetView];
}


#pragma mark -- forgetView delegate
-(void)resetClick:(NSString *)userName
         passWord:(NSString *)passWord
    verficNumCode:(NSString *)verficNumCode{


    
    NSDictionary *postParamDict = @{
                                    @"action" : @"appMemberAction",
                                    @"method" : @"updatePassWord",
                                    @"data" : @{@"mobile":userName,
                                                @"passWord":passWord,
                                                @"verificationCode":verficNumCode}
                                    };
    LWWeakSelf(self);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [NetworkManager POST:HomePageUrl params:postParamDict success:^(NSURLSessionDataTask *task, id responseObject, AFHTTPSessionManager *manager) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself showToseMessage:responseObject[@"description"]];
                 weakself.view.userInteractionEnabled =YES;
            });
            
            if ([responseObject[@"code"] isEqualToNumber:@0]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error, AFHTTPSessionManager *manager) {
                DLog(@"-修改密码成功失败 失败---%@",error);
        }];
    });

    

}


- (void)verficateNumClick:(NSNumber *)flag phoneNum:(NSString *)phoneNum{

    self.forgetView.verificatNumBt.userInteractionEnabled = NO;
    self.forgetView.verificatNumBt.backgroundColor = [UIColor grayColor];
    [self.forgetView.verificatNumBt setTitle:@"60s" forState:UIControlStateNormal];
    self.countDown = 60;
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    
    NSDictionary *postParamDict = @{
                                    @"action" : @"appMemberAction",
                                    @"method" : @"sendVerificationCode",
                                    @"data" : @{@"type":[NSString stringWithFormat:@"%@",flag],
                                                @"mobile":phoneNum}
                                    };
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [NetworkManager POST:HomePageUrl params:postParamDict success:^(NSURLSessionDataTask *task, id responseObject, AFHTTPSessionManager *manager) {
            DLog(@"--获取验证码成功---");
            
        } fail:^(NSURLSessionDataTask *task, NSError *error, AFHTTPSessionManager *manager) {
            DLog(@"--获取验证码失败---%@",error);
        }];
    });


}

- (void)timeFireMethod{
    self.countDown --;
    [self.forgetView.verificatNumBt setTitle: [NSString stringWithFormat:@"%zds",self.countDown] forState:UIControlStateNormal];
    if (self.countDown ==0) {
        [self.countDownTimer  invalidate];
        self.forgetView.verificatNumBt.userInteractionEnabled = YES;
        self.forgetView.verificatNumBt.backgroundColor = [UIColor colorWithHexString:@"#33b1e0"];
        [self.forgetView.verificatNumBt setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.forgetView.verificatNumBt.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
