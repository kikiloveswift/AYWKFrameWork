//
//  AYAFSessionManager.h
//  DownLoadDocument
//
//  Created by kong on 16/10/17.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AYAFSessionManager : NSObject

+ (AFURLSessionManager *)shareSessionManager;

@end
