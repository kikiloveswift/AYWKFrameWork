//
//  ShareSet.m
//  Aoyou
//
//  Created by kong on 16/7/25.
//  Copyright © 2016年 test. All rights reserved.
//  友盟分享集合

#import "ShareSet.h"
#import "AppDelegate.h"
//#import "UMSocialControllerService.h"
//#import "UMSocialAccountManager.h"
//#import "UMSocial.h"
//#import "WeiboSDK.h"



@implementation ShareSet

+ (void)sharePlatForm:(WebShareType)type
              IMGType:(ShareIMGType)imgType
                Title:(NSString *)shareTitle
              Content:(NSString *)shareText
               UMType:(NSArray *)types
                  URL:(NSString *)url
             ImageUrl:(NSString *)imgURL
             Favorite:(FavoriteModel *)favoriteModel
{
    UIImage *image = nil;
    switch (imgType) {
            //无拼接需求的图片
        case ShareIMGNone:
        {
            image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]]];
        }
            break;
            //有拼接需求的图片
        case ShareIMGTrue:
        {
            //在此处截取imgURL再进行拼接
        }
            break;
            
        default:
        {
            image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]]];
        }
            break;
    }
//    switch (type) {
//        case ShareToSina:
//        {
//            WBAuthorizeRequest *autherRequest = [WBAuthorizeRequest request];
//            autherRequest.redirectURI = @"m.aoyou.com";
//            autherRequest.scope = @"all";
//            WBMessageObject *message = [WBMessageObject message];
//            NSString *txt = [NSString stringWithFormat:kSinaShareContent,shareTitle,url];
//            message.text = txt;
//            NSData *imageLength = [[NSData alloc]init];
//            imageLength = UIImagePNGRepresentation(image);
//            NSLog(@"图片大小B数为----------%lu",(unsigned long)imageLength.length);
//            int a = (int)imageLength.length / 1024 ;
//            NSLog(@"图片大小KB数为----------%d",a);
//            
//            if (imageLength.length != 0 || imageLength != nil)
//            {
//                WBImageObject *img = [WBImageObject object];
//                img.imageData = UIImagePNGRepresentation(image);
//                message.imageObject = img;
//            }
//            WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:autherRequest access_token:AppShare.wbtoken];
//            request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
//                             @"Other_Info_1": [NSNumber numberWithInt:123],
//                             @"Other_Info_2": @[@"obj1", @"obj2"],
//                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//            [WeiboSDK sendRequest:request];
//            
//        }
//            return;
//        case ShareToWeChat:
//        {
//            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
//            [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
//            [UMSocialData defaultData].extConfig.wechatSessionData.title = shareTitle;
//            types = @[UMShareToWechatSession];
//        }
//            break;
//        case ShareToWeChatFriends:
//        {
//            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
//            [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
//            [UMSocialData defaultData].extConfig.wechatTimelineData.title = shareTitle;
//            types = @[UMShareToWechatTimeline];
//            
//        }
//            break;
//        case ShareToLianjie:
//        {
//            //复制链接
//            NSString *pasterString = [NSString stringWithFormat:@"%@%@",shareTitle,url];
//            UIPasteboard *pastBoard = [UIPasteboard generalPasteboard];
//            pastBoard.string = pasterString;
//            
//        }
//            return;
//        case ShareToMessage:
//        {
//            [UMSocialData defaultData].extConfig.smsData.shareText = [NSString stringWithFormat:@"%@%@",shareTitle,url];
//            types = @[UMShareToSms];
//            image = nil;
//            
//        }
//            break;
//        case ShareToFavourite:
//        {
//            
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//    [[UMSocialDataService defaultDataService] postSNSWithTypes:types content:shareText image:image location:nil urlResource:nil presentedController:AppShare.navigationController completion:^(UMSocialResponseEntity *response) {
//        NSString *message = @"";
//        switch (response.responseCode) {
//                case UMSResponseCodeSuccess:
//                {
//                    message = @"分享成功";
//                }
//                    break;
//                
//                default:
//                {
//                    message = @"分享失败";
//                }
//                    break;
//        }
    
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];
//    }];
    
    
}







@end
