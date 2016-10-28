//
//  AYShareCollectionViewCell.h
//  TestWebNav
//
//  Created by kong on 16/7/19.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebCollectionModel.h"

@interface AYShareCollectionViewCell : UICollectionViewCell

/**
 *  名称
 */
@property (nonatomic, strong)UILabel *label;

/**
 *  背景图
 */
@property (nonatomic, strong)UIImageView *imgView;

@property (nonatomic, assign) WebShareType shareType;

@property (nonatomic, strong) WebCollectionModel *model;

@end
