//
//  DownLoadCell.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/27.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "DownLoadCell.h"
#import "Definition.h"
#import "Masonry.h"
#import "Video.h"
#define kCellHeight 80/2

@interface DownLoadCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *selBtn;
@property (nonatomic, strong) id item;

@end
@implementation DownLoadCell

- (void)configureCellContentWithItem:(id)item baseCell:(LWBaseCell *)baseCell{
    self.item  = item;
    self.selBtn.backgroundColor = [UIColor clearColor];
    if ([((NSDictionary *)self.item)[@"isSelect"] isEqualToString:@"yes"]) {
        self.selBtn.selected = YES;
    }else if ( [((NSDictionary *)self.item)[@"isSelect"] isEqualToString:@"no"]){
        self.selBtn.selected = NO;
    
    }
    
    if ([([((NSDictionary *)item) valueForKey:@"normal"]) isKindOfClass:[Video class]]) {
        self.nameLabel.text =((Video *)[((NSDictionary *)item) valueForKey:@"normal"]).title;
    }else{
        self.nameLabel.text = [((NSDictionary *)item) valueForKey:@"normal"];
    }
}


- (UIButton *)selBtn{
    
    if (_selBtn == nil) {
        _selBtn = [[UIButton alloc]init];
        _selBtn.backgroundColor = [UIColor clearColor];
        [_selBtn setImage:[UIImage imageNamed:@"download_gray"] forState:UIControlStateNormal];
        [_selBtn setImage:[UIImage imageNamed:@"download_blue"] forState:UIControlStateSelected];
        [_selBtn addTarget:self action:@selector(commitBt:) forControlEvents:UIControlEventTouchUpInside];
        _selBtn.selected = NO;
        
        
        
        [self addSubview:_selBtn];
        LWWeakSelf(self);
        [_selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.mas_top).with.offset(24/2);
            if (![([((NSDictionary *)weakself.item) valueForKey:@"normal"]) isKindOfClass:[Video class]]) {
                make.left.equalTo(weakself.mas_left).offset(80/2);
            }else{
                make.left.equalTo(weakself.mas_left).offset(140/2);
            }
        }];
        
    }
    return _selBtn;
}

- (UILabel *)nameLabel{
    
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        
        [self addSubview:_nameLabel];
        LWWeakSelf(self);
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.selBtn);
            make.left.equalTo(weakself.selBtn.mas_right).offset(20/2);
            
        }];
        
    }
    return _nameLabel;
}


- (void)commitBt:(UIButton *)btn{
    if (!btn.selected) {
        btn.selected = YES;
    }else{
        btn.selected = NO;
    }
    
    NSString *sectionLabelTxt = nil;
    DownLoadCell * cell =(DownLoadCell *)btn.superview;
    for (UIView *labelView in cell.subviews) {
        if ([labelView isKindOfClass:[UILabel class]] ) {
            sectionLabelTxt = ((UILabel *)labelView).text;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(chapterChooseButtonClick:cell:button:)]) {
        [self.delegate chapterChooseButtonClick:sectionLabelTxt cell:cell button:btn];
    }


}

- (CGFloat)configureCellHeightWithItem:(id)item{
    return kCellHeight;
}

@end
