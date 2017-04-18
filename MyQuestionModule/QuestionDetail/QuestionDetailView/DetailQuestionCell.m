//
//  DetailQuestionCell.m
//  ZWEducation
//
//  Created by 李炜 on 2017/4/14.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "DetailQuestionCell.h"
#import "Definition.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "QuestionModel.h"
#import "AnswerModel.h"
#import "UserModel.h"
@interface DetailQuestionCell ()

// first cell
@property (nonatomic, strong) UILabel *summery;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UILabel *originLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UIImageView *answerCountView;
@property (nonatomic, strong) UILabel *answerCountLabel;
@property (nonatomic, assign) CGRect timeRect;

// other cell
@property (nonatomic, strong) UILabel *otherUser;
@property (nonatomic, strong) UILabel *otherContent;
@property (nonatomic, strong) UILabel *otherTime;

@end
@implementation DetailQuestionCell

- (void)configureCellContentWithItem:(id)item{
    
    if ([item isMemberOfClass:[QuestionModel class]]) {
        self.summery.text =((QuestionModel *)item).title;
        self.content.text =((QuestionModel *)item).descrip;
        self.originLabel.text =((QuestionModel *)((QuestionModel *)item).category).title;
        [self answerCountView];
        self.answerCountLabel.text =[NSString stringWithFormat:@"%@条回复",((QuestionModel *)item).answers];
        self.timeRect = [((QuestionModel *)item).created_at  boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20,2000)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}context:nil];
        self.timeLabel.text = ((QuestionModel *)item).created_at;
        self.nickNameLabel.text =((UserModel *)(((QuestionModel *)item).user)).nickname;
    }else{
    
         self.otherUser.text = ((UserModel *)(((AnswerModel *)item).user)).nickname;
         self.otherContent.text = ((AnswerModel *)item).content;
         self.otherTime.text = ((AnswerModel *)item).created_at;
    }
    
    
}

- (UILabel *)summery{
    
    if (_summery == nil) {
        _summery = [[UILabel alloc]init];
        _summery.textColor = [UIColor colorWithHexString:@"#000000"];
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
        _content.textColor = [UIColor colorWithHexString:@"#666666"];
        _content.font = [UIFont systemFontOfSize:13];
        _content.numberOfLines = 0;
        LWWeakSelf(self);
        [self addSubview:_content];
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.summery.mas_bottom).with.offset((24/2));
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

- (UIImageView *)answerCountView{
    
    if (_answerCountView == nil) {
        _answerCountView = [[UIImageView alloc]init];
        _answerCountView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.000];
        [self addSubview:_answerCountView];
        LWWeakSelf(self);
        [_answerCountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.originLabel.mas_bottom).offset(20/2);
            make.left.equalTo(weakself.mas_left);
            make.right.equalTo(weakself.mas_right);
            make.height.equalTo(@(74/2));
        }];
    }
    return _answerCountView;
}


- (UILabel *)answerCountLabel{
    
    if (_answerCountLabel == nil) {
        _answerCountLabel = [[UILabel alloc]init];
        _answerCountLabel.textAlignment = NSTextAlignmentLeft;
        _answerCountLabel.textColor = [UIColor grayColor];
        _answerCountLabel.font = [UIFont systemFontOfSize:14];
        LWWeakSelf(self);
        [self.answerCountView addSubview:_answerCountLabel];
        [_answerCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.answerCountView);
            make.left.equalTo(weakself.answerCountView.mas_left).offset(20/2);
            make.height.equalTo(@(30/2));
            
        }];
        
    }
    return _answerCountLabel;
}
- (UILabel *)timeLabel{
    
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _timeLabel.font = [UIFont systemFontOfSize:12];
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

- (UILabel *)nickNameLabel{
    
    if (_nickNameLabel == nil) {
        _nickNameLabel = [[UILabel alloc]init];
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
        _nickNameLabel.textColor = [UIColor colorWithHexString:@"#33b1e0"];
        _nickNameLabel.font = [UIFont systemFontOfSize:12];
        LWWeakSelf(self);
        [self addSubview:_nickNameLabel];
        [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.originLabel);
            make.left.equalTo(weakself.timeLabel.mas_right);
            make.height.equalTo(@(30/2));
          //  make.width.equalTo(@(weakself.timeRect.size.width));
        }];
        
    }
    return _nickNameLabel;
}


// other cell
- (UILabel *)otherUser{
    
    if (_otherUser == nil) {
        _otherUser = [[UILabel alloc]init];
        _otherUser.textAlignment = NSTextAlignmentLeft;
        _otherUser.textColor = [UIColor colorWithHexString:@"#33b1e0"];
        _otherUser.font = [UIFont systemFontOfSize:14];
        LWWeakSelf(self);
        [self addSubview:_otherUser];
        [_otherUser mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.mas_top).offset(30/2);
            make.left.equalTo(weakself.mas_left).offset(20/2);
            make.height.equalTo(@(30/2));
            //  make.width.equalTo(@(weakself.timeRect.size.width));
        }];
        
    }
    return _otherUser;
}

- (UILabel *)otherContent{
    
    if (_otherContent == nil) {
        _otherContent = [[UILabel alloc]init];
        _otherContent.textAlignment = NSTextAlignmentLeft;
        _otherContent.textColor = [UIColor colorWithHexString:@"#666666"];
        _otherContent.numberOfLines = 0;
        _otherContent.font = [UIFont systemFontOfSize:14];
        LWWeakSelf(self);
        [self addSubview:_otherContent];
        [_otherUser mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.otherUser.mas_bottom).offset(20/2);
            make.left.equalTo(weakself.otherUser);
           // make.height.equalTo(@(30/2));
             make.width.equalTo(@(ScreenWidth - 20));
        }];
        
    }
    return _otherContent;
}

- (UILabel *)otherTime{
    
    if (_otherTime == nil) {
        _otherTime = [[UILabel alloc]init];
        _otherTime.textAlignment = NSTextAlignmentRight;
        _otherTime.textColor = [UIColor colorWithHexString:@"#999999"];
        _otherTime.font = [UIFont systemFontOfSize:12];
        LWWeakSelf(self);
        [self addSubview:_otherTime];
        [_otherTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakself.mas_bottom).offset(-(20/2));
            make.right.equalTo(weakself.mas_right).offset(-(18/2));
        }];
        
    }
    return _otherTime;
}

- (CGFloat)configureCellHeightWithItem:(id)item{
    
    
    CGRect titleRect = [((QuestionModel *)item).title  boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20,2000)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}context:nil];
    
    CGRect descripRect = [((QuestionModel *)item).descrip  boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20,2000)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}context:nil];
    
    return titleRect.size.height + descripRect.size.height  + 30/2 +24/2 +20/2 +20/2 +24/2 + 74/2;
    
}


@end
