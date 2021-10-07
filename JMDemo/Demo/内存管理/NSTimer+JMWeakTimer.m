//
//  NSTimer+JMWeakTimer.m
//  JMDemo
//
//  Created by liujiemin on 2021/10/7.
//

#import "NSTimer+JMWeakTimer.h"

@interface TimerWeakObject : NSObject
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer *timer;

- (void)fire:(NSTimer *)timer;
@end

@implementation TimerWeakObject

- (void)fire:(NSTimer *)timer
{
    if (self.target) {
        if ([self.target respondsToSelector:self.selector]) {
            [self.target performSelector:self.selector withObject:timer.userInfo];
        }
    }
    else{
        [self.timer invalidate];
    }
}

@end

@implementation NSTimer (JMWeakTimer)
// 在.h中暴露这个方法，提供外界使用
+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)interval
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)repeats
{
    TimerWeakObject *object = [[TimerWeakObject alloc] init];
    object.target = aTarget;
    object.selector = aSelector;
    object.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                    target:object
                                                  selector:@selector(fire:)
                                                  userInfo:userInfo
                                                   repeats:repeats];
    
    return object.timer;
}

@end
