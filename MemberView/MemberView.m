//
//  MemberView.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/22.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "MemberView.h"
#import "Definition.h"
#import "Masonry.h"
#import "AppDelegate.h"

@interface MemberView ()

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIButton *  loginOrRegisterBt;

@property (nonatomic, strong) UIImageView *studyRecordImageView;
@property (nonatomic, strong) UIImageView *myCourcesImageView;
@property (nonatomic, strong) UIImageView *myDownLoadImageView;
@property (nonatomic, strong) UIImageView *myQuestionImageView;
@property (nonatomic, strong) UIImageView *myOrderImageView;
@property (nonatomic, strong) UIImageView *myfavorableImageView;
@property (nonatomic, strong) UIImageView *myAccountImageView;
@property (nonatomic, strong) UIImageView *setView;

@end


@implementation MemberView
@synthesize headerImageView=_headerImageView;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.headerImageView.backgroundColor = [UIColor colorWithRed:0.164 green:0.657 blue:0.915 alpha:1.000];
        self.studyRecordImageView.backgroundColor = [UIColor whiteColor];
        self.myCourcesImageView.backgroundColor = [UIColor whiteColor];
        self.myDownLoadImageView.backgroundColor = [UIColor whiteColor];
        self.myQuestionImageView.backgroundColor = [UIColor whiteColor];
        self.myOrderImageView.backgroundColor = [UIColor whiteColor];
      //   self.myfavorableImageView.backgroundColor = [UIColor whiteColor];
        self.myAccountImageView.backgroundColor = [UIColor whiteColor];
         self.setView.backgroundColor = [UIColor whiteColor];
        
        if ([AppDelegate shareAppDelegate].isChecking) {
            self.myOrderImageView.hidden = YES;
        }

    }
    return self;
    
}

/*
 头部视图
 */
- (UIImageView *)headerImageView{
   if (_headerImageView == nil) {
    _headerImageView = [[UIImageView alloc]init];
    [self addSubview:_headerImageView];
    _headerImageView.userInteractionEnabled = YES;
    LWWeakSelf(self);
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left);
        make.top.equalTo(weakself.mas_top);
        make.right.equalTo(weakself.mas_right);
        make.height.equalTo(@(281/2));
        
    }];
       _headerImageView.userInteractionEnabled = YES;
        _iconBt = [[UIButton alloc]init];
     //  [_iconBt setImage:[UIImage imageNamed:@"mine_login_head01"] forState:UIControlStateNormal];
       [_iconBt addTarget:self action:@selector(iconChoose) forControlEvents:UIControlEventTouchUpInside];
       [_headerImageView addSubview:_iconBt];
       [_iconBt mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(weakself.headerImageView.mas_left).offset((20/2));
           make.bottom.equalTo(weakself.headerImageView.mas_bottom).offset(-(30/2));
           make.width.equalTo(@(130/2));
           make.height.equalTo(@(130/2));
       }];
       
       
       _loginOrRegisterBt = [[UIButton alloc]init];
      // [_loginOrRegisterBt setTitle:@"登陆／注册" forState:UIControlStateNormal];
       [_loginOrRegisterBt addTarget:self action:@selector(loginedClick) forControlEvents:UIControlEventTouchUpInside];
       _loginOrRegisterBt.titleLabel.font = [UIFont systemFontOfSize:15];
       [_loginOrRegisterBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       [_headerImageView addSubview:_loginOrRegisterBt];
       [_loginOrRegisterBt mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(_iconBt.mas_right).offset((30/2));
           make.centerY.equalTo(_iconBt);
       }];
       
       
   }
    return _headerImageView;
}

- (void)setName:(NSString *)name{
    if (name.length != 0) {
        _name = name;
        [_loginOrRegisterBt setTitle:_name forState:UIControlStateNormal];
    }else{
    [_loginOrRegisterBt setTitle:@"登陆／注册" forState:UIControlStateNormal];
    
    }
    
}

- (void)setIconImgStr:(NSString *)iconImgStr{
    if (iconImgStr.length != 0) {
        _iconImgStr = iconImgStr;
        [_iconBt setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:iconImgStr]]] forState:UIControlStateNormal];

    }else{
    
       [_iconBt setImage:[UIImage imageNamed:@"mine_login_head01"] forState:UIControlStateNormal];
    }
    
}

