//
//  KLData.m
//  fengyanfengyu
//
//  Created by kong on 16/4/9.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "KLData.h"

@implementation KLData

+ (id)dicWithJsonString:(id)jsonString
{
    if (jsonString == nil || [jsonString isKindOfClass:[NSNull class]] )
    {
        return nil;
    }
    jsonString = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    id json = [NSJSONSerialization JSONObjectWithData:jsonString options:NSJSONReadingMutableContainers |NSJSONReadingMutableLeaves error:nil];
    
    return json;
}

+ (NSString *)_serializeMessage:(id)message pretty:(BOOL)pretty
{
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:message options:(NSJSONWritingOptions)(pretty ? NSJSONWritingPrettyPrinted : 0) error:nil] encoding:NSUTF8StringEncoding];
    
}

+ (NSDictionary *)dicWithCFString:(id)cfString
{
     cfString = [cfString dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:cfString options:NSJSONReadingMutableContainers |NSJSONReadingMutableLeaves error:nil];
    
    return json;
}

+(id)dicJSONWithLocalPathName:(NSString *)pathName
{
    NSString *pathFile = [[NSBundle mainBundle]pathForResource:pathName ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:pathFile];
    
    return [KLData dicWithJsonString:data];
    
}

+ (NSString *)stringEncodingWithString:(NSString *)string
{
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    
    NSString *str = [string stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    return str;
}

+ (NSString *)stringDecodingWithString:(NSString *)string
{
    NSString *str = [string stringByRemovingPercentEncoding];
    
    return str;
}

@end
