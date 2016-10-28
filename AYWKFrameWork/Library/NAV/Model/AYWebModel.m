//
//  AYWebModel.m
//  Aoyou
//
//  Created by kong on 16/7/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import "AYWebModel.h"

@implementation AYWebModel

- (id)initContentWithDic:(NSDictionary *)jsonDic
{
    self = [super init];
    
    if (self != nil){
        
        [self setAttributes:jsonDic];
    }
    
    return self;
}

- (void)setAttributes:(NSDictionary *)jsonDic
{
    
    NSDictionary *mapDic = [self attributeMapDictionary:jsonDic];
    
    for (NSString *jsonKey in mapDic) {
        
        NSString *modelAttr = [mapDic objectForKey:jsonKey];
        
        SEL seletor = [self stringToSel:modelAttr];
        
        if ([self respondsToSelector:seletor])
        {
            
            id value = [jsonDic objectForKey:jsonKey];
            
            if ([value isKindOfClass:[NSNull class]])
            {
                value = @"";
            }
            
            [self performSelector:seletor withObject:value];
        }
    }
}


- (SEL)stringToSel:(NSString *)attName
{
    NSString *first = [[attName substringToIndex:1] uppercaseString];
    
    NSString *end = [attName substringFromIndex:1];
    
    NSString *setMethod = [NSString stringWithFormat:@"set%@%@:",first,end];
    
    return NSSelectorFromString(setMethod);
}


- (NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic
{
    
    NSMutableDictionary *mapDic = [NSMutableDictionary dictionary];
    
    for (id key in jsonDic)
    {
        [mapDic setObject:key forKey:key];
    }
    
    return mapDic;
}


@end
