//
//  KLData.h
//  fengyanfengyu
//
//  Created by kong on 16/4/9.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLData : NSObject

/**
 *  解析JSON
 *
 *  @param jsonString 传入NSString或者NSData
 *
 *  @return JSONDic
 */
+ (id)dicWithJsonString:(id)jsonString;




/**
 DIC--->String

 @param message message
 @param pretty  pretty

 @return string
 */
+ (NSString *)_serializeMessage:(id)message pretty:(BOOL)pretty;


/**
 解析CFString

 @param cfString CFString

 @return Dic
 */
+ (NSDictionary *)dicWithCFString:(id)cfString;

/**
 *  解析本地JSON文件
 *
 *  @param pathName 文件名
 *
 *  @return JSON字典
 */
+ (id)dicJSONWithLocalPathName:(NSString *)pathName;

/**
 *  URL编码
 *
 *  @param string 普通字符串
 *
 *  @return 编码字符串
 */
+ (NSString *)stringEncodingWithString:(NSString *)string;

/**
 *  URL解码
 *
 *  @param string 编码字符串
 *
 *  @return 普通字符串
 */
+ (NSString *)stringDecodingWithString:(NSString *)string;



@end
