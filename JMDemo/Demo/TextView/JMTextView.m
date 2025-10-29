//
//  JMTextView.m
//  JMDemo
//
//  Created by liujiemin on 2025/3/14.
//

#import "JMTextView.h"

@implementation JMTextView

- (UIResponder *)nextResponder {
    if (_overrideNextResponder == nil) {
        return [super nextResponder];
    } else {
        return _overrideNextResponder;
    }
}

// 确保 displayTextView 能够成为第一响应者
- (BOOL)canBecomeFirstResponder {
    return YES;
}

// 确保我们能响应选择和全选的动作
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (_overrideNextResponder != nil) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

@end
