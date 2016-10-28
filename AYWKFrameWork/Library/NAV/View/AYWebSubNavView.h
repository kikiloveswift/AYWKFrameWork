//
//  AYWebSubNavView.h
//  Aoyou
//
//  Created by kong on 16/7/28.
//  Copyright © 2016年 test. All rights reserved.
//

#import "AYWebNavView.h"
#import "AYSubNavModel.h"

@interface AYWebSubNavView : AYWebNavView

@property (nonatomic, strong) AYSubNavModel *subNavModel;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)setSubNavModel:(AYSubNavModel *)subNavModel;

@end
