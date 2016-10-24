//
//  AYHybridView.h
//  AYWKFrameWork
//
//  Created by kong on 16/10/24.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AYHybridBridge.h"

@interface AYHybridView : UIView<JSToOCDelegate>

- (instancetype)initWithFrame:(CGRect)frame AndRequst:(NSString *)requestURL;

@property (nonatomic, readonly) id useWebView;


@end
