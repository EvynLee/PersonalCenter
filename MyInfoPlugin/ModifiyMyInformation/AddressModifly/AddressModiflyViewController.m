//
//  AddressModiflyViewController.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/23.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "AddressModiflyViewController.h"
#import "Definition.h"
#import "Masonry.h"
#import "NetworkManager.h"
#import "NetRequestUrl.h"

@interface AddressModiflyViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *nameView;
@property (nonatomic, strong) UITextField *nameTextField;

@property (nonatomic, strong) UIImageView *phoneView;
@property (nonatomic, strong) UITextField *phoneTextField;

@property (nonatomic, strong) UIImageView *regionView;
@property (nonatomic, strong) UITextField *regionTextField;


@property (nonatomic, strong) UIImageView *addressView;
@property (nonatomic, strong) UITextField *addressTextField;
@end

@implementation AddressModiflyViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"收货地址";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    self.navigationItem.titleView = title;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saveButton.frame = CGRectMake(0, 0, 50, 40);
    [saveButton setTitle:@"保存" forState:normal];
    [saveButton setTitleColor:[UIColor colorWithRed:0.164 green:0.657 blue:0.915 alpha:1.000] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;
    
    self.nameView.backgroundColor     = [UIColor whiteColor];
    self.nameView.userInteractionEnabled = YES;
    self.phoneView.backgroundColor    = [UIColor whiteColor];
    self.phoneView.userInteractionEnabled = YES;
    self.regionView.backgroundColor   = [UIColor whiteColor];
    self.regionView.userInteractionEnabled = YES;
    self.addressView.backgroundColor  = [UIColor whiteColor];
    self.addressView.userInteractionEnabled = YES;
}

- (UIImageView *)nameView{
    
    if (_nameView == nil) {
        _nameView = [[UIImageView alloc]init];
        [self.view addSubview:_nameView];
        LWWeakSelf(self);
        [_nameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.view.mas_top).offset(64);
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.height.equalTo(@(88/2));
        }];
        UILabel *nameleftlabel = [[UILabel alloc]init];
        nameleftlabel.text = @"收货人:";
        nameleftlabel.adjustsFontSizeToFitWidth = YES;
        nameleftlabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [_nameView addSubview:nameleftlabel];
        [nameleftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.nameView);
            make.left.equalTo(weakself.nameView.mas_left).mas_offset(20/2);
            make.width.equalTo(@(80));
        }];
        
        _nameTextField = [[UITextField alloc] init];
        [_nameTextField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
        //如果出现UITextField不显示的情况，很可能是没设置其BorderStyle
        _nameTextField.placeholder = self.infoDic[@"name"]; //默认显示的字
        [_nameView addSubview:_nameTextField];
        [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.nameView);
            make.left.equalTo(nameleftlabel.mas_right).mas_offset((20/2));
            make.right.equalTo(weakself.view.mas_right).mas_offset(-(20/2));
        }];
        _nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _nameTextField.returnKeyType = UIReturnKeyDone;
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        
        _nameTextField.delegate = self;
        
    }
    return _nameView;

}

- (UIImageView *)phoneView{
    
    if (_phoneView == nil) {
        _phoneView = [[UIImageView alloc]init];
        [self.view addSubview:_phoneView];
        LWWeakSelf(self);
        [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.nameView.mas_bottom).offset(1);
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.height.equalTo(@(88/2));
        }];
        UILabel *phoneleftlabel = [[UILabel alloc]init];
        phoneleftlabel.text = @"手机号:";
        phoneleftlabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [_phoneView addSubview:phoneleftlabel];
        [phoneleftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.phoneView);
            make.left.equalTo(weakself.phoneView.mas_left).mas_offset(20/2);
            
        }];
        
        _phoneTextField = [[UITextField alloc] init];
        [_phoneTextField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
        //如果出现UITextField不显示的情况，很可能是没设置其BorderStyle
        _phoneTextField.placeholder = self.infoDic[@"phone"]; //默认显示的字
        [_phoneView addSubview:_phoneTextField];
        [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.phoneView);
            make.left.equalTo(phoneleftlabel.mas_right).mas_offset((20/2));
            make.right.equalTo(weakself.view.mas_right).mas_offset(-(20/2));
        }];
        _phoneTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _phoneTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _phoneTextField.returnKeyType = UIReturnKeyDone;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        
        _phoneTextField.delegate = self;
        
    }
    return _phoneView;
}