/*
 学习记录
 */

- (UIImageView *)studyRecordImageView{
    
    if (_studyRecordImageView == nil) {
        _studyRecordImageView = [[UIImageView alloc]init];
        [self addSubview:_studyRecordImageView];
        LWWeakSelf(self);
        [_studyRecordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.headerImageView.mas_bottom);
            make.left.equalTo(weakself.mas_left);
            make.right.equalTo(weakself.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        UIImageView *image = [[UIImageView alloc]init];
        UILabel *label = [[UILabel alloc]init];
        
        image.image = [UIImage imageNamed:@"mine_xxjl"];
        [_studyRecordImageView addSubview:image];
        label.text = @"学习记录";
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_studyRecordImageView addSubview:label];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.studyRecordImageView);
            make.left.equalTo(weakself.studyRecordImageView.mas_left).mas_offset(21/2);
            make.right.equalTo(label.mas_left).mas_offset(-(23/2));
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.studyRecordImageView);
            make.left.equalTo(image.mas_right).mas_offset(23/2);
            
        }];

        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        [_studyRecordImageView addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.studyRecordImageView);
            make.right.equalTo(weakself.studyRecordImageView.mas_right).mas_offset(-(20/2));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(studyRecord)];
        _studyRecordImageView.userInteractionEnabled = YES;
        [_studyRecordImageView addGestureRecognizer:tap];
    }
    return _studyRecordImageView;
}


/*
 我的课程
 */

- (UIImageView *)myCourcesImageView{
    
    if (_myCourcesImageView == nil) {
        _myCourcesImageView = [[UIImageView alloc]init];
        [self addSubview:_myCourcesImageView];
        LWWeakSelf(self);
        [_myCourcesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.studyRecordImageView.mas_bottom).offset(1);
            make.left.equalTo(weakself.mas_left);
            make.right.equalTo(weakself.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        UIImageView *image = [[UIImageView alloc]init];
        UILabel *label = [[UILabel alloc]init];
        
        image.image = [UIImage imageNamed:@"mine_wdkc"];
        [_myCourcesImageView addSubview:image];
        label.text = @"我的课程";
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_myCourcesImageView addSubview:label];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myCourcesImageView);
            make.left.equalTo(weakself.myCourcesImageView.mas_left).mas_offset(21/2);
            make.right.equalTo(label.mas_left).mas_offset(-(23/2));
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myCourcesImageView);
            make.left.equalTo(image.mas_right).mas_offset(23/2);
            
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        [_myCourcesImageView addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myCourcesImageView);
            make.right.equalTo(weakself.myCourcesImageView.mas_right).mas_offset(-(20/2));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myCources)];
        _myCourcesImageView.userInteractionEnabled = YES;
        [_myCourcesImageView addGestureRecognizer:tap];
        
    }
    return _myCourcesImageView;
}


/*
 我的下载
 */

- (UIImageView *)myDownLoadImageView{
    
    if (_myDownLoadImageView == nil) {
        _myDownLoadImageView = [[UIImageView alloc]init];
        [self addSubview:_myDownLoadImageView];
        LWWeakSelf(self);
        [_myDownLoadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.myCourcesImageView.mas_bottom).offset(1);
            make.left.equalTo(weakself.mas_left);
            make.right.equalTo(weakself.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        UIImageView *image = [[UIImageView alloc]init];
        UILabel *label = [[UILabel alloc]init];
        
        image.image = [UIImage imageNamed:@"mine_wddy"];
        [_myDownLoadImageView addSubview:image];
        label.text = @"我的下载";
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_myDownLoadImageView addSubview:label];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myDownLoadImageView);
            make.left.equalTo(weakself.myDownLoadImageView.mas_left).mas_offset(21/2);
            make.right.equalTo(label.mas_left).mas_offset(-(23/2));
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myDownLoadImageView);
            make.left.equalTo(image.mas_right).mas_offset(23/2);
            
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        [_myDownLoadImageView addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myDownLoadImageView);
            make.right.equalTo(weakself.myDownLoadImageView.mas_right).mas_offset(-(20/2));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myDownLoad)];
        _myDownLoadImageView.userInteractionEnabled = YES;
        [_myDownLoadImageView addGestureRecognizer:tap];
    }
    return _myDownLoadImageView;
}

/*
 我的答疑
 */

