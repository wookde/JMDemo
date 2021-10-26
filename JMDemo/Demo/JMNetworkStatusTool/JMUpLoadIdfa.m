//
//  JMUpLoadIdfa.m
//  JMDemo
//
//  Created by liujiemin on 2021/10/25.
//

#import "JMUpLoadIdfa.h"
#import "JMNetworkStatusTool.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>

@implementation JMUpLoadIdfa

+ (void)upload {
    
    if (@available(iOS 14, *)) {
        // iOS14及以上版本需要先请求权限
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            // 获取到权限后，依然使用老方法获取idfa
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                [JMUpLoadIdfa uploadAction:idfa];
            } else {
                NSLog(@"请在设置-隐私-跟踪中允许App请求跟踪");
            }
        }];
    } else {
        // iOS14以下版本依然使用老方法
        // 判断在设置-隐私里用户是否打开了广告跟踪
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
            [JMUpLoadIdfa uploadAction:idfa];
        } else {
            NSLog(@"请在设置-隐私-广告中打开广告跟踪功能");
        }
    }
}

+ (void)uploadAction:(NSString *)idfa {
    NSLog(@"idfa是:%@",idfa);
    // 在此处可以上传idfa到服务器
}

@end
