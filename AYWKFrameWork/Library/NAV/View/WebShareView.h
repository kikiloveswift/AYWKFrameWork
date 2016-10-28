//
//  WebShareView.h
//  TestWebNav
//
//  Created by kong on 16/7/19.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AYWebNavView.h"

typedef void(^RefreshBlock)();

@interface WebShareView : UICollectionView

@property (nonatomic, strong) NSArray* dataArr;

@property (nonatomic, copy) RefreshBlock block;

/**
 *  分享具体内容的Arr
 */
@property (nonatomic, strong) NSArray *contentArr;


/**
 *  收藏内容Arr装入的是favoriteModel
 */
@property (nonatomic, strong) NSArray *favoriteArr;

/**
 *  取消分享代理
 */
@property (nonatomic, weak) id<CancleShareDelegate> cancleSharedelegate;


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout;



@end
