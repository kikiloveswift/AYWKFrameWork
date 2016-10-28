//
//  TestWebModel.m
//  TestWebNav
//
//  Created by kong on 16/7/21.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "TestWebModel.h"
#import "FavoriteModel.h"

@implementation TestWebModel

- (id)initContentWithDic:(NSDictionary *)jsonDic
{
    self = [super initContentWithDic:jsonDic];
    if (self)
    {
        //默认属性为不需要拼接图片
        self.imgType = ShareIMGNone;
        //处理特殊属性
        //FIXME: 如果分享图片需要特殊拼接 在此处进行拼接 如果不需要拼接  就不用处理
        NSRange range = [self.share_image_url rangeOfString:@"WAP端拼接的特殊标记字符串"];
        
        if (range.length > 0)
        {
            self.share_image_url = @"在括号里面处理之后再给self.share_image_url赋值";
            self.imgType = ShareIMGTrue;
        }
        
        //把收藏的数据装入FavoriteModel中
        if (self.favorite != nil && [self.favorite isKindOfClass:[NSDictionary class]])
        {
            self.favorite = [[FavoriteModel alloc] initContentWithDic:self.favorite];
        }
    }
    
    return self;
}

@end
