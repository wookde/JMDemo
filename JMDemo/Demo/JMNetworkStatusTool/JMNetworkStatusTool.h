//
//  JMNetworkStatusTool.h
//  JMDemo
//
//  Created by liujiemin on 2021/10/25.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMNetworkStatusTool : NSObject

+ (instancetype)defaultManager;

+ (BOOL)isReached;

- (void)startNotifier:(void (^)(NetworkStatus status))reached;

@end

NS_ASSUME_NONNULL_END
