//
//  NSString+LocalFile.h
//  DownLoadDocument
//
//  Created by kong on 16/10/11.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LocalFile)

- (instancetype)cacheDir;

- (instancetype)docDir;

- (instancetype)temDir;

@end
