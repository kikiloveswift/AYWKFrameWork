//
//  AYWebNavTableViewCell.m
//  Aoyou
//
//  Created by kong on 16/8/1.
//  Copyright © 2016年 test. All rights reserved.
//

#import "AYWebNavTableViewCell.h"

@implementation AYWebNavTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(AYWebNavModel *)model
{
    if (_model != model) {
        _model = model;
    }
    
    [self setNeedsLayout];
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(46, 11, 80, 23)];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.font = [UIFont systemFontOfSize:16.0f];
    }
    
    return _label;
}

- (UIImageView *)imgView
{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 20, 20)];
        
    }
    return _imgView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //FIXME: 下拉列表中 收藏和TEL是灰色的
    if ([self.model.labelText isEqualToString:@"favorite"])
    {
        self.label.text = @"收藏";
        self.imgView.image = [UIImage imageNamed:@"hybrid_graystarfavor"];
        self.type = ActionTableTypeFavourite;
        
    }else if ([self.model.labelText isEqualToString:@"my_favorite"]){
        
        self.label.text = @"我的收藏";
        self.imgView.image = [UIImage imageNamed:@"hybrid_favorbag"];
        self.type = ActionTableTypeMy_Favourite;
    }else if ([self.model.labelText isEqualToString:@"history"]){
    
        self.label.text = @"足迹";
        self.imgView.image = [UIImage imageNamed:@"hybrid_history"];
        self.type = ActionTableTypeHistory;
    }else if ([self.model.labelText isEqualToString:@"home"]){
        
        self.label.text = @"首页";
        self.imgView.image = [UIImage imageNamed:@"hybrid_home"];
        self.type = ActionTableTypeHome;
        
    }else if ([self.model.labelText isEqualToString:@"search"]){
        
        self.label.text = @"搜索";
        self.imgView.image = [UIImage imageNamed:@"hybrid_search"];
        self.type = ActionTableTypeSearch;
    }else if ([self.model.labelText isEqualToString:@"tel"]){
        
        self.label.text = @"TEL";
        self.imgView.image = [UIImage imageNamed:@"hybrid_graytel"];
        self.type = ActionTableTypeTel;
    }else if ([self.model.labelText isEqualToString:@"share"]){
        self.label.text = @"分享";
        self.imgView.image = [UIImage imageNamed:@"hybrid_share"];
        self.type = ActionTableTypeShare;
    }
    
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.imgView];
}

@end
