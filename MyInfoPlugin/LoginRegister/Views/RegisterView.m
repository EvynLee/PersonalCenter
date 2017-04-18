//
//  RegisterView.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/13.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "RegisterView.h"
#import "NSObject+ColorHex.h"
#import "Definition.h"
#import "Masonry.h"
#import "ZLAlertView.h"
#import "CityPickerView.h"
@interface RegisterView ()<UITextFieldDelegate,CityPickerViewDelegate>

@property (nonatomic, strong) UITextField *accountFild;
@property (nonatomic, strong) UITextField *passWordFild;
@property (nonatomic, strong) UITextField *verificatFild;
@property (nonatomic, strong) UITextField *inviteFild;
@property (nonatomic, strong) UITextField *locationFild;
@property (nonatomic, strong) CityPickerView *pickerView;
@property (nonatomic, strong) NSDictionary *cityDic;

@property (nonatomic, strong) UIButton *resetPassWordBt;

@end

@implementation RegisterView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        self.accountFild.backgroundColor = [UIColor whiteColor];
        self.accountFild.delegate = self;
        self.verificatFild.backgroundColor = [UIColor whiteColor];
        self.verificatFild.delegate = self;
        self.verificatNumBt.backgroundColor = [UIColor colorWithHexString:@"#33b1e0"];
        self.passWordFild.backgroundColor = [UIColor whiteColor];
        self.passWordFild.delegate = self;
        self.inviteFild.backgroundColor = [UIColor whiteColor];
        self.inviteFild.delegate = self;
        self.locationFild.backgroundColor = [UIColor whiteColor];
        
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
            make.top.equalTo(weakself).with.offset(((128+146)/2));
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
        
        UIImageView *input = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_yzm"]];
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
        [_verificatNumBt addTarget:self action:@selector(verificatNumBtClick:) forControlEvents:UIControlEventTouchUpInside];
        
        LWWeakSelf(self);
        [weakself.verificatNumBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.accountFild.mas_bottom).with.offset((30/2));
            make.left.equalTo(weakself.verificatFild.mas_right).with.offset(20/2);
            make.right.equalTo(weakself.accountFild.mas_right);
//            make.width.equalTo(@(250/2));
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


- (UITextField *)inviteFild{
    
    if (_inviteFild == nil) {
        
        
        _inviteFild = [[UITextField alloc]init];
        LWWeakSelf(self);
        _inviteFild.layer.borderWidth = 1.0f;
        _inviteFild.layer.cornerRadius = 41/2;
        _inviteFild.layer.borderColor = [UIColor colorWithHexString:@"#33b1e0"].CGColor;
        
        
        _inviteFild.placeholder = @"请输入邀请码（可不填）";
        _inviteFild.clearButtonMode=UITextFieldViewModeWhileEditing;
        
        UIImageView *input = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_yqm"]];
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];//宽度根据需求进行设置，高度必须大于 textField 的高度
        [lv addSubview:input];
        input.center = lv.center;
        
        _inviteFild.leftView = lv;
        _inviteFild.leftViewMode =UITextFieldViewModeAlways;
        _inviteFild.secureTextEntry = YES;
        
        [self addSubview:_inviteFild];
        [weakself.inviteFild mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakself.passWordFild.mas_bottom).with.offset((30/2));
            make.centerX.equalTo(weakself.passWordFild.mas_centerX);
            make.width.equalTo(weakself.passWordFild);
            make.height.equalTo(@(82/2));
            
            
        }];
        
    }
    return _inviteFild;
}


- (UITextField *)locationFild{
    
    if (_locationFild == nil) {
        
        
        _locationFild = [[UITextField alloc]init];
        LWWeakSelf(self);
        _locationFild.layer.borderWidth = 1.0f;
        _locationFild.layer.cornerRadius = 41/2;
        _locationFild.layer.borderColor = [UIColor colorWithHexString:@"#33b1e0"].CGColor;
        _locationFild.delegate=self;
        
        _locationFild.placeholder = @"选择所在地";
        _locationFild.clearButtonMode=UITextFieldViewModeWhileEditing;
        
        UIImageView *input = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_city"]];
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];//宽度根据需求进行设置，高度必须大于 textField 的高度
        [lv addSubview:input];
        input.center = lv.center;
        
        _locationFild.leftView = lv;
        _locationFild.leftViewMode =UITextFieldViewModeAlways;
        _locationFild.secureTextEntry = NO;
        
        [self addSubview:_locationFild];
        [weakself.locationFild mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakself.inviteFild.mas_bottom).with.offset((30/2));
            make.centerX.equalTo(weakself.passWordFild.mas_centerX);
            make.width.equalTo(weakself.passWordFild);
            make.height.equalTo(@(82/2));
            
            
        }];
        
    }
    return _locationFild;
}

