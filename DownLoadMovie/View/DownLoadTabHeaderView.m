//
//  TabViewHeaderView.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/20.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "DownLoadTabHeaderView.h"
#import "Definition.h"
#import "Masonry.h"
//#import "LWControl.h"
@interface DownLoadTabHeaderView ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *memoryLabel;
@property (nonatomic, strong) UIImageView *iconImage;

@end

@implementation DownLoadTabHeaderView

-(id)initWithFrame:(CGRect)frame
             title:(NSString*)title
             image:(NSString*)imageStr
           section:(NSInteger)sectionNumber
          delegate:(id <DownSectionHeaderViewDelegate>)delegate{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mem_toggleOpen:)];
        [self addGestureRecognizer:tapGesture];
        _delegate = delegate;
        self.userInteractionEnabled = YES;
        //设置标题
        _section = sectionNumber;
        self.button.selected = NO;
        
        self.rightButton.backgroundColor = [UIColor clearColor];
        self.iconImage.image = [UIImage imageNamed:imageStr];
        self.label.text  = title;
        self.memoryLabel.text = @"已缓存5个任务60MB";
       
    }
    return self;
}

-(void)isSelect:(NSString *)isSelect{
    if ([isSelect isEqualToString:@"yes"]) {
        self.button.selected = YES;
    }else if([isSelect isEqualToString:@"no"]){
        self.button.selected = NO;
    }

}
-(void)mem_toggleOpenWithUserAction:(BOOL)userAction{

    //改变分组按钮选中状态
    self.rightButton.selected = !self.rightButton.selected;
    
    // 默认userAction一直都是yes
    if (userAction) {
        if (self.rightButton.selected) {
            if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
                [self.delegate sectionHeaderView:self sectionOpened:self.section];
            }
        }
        else {
            if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
                [self.delegate sectionHeaderView:self sectionClosed:self.section];
            }
        }
    }

}

- (void)mem_toggleOpen:(id)sender {
    
    [self mem_toggleOpenWithUserAction:YES];
}


- (UIButton *)button{
    if (_button == nil) {
        
        
        _button = [[UIButton alloc]init];
        [_button setImage:[UIImage imageNamed:@"download_gray"] forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:@"download_blue"] forState:UIControlStateSelected];
        _button.selected = NO;
        [_button addTarget:self action:@selector(allChooseBt:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        LWWeakSelf(self);
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.mas_left).offset(20/2);
            make.centerY.equalTo(weakself.mas_centerY);
        }];
        

        
    }
    return _button;
}

- (UIButton *)rightButton{
    if (_rightButton == nil) {
        
        
        _rightButton = [[UIButton alloc]init];
        [_rightButton setImage:[UIImage imageNamed:@"download_close"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"download_open"] forState:UIControlStateSelected];
        [_rightButton addTarget:self action:@selector(mem_toggleOpen:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.selected = NO;
        [self addSubview:_rightButton];
        LWWeakSelf(self);
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakself.mas_right).offset(-(20/2));
            make.centerY.equalTo(weakself.mas_centerY);
        }];
        
        
        
    }
    return _rightButton;
}


- (UIImageView *)iconImage{
    if (_iconImage == nil) {
        
        _iconImage = [[UIImageView alloc]init];
        _iconImage.userInteractionEnabled = YES;
        _iconImage.backgroundColor = [UIColor grayColor];
        [self addSubview:_iconImage];
        LWWeakSelf(self);
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.button.mas_right).offset(20/2);
            make.top.equalTo(weakself.mas_top).offset(25/2);
            make.width.equalTo(@(222/2));
            make.height.equalTo(@(weakself.frame.size.height-25));
        }];
        
        
        
    }
    return _iconImage;
}


- (UILabel *)label{

    if (_label == nil) {
        
        _label = [[UILabel alloc]init];
        _label.textColor = [UIColor colorWithHexString:@"#333333"];
        _label.font= [UIFont systemFontOfSize:13];
        LWWeakSelf(self);
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.mas_top).offset(50/2);
            make.left.equalTo(weakself.iconImage.mas_right).mas_offset(20/2);
           
        }];
    }
    return _label;
}


- (UILabel *)memoryLabel{
    
    if (_memoryLabel == nil) {
        _memoryLabel = [[UILabel alloc]init];
        _memoryLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _memoryLabel.font= [UIFont systemFontOfSize:11];
        LWWeakSelf(self);
        [self addSubview:_memoryLabel];
        [_memoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.label.mas_bottom).offset(39/2);
            make.left.equalTo(weakself.label.mas_left);
            
        }];
    }
    return _memoryLabel;
}
- (void)allChooseBt:(UIButton *)button{
    
    if (!button.selected) {
        button.selected = YES;
    }else{
        button.selected = NO;
    }
    
    
    if ([self.delegate respondsToSelector:@selector(allChooseHeaderBtClick:section:)]) {
        [self.delegate allChooseHeaderBtClick:button section:self.section];
    }

}

@end
