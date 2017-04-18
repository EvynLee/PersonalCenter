//
//  MyQuestionCell.m
//  ZWEducation
//
//  Created by 李炜 on 2017/4/13.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "MyQuestionCell.h"
#import "Definition.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "MyQuestionModel.h"
#import "MyQuestionCategoryModel.h"
@interface MyQuestionCell ()
@property (nonatomic, strong) UILabel *summery;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UILabel *originLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *answerLabel;
@property (nonatomic, strong) UILabel *answerCount;
@property (nonatomic, strong) UIImageView *megIcon;

@property (nonatomic, assign) CGRect timeRect;
@end
@implementation MyQuestionCell

- (void)configureCellContentWithItem:(id)item{
     self.summery.text =((MyQuestionModel *)item).title;
     self.content.text =((MyQuestionModel *)item).descrip;
     self.originLabel.text =((MyQuestionCategoryModel *)((MyQuestionModel *)item).category).title;
    
     self.timeRect = [((MyQuestionModel *)item).created_at  boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20,2000)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}context:nil];
    
     self.timeLabel.text =((MyQuestionModel *)item).created_at;
     self.answerCount.text =[((MyQuestionModel *)item).answers stringValue];
     [self megIcon];
     self.answerLabel.text =[((MyQuestionModel *)item).views stringValue];
}

- (UILabel *)summery{
    
    if (_summery == nil) {
        _summery = [[UILabel alloc]init];
        _summery.textColor = [UIColor blackColor];
        _summery.font = [UIFont systemFontOfSize:15];
        _summery.numberOfLines = 0;
        LWWeakSelf(self);
        [self addSubview:_summery];
        [_summery mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.mas_top).with.offset((30/2));
            make.left.equalTo(weakself.mas_left).with.offset((20/2));
            
        }];
        
    }
    return _summery;
}


- (UILabel *)content{
    
    if (_content == nil) {
        _content = [[UILabel alloc]init];
        _content.textColor = [UIColor colorWithHexString:@"#333333"];
        _content.font = [UIFont systemFontOfSize:13];
        _content.numberOfLines = 0;
        LWWeakSelf(self);
        [self addSubview:_content];
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.summery.mas_bottom).with.offset((25/2));
            make.left.equalTo(weakself.mas_left).with.offset((20/2));
            make.width.equalTo(@(ScreenWidth - 20));
        }];
        
    }
    return _content;
}

- (UILabel *)originLabel{
    
    if (_originLabel == nil) {
        _originLabel = [[UILabel alloc]init];
        _originLabel.textAlignment = NSTextAlignmentCenter;
        _originLabel.textColor = [UIColor colorWithHexString:@"#f77d10"];
        _originLabel.font = [UIFont systemFontOfSize:11];
        _originLabel.layer.borderWidth = 1.0f;
        _originLabel.layer.cornerRadius = 5;
        _originLabel.layer.borderColor = [UIColor colorWithHexString:@"#f77d10"].CGColor;

        LWWeakSelf(self);
        [self addSubview:_originLabel];
        [_originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.content.mas_bottom).with.offset((20/2));
            make.left.equalTo(weakself.summery);
            make.width.equalTo(@(80/2));
            make.height.equalTo(@(30/2));
            
        }];
        
    }
    return _originLabel;
}

- (UILabel *)timeLabel{
    
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont systemFontOfSize:11];
      //  NSLog(@"--%f",self.timeRect.size.width);
        LWWeakSelf(self);
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.originLabel);
            make.left.equalTo(weakself.originLabel.mas_right).offset(5);
            make.height.equalTo(@(30/2));
            make.width.equalTo(@(weakself.timeRect.size.width));
        }];
        
    }
    return _timeLabel;
}

- (UILabel *)answerCount{
    
    if (_answerCount == nil) {
        _answerCount = [[UILabel alloc]init];
        _answerCount.textColor = [UIColor grayColor];
        _answerCount.font = [UIFont systemFontOfSize:13];
        
        LWWeakSelf(self);
        [self addSubview:_answerCount];
        [_answerCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.originLabel);
            make.right.equalTo(weakself.mas_right).offset(-(20/2));
            
            
        }];
        
    }
    return _answerCount;
}

- (UIImageView *)megIcon{
    
    if (_megIcon == nil) {
        _megIcon = [[UIImageView alloc]init];
        _megIcon.image = [UIImage imageNamed:@"wddy_messages"];
        [self addSubview:_megIcon];
        LWWeakSelf(self);
        [_megIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.originLabel);
            make.right.equalTo(weakself.answerCount.mas_left).offset(-(16/2));
        }];
    }
    return _megIcon;
}

- (UILabel *)answerLabel{
    
    if (_answerLabel == nil) {
        _answerLabel = [[UILabel alloc]init];
        _answerLabel.textAlignment = NSTextAlignmentLeft;
        _answerLabel.textColor = [UIColor colorWithHexString:@"#33b1e0"];
        _answerLabel.font = [UIFont systemFontOfSize:11];
        
        LWWeakSelf(self);
        [self addSubview:_answerLabel];
        [_answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.originLabel);
             make.right.equalTo(weakself.megIcon.mas_left).offset(-(22/2));
            make.height.equalTo(@(35/2));
            
        }];
        
    }
    return _answerLabel;
}

- (CGFloat)configureCellHeightWithItem:(id)item{


    CGRect titleRect = [((MyQuestionModel *)item).title  boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20,2000)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}context:nil];
    
     CGRect descripRect = [((MyQuestionModel *)item).descrip  boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20,2000)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}context:nil];
    
    return titleRect.size.height + descripRect.size.height  + 30/2 +30/2 +30/2 +20/2 +20/2;
    
}

@end
