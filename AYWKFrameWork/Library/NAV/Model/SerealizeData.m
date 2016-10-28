//
//  SerealizeData.m
//  TestWebNav
//
//  Created by kong on 16/7/21.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "SerealizeData.h"
#import "WebCollectionModel.h"

@implementation SerealizeData

+ (NSDictionary *)dicWithURLString:(NSString *)encodeStr
{
    //URL解码
    NSString *codeStr         = [encodeStr stringByRemovingPercentEncoding];
    NSRange jsonRange         = [codeStr rangeOfString:@"://"];
    NSString *jsonStr         = [codeStr substringFromIndex:jsonRange.location + 3];
    
    if (jsonStr == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}

+ (NSArray *)arrayWithContent:(NSArray *)array
{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < array.count; i++)
    {
        NSString *string = array[i];
        
        WebCollectionModel *colModel = [[WebCollectionModel alloc] init];
        
        if ([string isEqualToString:@"weixin_share"])
        {
            colModel.shareType = ShareToWeChat;
            colModel.shareName = @"微信好友";
            colModel.imgName = @"weixin";
            [arr addObject:colModel];
            
        }else if ([string isEqualToString:@"pengy_share"]){
            
            colModel.shareType = ShareToWeChatFriends;
            colModel.shareName = @"朋友圈";
            colModel.imgName = @"friend";
            [arr addObject:colModel];
            
        }else if ([string isEqualToString:@"weib_share"]){
            
            colModel.shareType = ShareToSina;
            colModel.shareName = @"新浪微博";
            colModel.imgName = @"weibo";
            [arr addObject:colModel];
            
        }else if ([string isEqualToString:@"duanx_share"]){
            
            colModel.shareType = ShareToMessage;
            colModel.shareName = @"短信";
            colModel.imgName = @"sms";
            [arr addObject:colModel];
            
        }else if ([string isEqualToString:@"lianjie_share"]){
            
            colModel.shareType = ShareToLianjie;
            colModel.shareName = @"复制链接";
            colModel.imgName = @"copy";
            [arr addObject:colModel];
            
        }else if ([string isEqualToString:@"shoucang_share"]){
            
            colModel.shareType = ShareToFavourite;
            colModel.shareName = @"加入收藏";
            colModel.imgName = @"favorite";
            [arr addObject:colModel];
        }
    }
    
    return arr;
}



@end