- (UIImageView *)regionView{
    
    if (_regionView == nil) {
        _regionView = [[UIImageView alloc]init];
        [self.view addSubview:_regionView];
        LWWeakSelf(self);
        [_regionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.phoneView.mas_bottom).offset(1);
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.height.equalTo(@(88/2));
        }];
        UILabel *leftlabel = [[UILabel alloc]init];
        leftlabel.text =  @"所在地区:";
        leftlabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [_regionView addSubview:leftlabel];
        [leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.regionView);
            make.left.equalTo(weakself.regionView.mas_left).mas_offset(20/2);
         //   make.width.equalTo(@(110));
        }];
        
        _regionTextField = [[UITextField alloc] init];
        [_regionTextField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
        //如果出现UITextField不显示的情况，很可能是没设置其BorderStyle
        _regionTextField.placeholder =[NSString stringWithFormat:@"%@ %@",self.infoDic[@"province"],self.infoDic[@"city"]]; //默认显示的字
        [_regionView addSubview:_regionTextField];
        [_regionTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.regionView);
            make.left.equalTo(leftlabel.mas_right).mas_offset((20/2));
            make.right.equalTo(weakself.view.mas_right).mas_offset(-(20/2));
        }];
        _regionTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _regionTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _regionTextField.returnKeyType = UIReturnKeyDone;
        _regionTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        
        _regionTextField.delegate = self;
        
    }
    return _regionView;
}


- (UIImageView *)addressView{
    
    if (_addressView == nil) {
        _addressView = [[UIImageView alloc]init];
        [self.view addSubview:_addressView];
        LWWeakSelf(self);
        [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.regionView.mas_bottom).offset(1);
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.height.equalTo(@(88/2));
        }];
        UILabel *leftlabel = [[UILabel alloc]init];
        leftlabel.text = @"详细地址:";
        leftlabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [_addressView addSubview:leftlabel];
        [leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.addressView);
            make.left.equalTo(weakself.addressView.mas_left).mas_offset(20/2);
          //  make.right.equalTo(weakself.view.mas_right).mas_offset(-(20/2));
            
        }];
        
        _addressTextField = [[UITextField alloc] init];
        [_addressTextField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
        //如果出现UITextField不显示的情况，很可能是没设置其BorderStyle
        _addressTextField.placeholder = self.infoDic[@"addr"]; //默认显示的字
        [_addressView addSubview:_addressTextField];
        [_addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.addressView);
            make.left.equalTo(leftlabel.mas_right).mas_offset((20/2));
            make.right.equalTo(weakself.view.mas_right).mas_offset(-(20/2));
        }];
        _addressTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _addressTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _addressTextField.returnKeyType = UIReturnKeyDone;
        _addressTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        
        _addressTextField.delegate = self;
        
    }
    return _addressView;
}

- (void)saveButtonClick:(UIButton *)btn{


    NSDictionary *postParamDict = @{
                                    @"action" : @"appMemberAction",
                                    @"method" : @"updateMemberBean",
                                    @"data" : @{@"addr":self.addressTextField.text,
                                                @"city":@"成都",
                                                @"province":@"四川",
                                                @"name":self.nameTextField.text,
                                                @"phone":self.phoneTextField.text,}
                                    };
    LWWeakSelf(self);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NetworkManager POSTWithHeader:HomePageUrl params:postParamDict header:@{@"x-auth-token":[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userToken"]]} success:^(NSURLSessionDataTask *task, id responseObject, AFHTTPSessionManager *manager) {
     
            DLog(@"------%@",responseObject[@"description"]);
           
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself showToseMessage:@"保存成功"];
                weakself.view.userInteractionEnabled = YES;
            });
        } fail:^(NSURLSessionDataTask *task, NSError *error, AFHTTPSessionManager *manager) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself showToseMessage:@"请求失败"];
                weakself.view.userInteractionEnabled = YES;
            });
            DLog(@"error:---------%@",error);
        }];
    });

    
    

}

#pragma mark -- textField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{

}

//当开始点击textField会调用的方法

-(void)textFieldDidEndEditing:(UITextField *)textField{


}

//当textField编辑结束时调用的方法
//按下Done按钮的调用方法，我们让键盘消失

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
