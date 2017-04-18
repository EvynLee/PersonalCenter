//
//  PassWordModiflyVC.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/23.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "PassWordModiflyVC.h"
#import "Definition.h"
#import "Masonry.h"
#import "NetworkManager.h"
#import "NetRequestUrl.h"
@interface PassWordModiflyVC ()<UITextFieldDelegate>


@property (nonatomic, strong) UITextField *oldTextField;
@property (nonatomic, strong) UITextField *newTextField;
@property (nonatomic, strong) UITextField *valitTextField;
@property (nonatomic, strong) UILabel *tishiLabel;
@property (nonatomic, strong) UIButton *saveBt;
@end

@implementation PassWordModiflyVC

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
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.000]];
    title.text = @"密码修改";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    self.navigationItem.titleView = title;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self isLogin:^(BOOL isLogin) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!isLogin) return;
            self.oldTextField.backgroundColor       = [UIColor whiteColor];
            self.newTextField.backgroundColor       = [UIColor whiteColor];
            self.valitTextField.backgroundColor     = [UIColor whiteColor];
            self.tishiLabel.backgroundColor     = [UIColor clearColor];
            self.saveBt.backgroundColor     = [UIColor colorWithHexString:@"#33b1e0"];
            
        });
    }];
}

- (UITextField *)oldTextField{
    
    if (_oldTextField == nil) {
        _oldTextField = [[UITextField alloc]init];
         [_oldTextField setBorderStyle:UITextBorderStyleNone]; //外框类型
        _oldTextField.placeholder = @"请输入原始密码";//默认显示的字
        _oldTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _oldTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _oldTextField.returnKeyType = UIReturnKeyDone;
        _oldTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        _oldTextField.delegate = self;

        [self.view addSubview:_oldTextField];
        LWWeakSelf(self);
        [_oldTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.view.mas_top).offset(64);
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.height.equalTo(@(88/2));
        }];
        UIImageView *input = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_password"]];
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];//宽度根据需求进行设置，高度必须大于 textField 的高度
        [lv addSubview:input];
        input.center = lv.center;
        
        _oldTextField.leftView = lv;
        _oldTextField.leftViewMode =UITextFieldViewModeAlways;
    }
    return _oldTextField;
}


- (UITextField *)newTextField{
    
    if (_newTextField == nil) {
        _newTextField = [[UITextField alloc]init];
        [_newTextField setBorderStyle:UITextBorderStyleNone]; //外框类型
        _newTextField.placeholder = @"请输入新密码";//默认显示的字
        _newTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _newTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _newTextField.returnKeyType = UIReturnKeyDone;
        _newTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        _newTextField.delegate = self;
        
        [self.view addSubview:_newTextField];
        LWWeakSelf(self);
        [_newTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.oldTextField.mas_bottom).offset(1);
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.height.equalTo(@(88/2));
        }];
        UIImageView *input = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_password"]];
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];//宽度根据需求进行设置，高度必须大于 textField 的高度
        [lv addSubview:input];
        input.center = lv.center;
        
        _newTextField.leftView = lv;
        _newTextField.leftViewMode =UITextFieldViewModeAlways;
    }
    return _newTextField;
}



- (UITextField *)valitTextField{
    
    if (_valitTextField == nil) {
        _valitTextField = [[UITextField alloc]init];
        [_valitTextField setBorderStyle:UITextBorderStyleNone]; //外框类型
        _valitTextField.placeholder = @"请再次确认新密码";//默认显示的字
        _valitTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _valitTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _valitTextField.returnKeyType = UIReturnKeyDone;
        _valitTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        _valitTextField.delegate = self;
        
        [self.view addSubview:_valitTextField];
        LWWeakSelf(self);
        [_valitTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.newTextField.mas_bottom).offset(1);
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.height.equalTo(@(88/2));
        }];
        UIImageView *input = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_password"]];
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];//宽度根据需求进行设置，高度必须大于 textField 的高度
        [lv addSubview:input];
        input.center = lv.center;
        
        _valitTextField.leftView = lv;
        _valitTextField.leftViewMode =UITextFieldViewModeAlways;
    }
    return _valitTextField;
}

- (UILabel *)tishiLabel{
    
    if (_tishiLabel == nil) {
        _tishiLabel = [[UILabel alloc]init];
        _tishiLabel.textColor = [UIColor colorWithHexString:@"#eb001a"];
        [self.view addSubview:_tishiLabel];
        LWWeakSelf(self);
        [_tishiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.valitTextField.mas_bottom).offset(20/2);
            make.left.equalTo(weakself.view.mas_left).offset(10);
            make.right.equalTo(weakself.view.mas_right).offset(- 10);
          //  make.height.equalTo(@(80/2));
        }];
        
    }
    return _tishiLabel;
}


- (UIButton *)saveBt{
    
    if (_saveBt == nil) {
        _saveBt = [[UIButton alloc]init];
        [_saveBt setTitle:@"保存" forState:UIControlStateNormal];
        _saveBt.layer.cornerRadius = 10/2;
        [_saveBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveBt addTarget:self action:@selector(saveBtClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_saveBt];
        LWWeakSelf(self);
        [_saveBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.valitTextField.mas_bottom).offset(100/2);
            make.left.equalTo(weakself.view.mas_left).offset(10);
            make.right.equalTo(weakself.view.mas_right).offset(- 10);
            make.height.equalTo(@(80/2));
        }];
       
    }
    return _saveBt;
}

- (void)saveBtClick{

    //本地验证新密码是否一样
    if (![self.newTextField.text isEqualToString:self.valitTextField.text]) {
        self.tishiLabel.text = @"两次密码不一致，请重新输入";
        
        return;
    }
    //将信息上传
    
    NSDictionary *postParamDict = @{
                                    @"action" : @"appMemberAction",
                                    @"method" : @"updatePwdByOldPwd",
                                    @"data" : @{@"passWord":self.oldTextField.text,
                                                @"newPassWord":self.newTextField.text}
                                    };
    LWWeakSelf(self);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [NetworkManager POSTWithHeader:HomePageUrl params:postParamDict header:@{@"x-auth-token":[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userToken"]]} success:^(NSURLSessionDataTask *task, id responseObject, AFHTTPSessionManager *manager) {
            // weakself.responDataDic = responseObject[@"data"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself showToseMessage:responseObject[@"description"]];
//                weakself.view.userInteractionEnabled = YES;
//                if ([responseObject[@"code"] == YES]) {
//                    [weakself.navigationController popViewControllerAnimated:YES];
//                }
            });
            DLog(@"--获取验证码成功---");
            
        } fail:^(NSURLSessionDataTask *task, NSError *error, AFHTTPSessionManager *manager) {
            DLog(@"--获取验证码失败---%@",error);
        }];
    });



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
