//
//  StudyRecoderCell.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/23.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "StudyRecoderCell.h"
#import "Definition.h"
#import "Masonry.h"

#define kCellHeight 80
@interface StudyRecoderCell ()

@property (nonatomic, strong) UIImageView *clockImage;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *lastVideoTimeLabel;
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation StudyRecoderCell

- (void)configureCellContentWithItem:(id)item baseCell:(LWBaseCell *)baseCell{
    self.clockImage.backgroundColor = [UIColor clearColor];
    self.timeLabel.text = @"2017-03-30";
    self.nameLabel.text = @"ascascasc";
    self.descLabel.text = @"111111";
    self.lastVideoTimeLabel.text = @"2002.15.11";
    self.deleteBtn.backgroundColor = [UIColor clearColor];
}

- (UIImageView *)clockImage{
    
    if (_clockImage == nil) {
        _clockImage = [[UIImageView alloc]init];
        _clockImage.contentMode = UIViewContentModeScaleAspectFit;
        _clockImage.backgroundColor = [UIColor clearColor];
        _clockImage.image = [UIImage imageNamed:@"xxjl_time"];
        [self addSubview:_clockImage];
        LWWeakSelf(self);
        [_clockImage mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(weakself);
            make.top.equalTo(weakself.mas_top).with.offset(20/2);
            make.left.equalTo(weakself.mas_left).with.offset(35/2);
//            make.width.equalTo(@(240/2));
//            make.height.equalTo(@(144/2));
        }];
        
    }
    return _clockImage;
}


- (UILabel *)timeLabel{
    
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#33b1e0"];
        _timeLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_timeLabel];
        LWWeakSelf(self);
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.clockImage);
          //  make.top.equalTo(weakself.iconImage.mas_top).with.offset(26/2);
            make.left.equalTo(weakself.clockImage.mas_right).with.offset(20/2);
            //  make.height.equalTo(@15);
            
        }];
        
    }
    return _timeLabel;
}


- (UILabel *)nameLabel{
    
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_nameLabel];
        LWWeakSelf(self);
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           // make.centerY.equalTo(weakself.clockImage);
            make.top.equalTo(weakself.timeLabel.mas_bottom).with.offset(20/2);
            make.left.equalTo(weakself.timeLabel);
            //  make.height.equalTo(@15);
            
        }];
        
    }
    return _nameLabel;
}


- (UILabel *)descLabel{
    
    if (_descLabel == nil) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.backgroundColor = [UIColor clearColor];
        _descLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _descLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_descLabel];
        LWWeakSelf(self);
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            // make.centerY.equalTo(weakself.clockImage);
            make.top.equalTo(weakself.nameLabel.mas_bottom).with.offset(20/2);
            make.left.equalTo(weakself.timeLabel);
            //  make.height.equalTo(@15);
            
        }];
        
    }
    return _descLabel;
}

- (UILabel *)lastVideoTimeLabel{
    
    if (_lastVideoTimeLabel == nil) {
        _lastVideoTimeLabel = [[UILabel alloc]init];
        _lastVideoTimeLabel.backgroundColor = [UIColor clearColor];
        _lastVideoTimeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _lastVideoTimeLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_lastVideoTimeLabel];
        LWWeakSelf(self);
        [_lastVideoTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            // make.centerY.equalTo(weakself.clockImage);
            make.top.equalTo(weakself.descLabel.mas_bottom).with.offset(20/2);
            make.left.equalTo(weakself.timeLabel);
            //  make.height.equalTo(@15);
            
        }];
        
    }
    return _lastVideoTimeLabel;
}

- (UIButton *)deleteBtn{
    
    if (_deleteBtn == nil) {
        _deleteBtn = [[UIButton alloc]init];
        _deleteBtn.backgroundColor = [UIColor clearColor];
        [_deleteBtn setImage:[UIImage imageNamed:@"xxjl_delete"] forState:UIControlStateNormal];
        
        [self addSubview:_deleteBtn];
        LWWeakSelf(self);
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            // make.centerY.equalTo(weakself.clockImage);
            make.top.equalTo(weakself.descLabel.mas_bottom).with.offset(20/2);
            make.left.equalTo(weakself.timeLabel);
            //  make.height.equalTo(@15);
            
        }];
        
    }
    return _deleteBtn;
}

@end
