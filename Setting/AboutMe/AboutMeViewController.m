//
//  AboutMeViewController.m
//  ZWEducation
//
//  Created by 李炜 on 2017/4/10.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "AboutMeViewController.h"
#import "Definition.h"
#import "Masonry.h"
@interface AboutMeViewController ()
@property (nonatomic, strong) UIImageView *shangBiaoImage;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UIImageView *phoneView;
@property (nonatomic, strong) UIImageView *emailView;
@property (nonatomic, strong) UIImageView *qRCodeView;
@property (nonatomic, strong) UILabel *bottomLabel;
@end

@implementation AboutMeViewController

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
    title.text = @"关于我们";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    self.navigationItem.titleView = title;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
     [self shangBiaoImage];
     [self versionLabel];
     [self phoneView];
     [self emailView];
     [self qRCodeView];
     [self bottomLabel];
}

- (UIImageView *)shangBiaoImage{
    
    if (_shangBiaoImage == nil) {
        _shangBiaoImage = [[UIImageView alloc]init];
        _shangBiaoImage.image = [UIImage imageNamed:@"logo"];
        [self.view addSubview:_shangBiaoImage];
        LWWeakSelf(self);
        [_shangBiaoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.view.mas_top).offset(64+41/2);
            make.centerX.equalTo(weakself.view);
           
        }];
    }
    return _shangBiaoImage;
}

- (UILabel *)versionLabel{
    
    if (_versionLabel == nil) {
        _versionLabel = [[UILabel alloc]init];
        _versionLabel.text = @"版本：V1.0.0";
        _versionLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _versionLabel.font = [UIFont systemFontOfSize:14];
        LWWeakSelf(self);
        
        [self.view addSubview:_versionLabel];
        [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.shangBiaoImage.mas_bottom).with.offset((20/2));
            make.centerX.equalTo(weakself.view);
            
        }];
        
    }
    return _versionLabel;
}


- (UIImageView *)phoneView{
    
    if (_phoneView == nil) {
        _phoneView = [[UIImageView alloc]init];
        _phoneView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_phoneView];
        LWWeakSelf(self);
        [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.versionLabel.mas_bottom).offset(40/2);
            make.width.equalTo(weakself.view);
            make.height.equalTo(@(88/2));
        }];

        UILabel *label = [[UILabel alloc]init];
        label.text = @"客服电话";
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_phoneView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.phoneView);
            make.left.equalTo(weakself.phoneView.mas_left).mas_offset(23/2);
            
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        [_phoneView addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.phoneView);
            make.right.equalTo(weakself.phoneView.mas_right).mas_offset(-(20/2));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callphone)];
        _phoneView.userInteractionEnabled = YES;
        [_phoneView addGestureRecognizer:tap];
        
        
    }
    return _phoneView;
}


- (UIImageView *)emailView{
    
    if (_emailView == nil) {
        _emailView = [[UIImageView alloc]init];
        _emailView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_emailView];
        LWWeakSelf(self);
        [_emailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.phoneView.mas_bottom).offset(1);
            make.width.equalTo(weakself.view);
            make.height.equalTo(@(88/2));
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"E-mail";
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_emailView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.emailView);
            make.left.equalTo(weakself.emailView.mas_left).mas_offset(23/2);
            
        }];
        
        UILabel *emalilabel = [[UILabel alloc]init];
        emalilabel.text = @"zwxb@123edu.com";
        emalilabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [_emailView addSubview:emalilabel];
        
        [emalilabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.emailView);
            make.right.equalTo(weakself.emailView.mas_right).mas_offset(-(23/2));
            
        }];
        
        
    }
    return _emailView;
}

- (UIImageView *)qRCodeView{
    
    if (_qRCodeView == nil) {
        _qRCodeView = [[UIImageView alloc]init];
        _qRCodeView.image = [UIImage imageNamed:@"mine_about_ewm"];
        [self.view addSubview:_qRCodeView];
        LWWeakSelf(self);
        [_qRCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.emailView.mas_bottom).offset(60/2);
            make.centerX.equalTo(weakself.view);
            
        }];
    }
    return _qRCodeView;
}

- (UILabel *)bottomLabel{
    
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.text = @"关注公众号：123在线教育";
        _bottomLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _bottomLabel.font = [UIFont systemFontOfSize:14];
        LWWeakSelf(self);
        
        [self.view addSubview:_bottomLabel];
        [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.qRCodeView.mas_bottom).with.offset((22/2));
            make.centerX.equalTo(weakself.view);
        }];
        
    }
    return _bottomLabel;
}
//打电话
- (void)callphone{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4000643123"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
