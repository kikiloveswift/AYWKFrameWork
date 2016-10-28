//
//  AYShareCollectionViewCell.m
//  TestWebNav
//
//  Created by kong on 16/7/19.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "AYShareCollectionViewCell.h"

@implementation AYShareCollectionViewCell

- (UILabel *)label
{
    if (_label == nil)
    {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 52, 20)];
        
        _label.backgroundColor = [UIColor clearColor];
        
        _label.font = [UIFont systemFontOfSize:13.0f];
        
        _label.textAlignment = NSTextAlignmentCenter;
        
        _label.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _label;
}

- (UIImageView *)imgView
{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _imgView.layer.cornerRadius = 25.0f;
        
    }
    return _imgView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
       
    }
    return self;
}

- (void)setModel:(WebCollectionModel *)model
{
    if (_model != model)
    {
        _model = model;
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView addSubview:self.label];
    self.layer.cornerRadius = 25.0f;
    self.shareType = self.model.shareType;
    self.label.text = self.model.shareName;
    self.backgroundView = self.imgView;
    self.imgView.image = [UIImage imageNamed:self.model.imgName];
}


@end
