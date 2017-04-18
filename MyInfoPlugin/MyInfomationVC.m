//
//  MyInfomationVC.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/22.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "MyInfomationVC.h"
#import "Definition.h"
#import "Masonry.h"
#import "AddressModiflyViewController.h"
@interface MyInfomationVC ()
@property (nonatomic, strong) UIImageView *headerIcon;
@property (nonatomic, strong) UIImageView *accountImageView;
@property (nonatomic, strong) UIImageView *nickNamegeView;
@property (nonatomic, strong) UIImageView *sexView;
@property (nonatomic, strong) UIImageView *birthDayView;
@property (nonatomic, strong) UIImageView *cityView;
@property (nonatomic, strong) UIImageView *inventView;
@property (nonatomic, strong) UIImageView *addressView;
@end

@implementation MyInfomationVC


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
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"我的信息";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    self.navigationItem.titleView = title;    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.headerIcon.backgroundColor = [UIColor whiteColor];
    self.accountImageView.backgroundColor = [UIColor whiteColor];
    self.nickNamegeView.backgroundColor = [UIColor whiteColor];
    self.sexView.backgroundColor = [UIColor whiteColor];
    self.birthDayView.backgroundColor = [UIColor whiteColor];
    self.cityView.backgroundColor = [UIColor whiteColor];
    self.inventView.backgroundColor = [UIColor whiteColor];
    self.addressView.backgroundColor = [UIColor whiteColor];
}

- (UIImageView *)headerIcon{
    
    if (_headerIcon == nil) {
        _headerIcon = [[UIImageView alloc]init];
        [self.view addSubview:_headerIcon];
        LWWeakSelf(self);
        [_headerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.view.mas_top).offset(64);
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        
        UILabel *leftlabel = [[UILabel alloc]init];
        leftlabel.text = @"头像";
        leftlabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_headerIcon addSubview:leftlabel];
        [leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.headerIcon);
            make.left.equalTo(_headerIcon.mas_left).mas_offset(20/2);
            
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        imageGo.hidden = YES;
        [_headerIcon addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.headerIcon);
            make.right.equalTo(weakself.headerIcon.mas_right).mas_offset(-(20/2));
        }];

        
        UIImageView *image = [[UIImageView alloc]init];
        image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.iconImageStr]]];
        [_headerIcon addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.headerIcon);
            make.right.equalTo(imageGo.mas_left).mas_offset(-(20/2));
            make.width.equalTo(@(60/2));
            make.height.equalTo(@(60/2));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconClick)];
        _headerIcon.userInteractionEnabled = YES;
        [_headerIcon addGestureRecognizer:tap];
    }
    return _headerIcon;
}


- (UIImageView *)accountImageView{
    
    if (_accountImageView == nil) {
        _accountImageView = [[UIImageView alloc]init];
        [self.view addSubview:_accountImageView];
        LWWeakSelf(self);
        [_accountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.headerIcon.mas_bottom).offset(1);
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        
        UILabel *leftlabel = [[UILabel alloc]init];
        leftlabel.text = @"账号";
        leftlabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_accountImageView addSubview:leftlabel];
        [leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.accountImageView);
            make.left.equalTo(weakself.accountImageView.mas_left).mas_offset(20/2);
            
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        imageGo.hidden = YES;
        [_accountImageView addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.accountImageView);
            make.right.equalTo(weakself.accountImageView.mas_right).mas_offset(-(20/2));
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = self.accountStr;
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_accountImageView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.accountImageView);
        make.right.equalTo(imageGo.mas_left).mas_offset(-(20/2));
        
    }];
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(accountClick)];
        _accountImageView.userInteractionEnabled = YES;
        [_accountImageView addGestureRecognizer:tap];
    }
    return _accountImageView;
}


- (UIImageView *)nickNamegeView{
    
    if (_nickNamegeView == nil) {
        _nickNamegeView = [[UIImageView alloc]init];
        [self.view addSubview:_nickNamegeView];
        LWWeakSelf(self);
        [_nickNamegeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.accountImageView.mas_bottom).offset(1);
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        
        UILabel *leftlabel = [[UILabel alloc]init];
        leftlabel.text = @"昵称";
        leftlabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_nickNamegeView addSubview:leftlabel];
        [leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.nickNamegeView);
            make.left.equalTo(weakself.nickNamegeView.mas_left).mas_offset(20/2);
            
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        [_nickNamegeView addSubview:imageGo];
        imageGo.hidden = YES;
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.nickNamegeView);
            make.right.equalTo(weakself.nickNamegeView.mas_right).mas_offset(-(20/2));
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = self.nickNameStr;
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_nickNamegeView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.nickNamegeView);
            make.right.equalTo(imageGo.mas_left).mas_offset(-(20/2));
            
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nickNameClick)];
        _nickNamegeView.userInteractionEnabled = YES;
        [_nickNamegeView addGestureRecognizer:tap];
    }
    return _nickNamegeView;
}

- (UIImageView *)sexView{
    
    if (_sexView == nil) {
        _sexView = [[UIImageView alloc]init];
        [self.view addSubview:_sexView];
        LWWeakSelf(self);
        [_sexView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.nickNamegeView.mas_bottom).offset(1);
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        
        UILabel *leftlabel = [[UILabel alloc]init];
        leftlabel.text = @"性别";
        leftlabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_sexView addSubview:leftlabel];
        [leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.sexView);
            make.left.equalTo(weakself.sexView.mas_left).mas_offset(20/2);
            
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        imageGo.hidden = YES;
        [_sexView addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.sexView);
            make.right.equalTo(weakself.sexView.mas_right).mas_offset(-(20/2));
        }];
        
        UILabel *label = [[UILabel alloc]init];
        if ([self.sexStr isEqualToString:@"1"]) {
            label.text  = @"女";
        }else if ([self.sexStr isEqualToString:@"0"]){
            label.text  = @"男";        
        }
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_sexView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.sexView);
            make.right.equalTo(imageGo.mas_left).mas_offset(-(20/2));
            
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sexClick)];
        _sexView.userInteractionEnabled = YES;
        [_sexView addGestureRecognizer:tap];
    }
    return _sexView;
}


