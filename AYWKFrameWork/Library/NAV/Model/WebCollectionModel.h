//
//  WebCollectionModel.h
//  Aoyou
//
//  Created by kong on 16/7/21.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebCollectionModel : NSObject

/**
 *  分享类型
 */
@property (nonatomic, assign) WebShareType shareType;

/**
 *  分享平台名称
 */
@property (nonatomic, copy) NSString *shareName;

/**
 *  图片名称
 */
@property (nonatomic, copy) NSString *imgName;


@end
