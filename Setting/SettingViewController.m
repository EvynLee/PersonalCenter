//
//  SettingViewController.m
//  ZWEducation
//
//  Created by 李炜 on 2017/4/10.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "SettingViewController.h"
#import "NSObject+ColorHex.h"
#import "Definition.h"
#import "Masonry.h"
#import "Notification.h"
#import "AboutMeViewController.h"
@interface SettingViewController ()
@property (nonatomic, strong) UIImageView *aboutMeView;
@property (nonatomic, strong) UIButton *logOutBtn;
@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"设置";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    self.navigationItem.titleView = title;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.000]];
    [self aboutMeView];
    
    [self isLogin:^(BOOL isLogin) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!isLogin) return;
                
                [self logOutBtn];
         });
    }];
    
    
}


- (UIImageView *)aboutMeView{
    
    if (_aboutMeView == nil) {
        _aboutMeView = [[UIImageView alloc]init];
        [self.view addSubview:_aboutMeView];
        LWWeakSelf(self);
        [_aboutMeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.view.mas_top).offset(64);
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"关于我们";
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_aboutMeView addSubview:label];
        
  
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.aboutMeView);
            make.left.equalTo(weakself.aboutMeView.mas_left).mas_offset(23/2);
            
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        [_aboutMeView addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.aboutMeView);
            make.right.equalTo(weakself.aboutMeView.mas_right).mas_offset(-(20/2));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myaboutMeView)];
        _aboutMeView.userInteractionEnabled = YES;
        [_aboutMeView addGestureRecognizer:tap];
    }
    return _aboutMeView;
}



- (UIButton *)logOutBtn{
    
    if (_logOutBtn == nil) {
        
        
        _logOutBtn = [[UIButton alloc]init];
        [self.view addSubview:_logOutBtn];
        _logOutBtn.layer.cornerRadius = 20/2;
        _logOutBtn.backgroundColor = [UIColor colorWithHexString:@"#33b1e0"];
        [_logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logOutBtn addTarget:self action:@selector(logOutBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        LWWeakSelf(self);
        [weakself.logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.aboutMeView.mas_bottom).with.offset((20));
            make.left.equalTo(weakself.view.mas_left).with.offset(25/2);
            make.right.equalTo(weakself.view.mas_right).with.offset(-(25/2));
            make.height.equalTo(@(82/2));
            
        }];
        
    }
    return _logOutBtn;
}

/*
 退出登录
 */
- (void)logOutBtnClicked:(UIButton *)btn{

    /*
     1--清空本地token
     2--通知上一个页面刷新网络请求
     */
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"userToken"] isEqualToString:@"noLogin"] || [[NSUserDefaults standardUserDefaults]objectForKey:@"userToken"]==nil) return;//已经处于退出登录状态
    [[NSUserDefaults standardUserDefaults]setObject:@"noLogin" forKey:@"userToken"];
    [[NSNotificationCenter defaultCenter]postNotificationName:logOutNotification object:nil];
    [self showToseMessage:@"退出成功"];
    self.view.userInteractionEnabled = YES;

}

- (void)myaboutMeView{

    AboutMeViewController * aboutMe = [[AboutMeViewController alloc]init];
    [self.navigationController pushViewController:aboutMe animated:YES];
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];// 修改下级页面的返回按钮，此处我是很想写到videoController中，但是backBarButtonItem的机制决定必须写在A中；
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
