//
//  LoginView.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/13.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "LoginView.h"
#import "Definition.h"
#import "Masonry.h"
#import "NSObject+ColorHex.h"
@interface LoginView ()

@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UITextField *accountFild;
@property (nonatomic, strong) UITextField *passWordFild;



@property (nonatomic, strong) UIButton *rembPassWordBt;
@property (nonatomic, strong) UILabel *rembPassWordLabel;
@property (nonatomic, strong) UIButton *forgetButton;

@property (nonatomic, strong) UIButton *loginBt;
@property (nonatomic, strong) UIButton *registerBt;


@end
@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.iconImage.backgroundColor = [UIColor clearColor];
        self.accountFild.backgroundColor = [UIColor whiteColor];
        self.passWordFild.backgroundColor = [UIColor whiteColor];
        self.rembPassWordBt.backgroundColor = [UIColor clearColor];
        self.rembPassWordLabel.hidden = YES;
        self.forgetButton.backgroundColor = [UIColor clearColor];
        self.loginBt.backgroundColor = [UIColor colorWithHexString:@"#33b1e0"];
        self.registerBt.backgroundColor = [UIColor clearColor];
    }
    return self;
    
}


- (UIImageView *)iconImage{
    
    if (_iconImage == nil) {
        
   
    _iconImage = [[UIImageView alloc]init];
    [self addSubview:_iconImage];
        _iconImage.image = [UIImage imageNamed:@"login_head"];
    LWWeakSelf(self);
    [weakself.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakself);
        make.top.equalTo(weakself.mas_top).with.offset(78/2 + 64);
        make.width.equalTo(@(180/2));
        make.height.equalTo(@(180/2));
        
    }];
    
     }
    return _iconImage;
}


- (UITextField *)accountFild{
    
    if (_accountFild == nil) {
        
        
        _accountFild = [[UITextField alloc]init];
        [self addSubview:_accountFild];
        _accountFild.layer.borderWidth = 1.0f;
        _accountFild.layer.cornerRadius = 41/2;
        _accountFild.layer.borderColor = [UIColor colorWithHexString:@"#33b1e0"].CGColor;
        _accountFild.placeholder = @"请输入手机号";
        _accountFild.clearButtonMode=UITextFieldViewModeWhileEditing;
        
        UIImageView *input = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_phone"]];
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];//宽度根据需求进行设置，高度必须大于 textField 的高度
        [lv addSubview:input];
        input.center = lv.center;
       
        _accountFild.leftView = lv;
        _accountFild.leftViewMode =UITextFieldViewModeAlways;
        
        LWWeakSelf(self);
        [weakself.accountFild mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(weakself.iconImage.mas_bottom).with.offset((70/2));
            make.left.equalTo(weakself.mas_left).with.offset(80/2);
            make.right.equalTo(weakself.mas_right).with.offset(-(80/2));
            make.height.equalTo(@(82/2));
            
        }];
        
    }
    return _accountFild;
}


- (UITextField *)passWordFild{
    
    if (_passWordFild == nil) {
        
        
        _passWordFild = [[UITextField alloc]init];
        LWWeakSelf(self);
        _passWordFild.layer.borderWidth = 1.0f;
        _passWordFild.layer.cornerRadius = 41/2;
        _passWordFild.layer.borderColor = [UIColor colorWithHexString:@"#33b1e0"].CGColor;
        
        
        _passWordFild.placeholder = @"请输入密码";
        _passWordFild.clearButtonMode=UITextFieldViewModeWhileEditing;
        
        UIImageView *input = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_password"]];
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];//宽度根据需求进行设置，高度必须大于 textField 的高度
        [lv addSubview:input];
        input.center = lv.center;
        
        _passWordFild.leftView = lv;
        _passWordFild.leftViewMode =UITextFieldViewModeAlways;
        _passWordFild.secureTextEntry = YES;
        
        [self addSubview:_passWordFild];
        [weakself.passWordFild mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakself.accountFild.mas_bottom).with.offset((30/2));
            make.centerX.equalTo(weakself.accountFild.mas_centerX);
            make.width.equalTo(weakself.accountFild);
            make.height.equalTo(@(82/2));
            
            
        }];
        
    }
    return _passWordFild;
}