- (UIImageView *)myQuestionImageView{
    
    if (_myQuestionImageView == nil) {
        _myQuestionImageView = [[UIImageView alloc]init];
        [self addSubview:_myQuestionImageView];
        LWWeakSelf(self);
        [_myQuestionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.myDownLoadImageView.mas_bottom).offset(20/2);
            make.left.equalTo(weakself.mas_left);
            make.right.equalTo(weakself.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        UIImageView *image = [[UIImageView alloc]init];
        UILabel *label = [[UILabel alloc]init];
        
        image.image = [UIImage imageNamed:@"mine_wddy"];
        [_myQuestionImageView addSubview:image];
        label.text = @"我的答疑";
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_myQuestionImageView addSubview:label];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myQuestionImageView);
            make.left.equalTo(weakself.myQuestionImageView.mas_left).mas_offset(21/2);
            make.right.equalTo(label.mas_left).mas_offset(-(23/2));
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myQuestionImageView);
            make.left.equalTo(image.mas_right).mas_offset(23/2);
            
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        [_myQuestionImageView addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myQuestionImageView);
            make.right.equalTo(weakself.myQuestionImageView.mas_right).mas_offset(-(20/2));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myQuestion)];
        _myQuestionImageView.userInteractionEnabled = YES;
        [_myQuestionImageView addGestureRecognizer:tap];
    }
    return _myQuestionImageView;
}

/*
 我的订单
 */

- (UIImageView *)myOrderImageView{
    
    if (_myOrderImageView == nil) {
        _myOrderImageView = [[UIImageView alloc]init];
        [self addSubview:_myOrderImageView];
        LWWeakSelf(self);
        [_myOrderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.myQuestionImageView.mas_bottom).offset(20/2);
            make.left.equalTo(weakself.mas_left);
            make.right.equalTo(weakself.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        UIImageView *image = [[UIImageView alloc]init];
        UILabel *label = [[UILabel alloc]init];
        
        image.image = [UIImage imageNamed:@"mine_wddd"];
        [_myOrderImageView addSubview:image];
        label.text = @"我的订单";
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_myOrderImageView addSubview:label];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myOrderImageView);
            make.left.equalTo(weakself.myOrderImageView.mas_left).mas_offset(21/2);
            make.right.equalTo(label.mas_left).mas_offset(-(23/2));
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myOrderImageView);
            make.left.equalTo(image.mas_right).mas_offset(23/2);
            
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        [_myOrderImageView addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myOrderImageView);
            make.right.equalTo(weakself.myOrderImageView.mas_right).mas_offset(-(20/2));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myOrder)];
        _myOrderImageView.userInteractionEnabled = YES;
        [_myOrderImageView addGestureRecognizer:tap];
    }
    return _myOrderImageView;
}

/*
 优惠卷
 */

- (UIImageView *)myfavorableImageView{
    
    if (_myfavorableImageView == nil) {
        _myfavorableImageView = [[UIImageView alloc]init];
        [self addSubview:_myfavorableImageView];
        LWWeakSelf(self);
        [_myfavorableImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.myOrderImageView.mas_bottom).offset(1);
            make.left.equalTo(weakself.mas_left);
            make.right.equalTo(weakself.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        UIImageView *image = [[UIImageView alloc]init];
        UILabel *label = [[UILabel alloc]init];
        
        image.image = [UIImage imageNamed:@"mine_yhj"];
        [_myfavorableImageView addSubview:image];
        label.text = @"优惠卷";
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_myfavorableImageView addSubview:label];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myfavorableImageView);
            make.left.equalTo(weakself.myfavorableImageView.mas_left).mas_offset(21/2);
            make.right.equalTo(label.mas_left).mas_offset(-(23/2));
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myfavorableImageView);
            make.left.equalTo(image.mas_right).mas_offset(23/2);
            
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        [_myfavorableImageView addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myfavorableImageView);
            make.right.equalTo(weakself.myfavorableImageView.mas_right).mas_offset(-(20/2));
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myfavorable)];        _myfavorableImageView.userInteractionEnabled = YES;
        [_myfavorableImageView addGestureRecognizer:tap];
        
    }
    return _myfavorableImageView;
}

/*
 账户安全
 */

