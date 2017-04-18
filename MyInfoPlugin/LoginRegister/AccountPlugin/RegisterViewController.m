//
//  RegisterViewController.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/13.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "RegisterViewController.h"
#import "Definition.h"
#import "RegisterView.h"
#import "NetworkManager.h"
#import "NetRequestUrl.h"
#import "ZLAlertView.h"
#import "LoginRegisterViewController.h"
@interface RegisterViewController ()<RegisterViewDelegate>
@property (nonatomic, strong) NSMutableDictionary *responDataDic;
@property (nonatomic, strong) RegisterView * rgetView;
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, assign)  NSInteger countDown;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"注册";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    self.navigationItem.titleView = title;
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.rgetView = [[RegisterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.rgetView.delegate = self;
    UIImageView *backGroundImge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_bg"]];
    backGroundImge.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    backGroundImge.userInteractionEnabled = YES;
    [self.view addSubview:backGroundImge];
    [backGroundImge addSubview:self.rgetView];
}

//注册
- (void)registerClick:(NSString *)userName
             passWord:(NSString *)passWord
           inviteCode:(NSString *)inviteCode
     verificationCode:(NSString *)verificationCode
             province:(NSString *)province
                 city:(NSString *)city
                 area:(NSString *)area{
    
    
    if (![userName  isEqual: @""] && ![passWord  isEqual: @""] &&  ![verificationCode  isEqual: @""] &&  ![province  isEqual: @""] &&  ![city  isEqual: @""]){
        
      
        NSDictionary *postParamDict = @{
                                        @"action": @"appMemberAction",
                                        @"method":@"regMember",
                                        @"data":@{
                                            @"userName":userName, //手机号
                                            @"passWord":passWord, //密码
                                            @"inviteCode":inviteCode, //邀请码 可不填
                                            @"verificationCode":verificationCode, //短信验证码
                                            @"province":province, //省份名
                                            @"city":city, //城市名
                                            @"area":area, //城市名
                                        }
                                        };
        LWWeakSelf(self);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [NetworkManager POST:HomePageUrl params:postParamDict success:^(NSURLSessionDataTask *task, id responseObject, AFHTTPSessionManager *manager) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself showToseMessage:responseObject[@"description"]];
                    weakself.view.userInteractionEnabled = YES;
                    if ([responseObject[@"description"] isEqualToString:@"注册成功"]) {
                        [weakself.navigationController popViewControllerAnimated:YES];
                    }
                });

            } fail:^(NSURLSessionDataTask *task, NSError *error, AFHTTPSessionManager *manager) {
                DLog(@"-----%@",error);
            }];
        });
    }else{
                [self showToseMessage:@"信息填写错误"];
                 self.view.userInteractionEnabled = YES;
    }
}
//获取验证码
- (void)verficateNumClick:(NSNumber *)flag phoneNum:(NSString *)phoneNum{

    
    self.rgetView.verificatNumBt.userInteractionEnabled = NO;
    self.rgetView.verificatNumBt.backgroundColor = [UIColor grayColor];
    [self.rgetView.verificatNumBt setTitle:@"60s" forState:UIControlStateNormal];
    self.countDown = 60;
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];//
    
    NSDictionary *postParamDict = @{
                                   @"action" : @"appMemberAction",
                                   @"method" : @"sendVerificationCode",
                                   @"data" : @{@"type":[NSString stringWithFormat:@"%@",flag],
                                               @"mobile":phoneNum}
                                   };
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [NetworkManager POST:HomePageUrl params:postParamDict success:^(NSURLSessionDataTask *task, id responseObject, AFHTTPSessionManager *manager) {
            // weakself.responDataDic = responseObject[@"data"];
            DLog(@"--获取验证码成功---");
            
        } fail:^(NSURLSessionDataTask *task, NSError *error, AFHTTPSessionManager *manager) {
            DLog(@"--获取验证码失败---%@",error);
        }];
    });


}

- (void)timeFireMethod{
    self.countDown --;
    [self.rgetView.verificatNumBt setTitle: [NSString stringWithFormat:@"%zds",self.countDown] forState:UIControlStateNormal];
    if (self.countDown ==0) {
        [self.countDownTimer  invalidate];
        self.rgetView.verificatNumBt.userInteractionEnabled = YES;
        self.rgetView.verificatNumBt.backgroundColor = [UIColor colorWithHexString:@"#33b1e0"];
        [self.rgetView.verificatNumBt setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.rgetView.verificatNumBt.titleLabel.adjustsFontSizeToFitWidth = YES;
        
    }

}

- (NSMutableDictionary *)responDataDic{
    
    if (_responDataDic == nil) {
        _responDataDic  = [NSMutableDictionary dictionary];
    }
    
    return _responDataDic;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
