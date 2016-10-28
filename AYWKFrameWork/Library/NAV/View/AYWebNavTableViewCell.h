//
//  AYWebNavTableViewCell.h
//  Aoyou
//
//  Created by kong on 16/8/1.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AYWebNavModel.h"

@interface AYWebNavTableViewCell : UITableViewCell

/**
 *  model
 */
@property (nonatomic, strong) AYWebNavModel *model;

/**
 *  名称
 */
@property (nonatomic, strong) UILabel *label;

/**
 *  图片
 */
@property (nonatomic, strong) UIImageView *imgView;

/**
 *  动作类型
 */
@property (nonatomic, assign) ActionTableType type;

@end
