//
//  KLDataBase.h
//  DownLoadDocument
//
//  Created by kong on 16/10/12.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^buildThen)();

@interface KLDataBase : NSObject

+ (instancetype)shareInstance;

- (void)requestAYString:(NSString *)string
                  Bulid:(buildThen)bulidBlock;

//- (void)requestAYString:(NSString *)string;

@end
