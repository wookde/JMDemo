//
//  NSTimer+JMWeakTimer.h
//  JMDemo
//
//  Created by wookde on 2021/10/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (JMWeakTimer)

+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)interval
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id __nullable)userInfo
                                        repeats:(BOOL)repeats;

@end

NS_ASSUME_NONNULL_END