- (UIButton *)resetPassWordBt{
    
    if (_resetPassWordBt == nil) {
        
        
        _resetPassWordBt = [[UIButton alloc]init];
        [self addSubview:_resetPassWordBt];
        _resetPassWordBt.layer.cornerRadius = 41/2;
        _resetPassWordBt.backgroundColor = [UIColor colorWithHexString:@"#33b1e0"];
        [_resetPassWordBt setTitle:@"确认注册" forState:UIControlStateNormal];
        [_resetPassWordBt addTarget:self action:@selector(registerBtClicked:) forControlEvents:UIControlEventTouchUpInside];
        LWWeakSelf(self);
        [weakself.resetPassWordBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.locationFild.mas_bottom).with.offset((70/2));
            make.left.equalTo(weakself.mas_left).with.offset(80/2);
            make.right.equalTo(weakself.mas_right).with.offset(-(80/2));
            make.width.equalTo(@(250/2));
            make.height.equalTo(@(82/2));
            
        }];
        
    }
    return _resetPassWordBt;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.locationFild]){
       self.pickerView.delegate = self;
    }else{
       [_pickerView removeFromSuperview];
        _pickerView = nil;
    }
    if ([textField isEqual:self.locationFild]){
        [_accountFild resignFirstResponder];
        [_passWordFild resignFirstResponder];
        [_verificatFild resignFirstResponder];
        [_inviteFild resignFirstResponder];
        [_locationFild resignFirstResponder];
         return NO;
    }

    return YES;
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

+ (BOOL)isPhoneNumber:(NSString *)number
{
    NSString *phoneRegex1=@"1[34578]([0-9]){9}";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return  [phoneTest1 evaluateWithObject:number];
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

- (void)chooseCityClick:(NSDictionary *)cityDic{
    [_pickerView removeFromSuperview];
    _pickerView = nil;
    self.cityDic = cityDic;
    self.locationFild.text = [NSString stringWithFormat:@"%@ %@ %@",cityDic[@"省"],cityDic[@"市"],cityDic[@"区"]];
    NSLog(@"----%@",cityDic);

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_pickerView removeFromSuperview];
    _pickerView = nil;
    [_accountFild resignFirstResponder];
    [_passWordFild resignFirstResponder];
    [_verificatFild resignFirstResponder];
    [_inviteFild resignFirstResponder];
    [_locationFild resignFirstResponder];
}
- (CityPickerView *)pickerView{
    if (_pickerView == nil) {
        _pickerView = [[CityPickerView alloc]init];
        [self addSubview:_pickerView];
        
        LWWeakSelf(self);
        [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.locationFild.mas_bottom);
            make.bottom.equalTo(weakself.mas_bottom);
            make.width.equalTo(weakself);
        }];
    }
    return _pickerView;
}


- (void)verificatNumBtClick:(UIButton *)bt{

    
    if ([self.delegate  respondsToSelector:@selector(verficateNumClick:phoneNum:)]) {
        if (self.accountFild.text!=nil) {
            if ([self isPhoneNumber:self.accountFild.text]) {
                [self.delegate verficateNumClick:@1 phoneNum:self.accountFild.text];
            }
        }
    }
}

- (BOOL)isPhoneNumber:(NSString *)number
{
    NSString *phoneRegex1=@"1[34578]([0-9]){9}";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return  [phoneTest1 evaluateWithObject:number];
}


- (void)registerBtClicked:(UIButton *)bt{


    if ([self.delegate  respondsToSelector:@selector(registerClick:passWord:inviteCode:verificationCode:province:city:area:)]) {

        [self.delegate registerClick:self.accountFild.text passWord:self.passWordFild.text inviteCode:self.inviteFild.text verificationCode:self.verificatFild.text province:self.cityDic[@"省"] city:self.cityDic[@"市"] area:self.cityDic[@"区"]];
    }
}

@end
