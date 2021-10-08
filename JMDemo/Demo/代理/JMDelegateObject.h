//
//  JMDelegateObject.h
//  JMDemo
//
//  Created by liujiemin on 2021/10/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JMDeleagte <NSObject>

- (void)doSomthing;

@end

@interface JMDelegateObject : NSObject

- (void)addDeleagte:(id<JMDeleagte>)delegate;

- (void)removeDeleagte:(id<JMDeleagte>)delegate;

- (void)action;


@end

NS_ASSUME_NONNULL_END
