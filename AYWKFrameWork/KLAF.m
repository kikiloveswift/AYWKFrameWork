//
//  KLAF.m
//  fengyanfengyu
//
//  Created by kong on 16/4/8.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "KLAF.h"
#import <CFNetwork/CFNetwork.h>

@implementation KLAF

+ (NSURLSessionDataTask *)requestDataWithUrlString:(NSString *)URLString
                                        Parameters:(NSDictionary *)dic
                                            Method:(NSString *)string
                                           Success:(finishSuccessBlock)successBlock
                                          Progress:(progressBlock)progressBlock
                                           Failure:(finishFalureBlock)failureBlock
{
    
    AFHTTPSessionManager *mange = [AFHTTPSessionManager manager];
    
    mange.requestSerializer  = [AFJSONRequestSerializer serializer];
    mange.responseSerializer = [AFJSONResponseSerializer serializer];
    [mange.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [mange.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    [mange.requestSerializer setValue:kAppUserAgentValue forHTTPHeaderField:@"User-Agent"];
    
    NSURLSessionDataTask *task = nil;
    
    //GET请求
    if ([string isEqualToString:@"GET"]){
        
    task = [mange GET:URLString parameters:dic progress:^(NSProgress * _Nonnull downloadProgress){
        
            if (progressBlock){
                
                progressBlock(downloadProgress);
            }
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            
            
            if (successBlock){
                
                successBlock(task,responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            
            if (failureBlock){
                
                failureBlock(task,error);
            }
        }];
        
     //POST请求
    }else if ([string isEqualToString:@"POST"]){
        
    task = [mange POST:URLString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
            if (progressBlock){
                
                progressBlock(uploadProgress);
            }
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            if (successBlock){
                
                successBlock(task,responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failureBlock){
                
                failureBlock(task,error);
            }
        }];
    }
    return task;
}

//+ (AFSecurityPolicy*)customSecurityPolicy
//{
//    
//    /**** SSL Pinning ****/
//    
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"AYHtttps" ofType:@"cer"];
//    
//    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
//    
//    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
//    
//    [securityPolicy setAllowInvalidCertificates:YES];
//    
//    [securityPolicy setValidatesCertificateChain:YES];
//    
//    [securityPolicy setPinnedCertificates:@[certData]];
//    
//    /**** SSL Pinning ****/
//    
//    return securityPolicy;
//    
//}


@end
