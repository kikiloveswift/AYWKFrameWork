//
//  TouchIDIdentifier.m
//  DownLoadDocument
//
//  Created by kong on 16/10/19.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "TouchIDIdentifier.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation TouchIDIdentifier

+ (void)identifyTouchID
{
    /*创建了一个LAContext实例，用于执行认证策略 */
    LAContext* context = [[LAContext alloc]init];
    NSError* errorMessage = nil;
    /*
     然后在该对象上调用canEvaluatePolicy方法执行某个指定的认证策略 canEvaluatePolicy方法返回的是Bool值，表示指定的认证策略是否允许执行。当方法返回false时，可以通过error对象来获取详细的失败原因。失败的情况可能是设备本身不支持，例如旧版本的iPhone与iPad；运行在模拟器上；或者用户未开启Touch ID功能等
     LAPolicy枚举目前只有一个枚举值.DeviceOwnerAuthenticationWithBiometrics，即使用指纹生物识别方式来认证设备机主。
     */
    BOOL isAvailable = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&errorMessage];
    
    if (isAvailable) {
        NSLog(@"TouchID 可用 ");
        
        //获取验证结果
        /*
         调用该方法将弹出系统调用Touch ID的对话框，其中的localizedReason参数用于在对话框中提示用户详细的理由和原因
         reply参数是一个Block，其中的Bool类型参数success表示指纹验证是否通过，当失败时error参数包含了具体的失败信息
         */
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"需要验证你的指纹来确认您的身份信息" reply:^(BOOL success, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
                    [alert show];
                    
                }else{
                    //点击取消按钮  code = -2
                    if(error.code == -2){
                        
                        return;
                    }
                    //点击输入密码按钮   code = -3
                    if (error.code == -3){
                        /*可以在此处做输入密码的操作*/
                        return;
                    }
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
                    [alert show];
                }
            });
        }];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无TouchID" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
}


@end
