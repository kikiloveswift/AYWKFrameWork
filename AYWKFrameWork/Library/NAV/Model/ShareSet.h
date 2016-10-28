//
//  ShareSet.h
//  Aoyou
//
//  Created by kong on 16/7/25.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteModel.h"

@interface ShareSet : NSObject


/**
*  分享集合
*
*  @param type          分享类型
*  @param imgType       分享图片是否要拼图
*  @param shareTitle    标题
*  @param shareText     分享内容
*  @param types         UM的分享类型是数组型
*  @param url           分享标题
*  @param imgURL        分享图片Ulr
*  @param favoriteModel  收藏Model
*/
+ (void)sharePlatForm:(WebShareType)type
              IMGType:(ShareIMGType)imgType
                Title:(NSString *)shareTitle
              Content:(NSString *)shareText
               UMType:(NSArray *)types
                  URL:(NSString *)url
             ImageUrl:(NSString *)imgURL
             Favorite:(FavoriteModel *)favoriteModel;

@end