- (UIImageView *)birthDayView{
    
    if (_birthDayView == nil) {
        _birthDayView = [[UIImageView alloc]init];
        [self.view addSubview:_birthDayView];
        LWWeakSelf(self);
        [_birthDayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.sexView.mas_bottom).offset(1);
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        
        UILabel *leftlabel = [[UILabel alloc]init];
        leftlabel.text = @"生日";
        leftlabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_birthDayView addSubview:leftlabel];
        [leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.birthDayView);
            make.left.equalTo(weakself.birthDayView.mas_left).mas_offset(20/2);
            
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        imageGo.hidden = YES;
        [_birthDayView addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.birthDayView);
            make.right.equalTo(weakself.birthDayView.mas_right).mas_offset(-(20/2));
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = self.birthStr;
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_birthDayView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.birthDayView);
            make.right.equalTo(imageGo.mas_left).mas_offset(-(20/2));
            
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(birthClick)];
        _birthDayView.userInteractionEnabled = YES;
        [_birthDayView addGestureRecognizer:tap];
    }
    return _birthDayView;
}

- (UIImageView *)cityView{
    
    if (_cityView == nil) {
        _cityView = [[UIImageView alloc]init];
        [self.view addSubview:_cityView];
        LWWeakSelf(self);
        [_cityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.birthDayView.mas_bottom).offset(1);
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        
        UILabel *leftlabel = [[UILabel alloc]init];
        leftlabel.text = @"城市";
        leftlabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_cityView addSubview:leftlabel];
        [leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.cityView);
            make.left.equalTo(weakself.cityView.mas_left).mas_offset(20/2);
            
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        imageGo.hidden = YES;
        [_cityView addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.cityView);
            make.right.equalTo(weakself.cityView.mas_right).mas_offset(-(20/2));
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = [NSString stringWithFormat:@"%@-%@",self.provinceStr,self.cityStr];
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_cityView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.cityView);
            make.right.equalTo(imageGo.mas_left).mas_offset(-(20/2));
            
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cityClick)];
        _cityView.userInteractionEnabled = YES;
        [_cityView addGestureRecognizer:tap];
    }
    return _cityView;
}

- (UIImageView *)inventView{
    
    if (_inventView == nil) {
        _inventView = [[UIImageView alloc]init];
        [self.view addSubview:_inventView];
        LWWeakSelf(self);
        [_inventView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.cityView.mas_bottom).offset(1);
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        
        UILabel *leftlabel = [[UILabel alloc]init];
        leftlabel.text = @"邀请码";
        leftlabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_inventView addSubview:leftlabel];
        [leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.inventView);
            make.left.equalTo(weakself.inventView.mas_left).mas_offset(20/2);
            
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        imageGo.hidden = YES;
        [_inventView addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.inventView);
            make.right.equalTo(weakself.inventView.mas_right).mas_offset(-(20/2));
        }];
        
        UILabel *label = [[UILabel alloc]init];
        if (self.inventStr.length == 0) {
            label.text = @"未填写";
        }else{
            label.text = self.inventStr;
        }
        
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_inventView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.inventView);
            make.right.equalTo(imageGo.mas_left).mas_offset(-(20/2));
            
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(inventClick)];
        _inventView.userInteractionEnabled = YES;
        [_inventView addGestureRecognizer:tap];
    }
    return _inventView;
}


- (UIImageView *)addressView{
    
    if (_addressView == nil) {
        _addressView = [[UIImageView alloc]init];
        [self.view addSubview:_addressView];
        LWWeakSelf(self);
        [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.inventView.mas_bottom).offset(1);
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        
        UILabel *leftlabel = [[UILabel alloc]init];
        leftlabel.text = @"收货地址";
        leftlabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_addressView addSubview:leftlabel];
        [leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.addressView);
            make.left.equalTo(weakself.addressView.mas_left).mas_offset(20/2);
            make.width.equalTo(@(100));
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        imageGo.hidden = YES;
        [_addressView addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.addressView);
            make.right.equalTo(weakself.addressView.mas_right).mas_offset(-(20/2));
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = self.addressDic[@"addr"];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_addressView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.addressView);
            make.right.equalTo(imageGo.mas_left).mas_offset(-(20/2));
            
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addressClick)];
        _addressView.userInteractionEnabled = YES;
        [_addressView addGestureRecognizer:tap];
    }
    return _addressView;
}

#pragma mark --- touch up clicked 
- (void)iconClick{


}
- (void)accountClick{
    
    
}

- (void)nickNameClick{
    
    
}

- (void)sexClick{
    
    
}

- (void)birthClick{
    
    
}

- (void)cityClick{
    
    
}

- (void)inventClick{
    
    
}

- (void)addressClick{
    
    AddressModiflyViewController * address = [[AddressModiflyViewController alloc]init];
    address.infoDic = self.addressDic;
    [self.navigationController pushViewController:address animated:YES];
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];// 修改下级页面的返回按钮，此处我是很想写到videoController中，但是backBarButtonItem的机制决定必须写在A中；
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
