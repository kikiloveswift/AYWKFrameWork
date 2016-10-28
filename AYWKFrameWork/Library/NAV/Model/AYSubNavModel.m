//
//  AYSubNavModel.m
//  Aoyou
//
//  Created by kong on 16/7/28.
//  Copyright © 2016年 test. All rights reserved.
//  导航栏数据

#import "AYSubNavModel.h"

@implementation AYSubNavModel

- (id)initContentWithDic:(NSDictionary *)jsonDic
{
    self = [super initContentWithDic:jsonDic];
    if (self)
    {
        //FIXME: 处理十六进制颜色的#
        NSString *string = self.background_color;
        NSRange range = [string rangeOfString:@"#"];
        if (range.length > 0)
        {
            self.background_color = [string substringFromIndex:range.location + 1];
        }
        
    }
    return self;
}


@end
