//
//  JMDelegateObject.m
//  JMDemo
//
//  Created by wookde on 2021/10/8.
//

#import "JMDelegateObject.h"

@interface JMDelegateObject()

@property (nonatomic, strong) NSMutableArray *delegates;

@end

@implementation JMDelegateObject

- (void)addDeleagte:(id<JMDeleagte>)delegate {
    if ([self.delegates containsObject:delegate]) {
        return;
    }
    [self.delegates addObject:delegate];
}

- (void)removeDeleagte:(id<JMDeleagte>)delegate {
    if ([self.delegates containsObject:delegate]) {
        [self.delegates removeObject:delegate];
    }
}

- (void)action {
    for (id<JMDeleagte> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(doSomthing)]) {
            [delegate doSomthing];
        }
    }
}

- (NSMutableArray *)delegates {
    if (!_delegates) {
        _delegates = [[NSMutableArray alloc] init];
    }
    return _delegates;
}

@end
