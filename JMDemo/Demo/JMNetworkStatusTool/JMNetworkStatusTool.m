//
//  JMNetworkStatusTool.m
//  JMDemo
//
//  Created by liujiemin on 2021/10/25.
//

#import "JMNetworkStatusTool.h"



@interface JMNetworkStatusTool ()

@property (nonatomic, strong) Reachability *curReach;

@property (nonatomic, copy) void (^reachBlock)(NetworkStatus status);

@end

@implementation JMNetworkStatusTool

+ (instancetype)defaultManager {
    static JMNetworkStatusTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JMNetworkStatusTool alloc] init];
    });
    return instance;
}

+ (BOOL)isReached {
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (status == ReachableViaWWAN || status == ReachableViaWiFi) {
        return YES;
    } else {
        return NO;
    }
}

- (void)startNotifier:(void (^)(NetworkStatus status))reached {
    self.curReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [self.curReach currentReachabilityStatus];
    if (status == ReachableViaWWAN || status == ReachableViaWiFi) {
        reached(status);
        return;
    }
    
    self.reachBlock = reached;
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    [self.curReach startNotifier];
}

//监听到网络状态改变
- (void)reachabilityChanged:(NSNotification *)notification
{
    Reachability *curReach = [notification object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

//处理连接改变后的情况
- (void)updateInterfaceWithReachability: (Reachability*)curReach
{
    //对连接改变做出响应的处理动作。
    NetworkStatus status = [curReach currentReachabilityStatus];
    if (status == ReachableViaWWAN || status == ReachableViaWiFi) {
        self.reachBlock(status);
        return;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