- (UIImageView *)myAccountImageView{
    
    if (_myAccountImageView == nil) {
        _myAccountImageView = [[UIImageView alloc]init];
        [self addSubview:_myAccountImageView];
        LWWeakSelf(self);
        [_myAccountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.myOrderImageView.mas_bottom).offset(20/2);
            make.left.equalTo(weakself.mas_left);
            make.right.equalTo(weakself.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        UIImageView *image = [[UIImageView alloc]init];
        UILabel *label = [[UILabel alloc]init];
        
        image.image = [UIImage imageNamed:@"mine_zhaq"];
        [_myAccountImageView addSubview:image];
        label.text = @"账户安全";
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_myAccountImageView addSubview:label];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myAccountImageView);
            make.left.equalTo(weakself.myAccountImageView.mas_left).mas_offset(21/2);
            make.right.equalTo(label.mas_left).mas_offset(-(23/2));
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myAccountImageView);
            make.left.equalTo(image.mas_right).mas_offset(23/2);
            
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        [_myAccountImageView addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.myAccountImageView);
            make.right.equalTo(weakself.myAccountImageView.mas_right).mas_offset(-(20/2));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myAccount)];
        _myAccountImageView.userInteractionEnabled = YES;
        [_myAccountImageView addGestureRecognizer:tap];
    }
    return _myAccountImageView;
}

/*
 设置
 */

- (UIImageView *)setView{
    
    if (_setView == nil) {
        _setView = [[UIImageView alloc]init];
        [self addSubview:_setView];
        LWWeakSelf(self);
        [_setView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.myAccountImageView.mas_bottom).offset(1);
            make.left.equalTo(weakself.mas_left);
            make.right.equalTo(weakself.mas_right);
            make.height.equalTo(@(88/2));
        }];
        
        UIImageView *image = [[UIImageView alloc]init];
        UILabel *label = [[UILabel alloc]init];
        
        image.image = [UIImage imageNamed:@"mine_sz"];
        [_setView addSubview:image];
        label.text = @"设置";
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [_setView addSubview:label];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.setView);
            make.left.equalTo(weakself.setView.mas_left).mas_offset(21/2);
            make.right.equalTo(label.mas_left).mas_offset(-(23/2));
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.setView);
            make.left.equalTo(image.mas_right).mas_offset(23/2);
            
        }];
        
        UIImageView *imageGo = [[UIImageView alloc]init];
        imageGo.image = [UIImage imageNamed:@"right"];
        [_setView addSubview:imageGo];
        [imageGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.setView);
            make.right.equalTo(weakself.setView.mas_right).mas_offset(-(20/2));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mysetView)];
        _setView.userInteractionEnabled = YES;
        [_setView addGestureRecognizer:tap];
    }
    return _setView;
}


-(void)iconChoose{
    if ([self.delegate respondsToSelector:@selector(iconChooseBtClick)]) {
        [self.delegate iconChooseBtClick];
    }

}
- (void)studyRecord{

    if ([self.delegate respondsToSelector:@selector(myRecordClick)]) {
        [self.delegate myRecordClick];
    }
}
- (void)myCources{

    if ([self.delegate respondsToSelector:@selector(myCourceClick)]) {
        [self.delegate myCourceClick];
    }
}

- (void)myDownLoad{

    if ([self.delegate respondsToSelector:@selector(myDownLoadClick)]) {
        [self.delegate myDownLoadClick];
    }

}
- (void)myQuestion{

    if ([self.delegate respondsToSelector:@selector(myQuestionClick)]) {
        [self.delegate myQuestionClick];
    }

}
- (void)myOrder{
    
    if ([self.delegate respondsToSelector:@selector(myOrderClick)]) {
        [self.delegate myOrderClick];
    }
    
}
- (void)myfavorable{
    
    if ([self.delegate respondsToSelector:@selector(myFavableClick)]) {
        [self.delegate myFavableClick];
    }
    
}
- (void)myAccount{
    
    if ([self.delegate respondsToSelector:@selector(myAccountClick)]) {
        [self.delegate myAccountClick];
    }
    
}
- (void)mysetView{
    
    if ([self.delegate respondsToSelector:@selector(setClick)]) {
        [self.delegate setClick];
    }
    
}

- (void)loginedClick{
    if ([self.delegate respondsToSelector:@selector(loginClick)]) {
        [self.delegate loginClick];
    }
}

@end