- (UIButton *)rembPassWordBt{
    
    if (_rembPassWordBt == nil) {
        
        
        _rembPassWordBt = [[UIButton alloc]init];
        _rembPassWordBt.hidden = YES;
        [_rembPassWordBt setImage:[UIImage imageNamed:@"keep_password_empty"] forState:UIControlStateNormal];
        LWWeakSelf(self);
        [self addSubview:_rembPassWordBt];
        [weakself.rembPassWordBt mas_makeConstraints:^(MASConstraintMaker *make) {
            
             make.top.equalTo(weakself.passWordFild.mas_bottom).with.offset((40/2));
             make.height.equalTo(weakself.rembPassWordBt.mas_width);
             make.left.equalTo(weakself.accountFild.mas_left);
            
        }];
        
    }
    return _rembPassWordBt;
}


- (UILabel *)rembPassWordLabel{
    
    if (_rembPassWordLabel == nil) {
        _rembPassWordLabel = [[UILabel alloc]init];
        _rembPassWordLabel.text = @"记住密码";
        _rembPassWordLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        LWWeakSelf(self);
        [self addSubview:_rembPassWordLabel];
        [weakself.rembPassWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakself.rembPassWordBt.mas_right).with.offset(14/2);
            make.centerY.equalTo(weakself.rembPassWordBt);
        }];
    }
    return _rembPassWordLabel;
}

- (UIButton *)forgetButton{
    
    if (_forgetButton == nil) {
        _forgetButton = [[UIButton alloc]init];
        [_forgetButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetButton setTitleColor:[UIColor colorWithHexString:@"#3366cc"] forState:UIControlStateNormal];
        [_forgetButton addTarget:self action:@selector(forgetAacc:) forControlEvents:UIControlEventTouchUpInside];
        _forgetButton.userInteractionEnabled = YES;
        LWWeakSelf(self);
        [self addSubview:_forgetButton];
        [weakself.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(weakself.rembPassWordLabel);
            make.right.equalTo(weakself.accountFild.mas_right);
            
        }];
        
    }
    return _forgetButton;
}

- (UIButton *)loginBt{
    
    if (_loginBt == nil) {
        
        
        _loginBt = [[UIButton alloc]init];
        [_loginBt setTitle:@"登陆" forState:UIControlStateNormal];
        [_loginBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBt addTarget:self action:@selector(logineAcc:) forControlEvents:UIControlEventTouchUpInside];

        LWWeakSelf(self);
        [self addSubview:_loginBt];
        [weakself.loginBt mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakself.rembPassWordLabel.mas_bottom).with.offset(51/2);
            make.centerX.equalTo(weakself.accountFild);
            make.width.equalTo(weakself.accountFild);
            make.height.equalTo(@(82/2));
            
        }];
        
        _loginBt.clipsToBounds=YES;
        
        _loginBt.layer.cornerRadius=41/2;
        
    }
    return _loginBt;
}


- (UIButton *)registerBt{
    
    if (_registerBt == nil) {
        
        
        _registerBt = [[UIButton alloc]init];
        [_registerBt setTitle:@"新用户注册" forState:UIControlStateNormal];
        [_registerBt setTitleColor:[UIColor colorWithHexString:@"#33b1e0"] forState:UIControlStateNormal];
        [_registerBt addTarget:self action:@selector(registerBt:) forControlEvents:UIControlEventTouchUpInside];

        LWWeakSelf(self);
        [self addSubview:_registerBt];
        [weakself.registerBt mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakself.loginBt.mas_bottom).with.offset(50/2);
            make.centerX.equalTo(weakself.accountFild);
           
            
        }];
        
    }
    return _registerBt;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.frame = CGRectMake(0.0f, -offset, self.frame.size.width, self.frame.size.height);
    
    [UIView commitAnimations];
}


//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.frame =CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_accountFild resignFirstResponder];
    [_passWordFild resignFirstResponder];
    
}

- (void)forgetAacc:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(forgetPassWord:)]) {
        [self.delegate forgetPassWord:button];
    }


}

- (void)logineAcc:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(loginClick:passWord:)]) {
        [self.delegate loginClick:self.accountFild.text passWord:self.passWordFild.text];
    }
}

- (void)registerBt:(UIButton *)button{


    if ([self.delegate respondsToSelector:@selector(registerAccount:)]) {
        [self.delegate registerAccount:button];
    }
    
}

@end
