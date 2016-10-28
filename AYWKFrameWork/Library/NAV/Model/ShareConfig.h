//
//  ShareConfig.h
//  Aoyou
//
//  Created by kong on 16/7/21.
//  Copyright © 2016年 test. All rights reserved.
//

#ifndef ShareConfig_h
#define ShareConfig_h

typedef NS_ENUM(NSInteger, WebShareType)
{
    //分享为空 默认为空
    ShareToNone = 0,
    
    //分享到微博
    ShareToSina = 1,
    
    //分享到微信
    ShareToWeChat = 2,
    
    //分享到朋友圈
    ShareToWeChatFriends = 3,
    
    //复制链接
    ShareToLianjie = 4,
    
    //短信分享
    ShareToMessage = 5,
    
    //收藏
    ShareToFavourite = 6
};

//分享图片拼图
typedef NS_ENUM(NSInteger, ShareIMGType)
{
    
    //分享图片不需要拼图
    ShareIMGNone = 0,
    
    //分享图片需要拼图
    ShareIMGTrue = 1
    
};

//...按钮点开 TableView下拉类型
typedef NS_ENUM(NSInteger, ActionTableType)
{
    //收藏
    ActionTableTypeFavourite = 1,
    
    //我的收藏
    ActionTableTypeMy_Favourite = 2,
    
    //分享
    ActionTableTypeShare = 3,
    
    //历史
    ActionTableTypeHistory = 4,
    
    //回首页
    ActionTableTypeHome = 5,
    
    //去搜索
    ActionTableTypeSearch = 6,
    
    //电话
    ActionTableTypeTel = 7
};

//TODO: SP30友盟统计 ---所属栏目的判断
typedef NS_ENUM(NSInteger, ColumeSearchType){

    //首页
    ColumeSearchTypeHome = 1,
    
    //目的地
    ColumeSearchTypeDestination = 2
    
};

//TODO: SP30友盟统计 ---所属频道的判断
typedef NS_ENUM(NSInteger, ChannelSearchType){
    
    //首页
    ChannelSearchTypeHome = 1,
    
    //出境游
    ChannelSearchTypeOUT = 2,
    
    //国内游
    ChannelSearchTypeIN = 3,
    
    //抢游惠
    ChannelSearchTypeQIANG = 4,
    
    //目的地频道页
    ChannelSearchTypeDes = 5
    
};

#import "SerealizeData.h"

#import "ShareSet.h"

#define kColor(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//融合框架 定义功能按钮
#import "AYFunctionButton.h"

#import "UIViewExt.h"



#endif /* ShareConfig_h */
