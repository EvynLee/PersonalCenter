//
//  ForgetPassWordView.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/13.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "ForgetPassWordView.h"
#import "NSObject+ColorHex.h"
#import "Definition.h"
#import "Masonry.h"

@interface ForgetPassWordView ()

@property (nonatomic, strong) UITextField *accountFild;
@property (nonatomic, strong) UITextField *passWordFild;
@property (nonatomic, strong) UITextField *verificatFild;



@property (nonatomic, strong) UIButton *resetPassWordBt;

@end

@implementation ForgetPassWordView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
       
        self.accountFild.backgroundColor = [UIColor whiteColor];
        self.passWordFild.backgroundColor = [UIColor whiteColor];
        self.verificatFild.backgroundColor = [UIColor whiteColor];
        self.verificatNumBt.backgroundColor = [UIColor colorWithHexString:@"#33b1e0"];
        self.resetPassWordBt.backgroundColor = [UIColor colorWithHexString:@"#33b1e0"];
       
    }
    return self;
    
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
            make.top.equalTo(weakself).with.offset(((128+264)/2));
            make.left.equalTo(weakself.mas_left).with.offset(80/2);
            make.right.equalTo(weakself.mas_right).with.offset(-(80/2));
            make.height.equalTo(@(82/2));
            
        }];
        
    }
    return _accountFild;
}


- (UITextField *)verificatFild{
    
    if (_verificatFild == nil) {
        
        
        _verificatFild = [[UITextField alloc]init];
        [self addSubview:_verificatFild];
        _verificatFild.layer.borderWidth = 1.0f;
        _verificatFild.layer.cornerRadius = 41/2;
        _verificatFild.layer.borderColor = [UIColor colorWithHexString:@"#33b1e0"].CGColor;
        _verificatFild.placeholder = @"请输入验证码";
        _verificatFild.clearButtonMode=UITextFieldViewModeWhileEditing;
        
        UIImageView *input = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_phone"]];
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];//宽度根据需求进行设置，高度必须大于 textField 的高度
        [lv addSubview:input];
        input.center = lv.center;
        
        _verificatFild.leftView = lv;
        _verificatFild.leftViewMode =UITextFieldViewModeAlways;
        
        LWWeakSelf(self);
        [weakself.verificatFild mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.accountFild.mas_bottom).with.offset((30/2));
            make.left.equalTo(weakself.mas_left).with.offset(80/2);
            make.width.equalTo(@(320/2));
            make.height.equalTo(@(82/2));            
        }];
    }
        return _verificatFild;
}

- (UIButton *)verificatNumBt{
    
    if (_verificatNumBt == nil) {
        _verificatNumBt = [[UIButton alloc]init];
        [self addSubview:_verificatNumBt];
        _verificatNumBt.layer.borderWidth = 1.0f;
        _verificatNumBt.layer.cornerRadius = 41/2;
        _verificatNumBt.layer.borderColor = [UIColor colorWithHexString:@"#33b1e0"].CGColor;
        [_verificatNumBt setTitle:@"获取验证码" forState:UIControlStateNormal];
        _verificatNumBt.titleLabel.adjustsFontSizeToFitWidth = YES;
         [_verificatNumBt addTarget:self action:@selector(getnumClicked:) forControlEvents:UIControlEventTouchUpInside];
        LWWeakSelf(self);
        [weakself.verificatNumBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.accountFild.mas_bottom).with.offset((30/2));
            make.left.equalTo(weakself.verificatFild.mas_right).with.offset(20/2);
            make.right.equalTo(weakself.accountFild.mas_right);
            make.height.equalTo(@(82/2));
        }];
    }
    return _verificatNumBt;
}



- (UITextField *)passWordFild{
    
    if (_passWordFild == nil) {
        
        
        _passWordFild = [[UITextField alloc]init];
        LWWeakSelf(self);
        _passWordFild.layer.borderWidth = 1.0f;
        _passWordFild.layer.cornerRadius = 41/2;
        _passWordFild.layer.borderColor = [UIColor colorWithHexString:@"#33b1e0"].CGColor;
        
        
        _passWordFild.placeholder = @"请输入6-12位密码";
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
            
            make.top.equalTo(weakself.verificatFild.mas_bottom).with.offset((30/2));
            make.centerX.equalTo(weakself.accountFild.mas_centerX);
            make.width.equalTo(weakself.accountFild);
            make.height.equalTo(@(82/2));
            
            
        }];
        
    }
    return _passWordFild;
}

- (UIButton *)resetPassWordBt{
    
    if (_resetPassWordBt == nil) {
        
        
        _resetPassWordBt = [[UIButton alloc]init];
        [self addSubview:_resetPassWordBt];
        
        _resetPassWordBt.layer.cornerRadius = 41/2;
        _resetPassWordBt.backgroundColor = [UIColor colorWithHexString:@"#33b1e0"];
        [_resetPassWordBt setTitle:@"重置密码" forState:UIControlStateNormal];
         [_resetPassWordBt addTarget:self action:@selector(resetPassWordBtClicked:) forControlEvents:UIControlEventTouchUpInside];
        LWWeakSelf(self);
        [weakself.resetPassWordBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.passWordFild.mas_bottom).with.offset((70/2));
            make.left.equalTo(weakself.mas_left).with.offset(80/2);
            make.right.equalTo(weakself.mas_right).with.offset(-(80/2));
            make.width.equalTo(@(250/2));
            make.height.equalTo(@(82/2));
            
        }];
        
    }
    return _resetPassWordBt;
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
    [_verificatFild resignFirstResponder];
   
}


- (void)resetPassWordBtClicked:(UIButton *)bt{

    if ([self.delegate  respondsToSelector:@selector(resetClick:passWord:verficNumCode:)]) {        
        [self.delegate resetClick:self.accountFild.text passWord:self.passWordFild.text verficNumCode:self.verificatFild.text];
    }
}

- (void)getnumClicked:(UIButton *)bt{


    if ([self.delegate  respondsToSelector:@selector(verficateNumClick:phoneNum:)]) {
        [self.delegate verficateNumClick:@2 phoneNum:self.accountFild.text];
    }

    

}

@end
