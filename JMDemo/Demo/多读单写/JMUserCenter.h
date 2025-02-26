//
//  JMUserCenter.h
//  JMDemo
//
//  Created by liujiemin on 2025/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMUserCenter : NSObject

// 获取数据
- (id)objectForKey:(NSString *)key;

// 设置数据
- (void)setObject:(id)obj forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
