//
//  SerealizeData.h
//  TestWebNav
//
//  Created by kong on 16/7/21.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SerealizeData : NSObject

/**
 *  URL----》字典
 *
 *  @param encodeStr 编码URL
 *
 *  @return JSONdic
 */
+ (NSDictionary *)dicWithURLString:(NSString *)encodeStr;

/**
 *  根据share_type指定相应的文本和图片
 *
 *  @param array
 *
 *  @return
 */
+ (NSArray *)arrayWithContent:(NSArray *)array;



@end
