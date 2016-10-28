//
//  AYCollectionViewFlowLayout.h
//  TestWebNav
//
//  Created by kong on 16/7/19.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AYCollectionViewFlowLayout : UICollectionViewFlowLayout

/**
 *  分享类型
 */
@property (nonatomic, assign)WebShareType type;

/**
 *  分享个数
 */
@property (nonatomic, copy) NSString *shareCount;


@end
