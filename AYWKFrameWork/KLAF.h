//
//  KLAF.h
//  fengyanfengyu
//
//  Created by kong on 16/4/8.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^finishSuccessBlock)(id operation, id result);

typedef void(^progressBlock)(NSProgress *progress);

typedef void(^finishFalureBlock)(id operation, NSError *error);




@interface KLAF : NSObject

/**
 *  KL封装的网络请求框架
 *
 *  @param URLString     URL
 *  @param dic           入参
 *  @param string        请求方式
 *  @param successBlock  成功block
 *  @param progressBlock 下载/上传 进度
 *  @param failureBlock  失败Block
 *
 *  @return task
 */
+ (NSURLSessionDataTask *)requestDataWithUrlString:(NSString *)URLString
                                        Parameters:(NSDictionary *)dic
                                            Method:(NSString *)string
                                           Success:(finishSuccessBlock)successBlock
                                          Progress:(progressBlock)progressBlock
                                           Failure:(finishFalureBlock)failureBlock;





@end
