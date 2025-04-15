//
//  JMTextView.m
//  JMDemo
//
//  Created by liujiemin on 2025/3/14.
//

#import "JMTextView.h"

@implementation JMTextView

// 确保 displayTextView 能够成为第一响应者
- (BOOL)canBecomeFirstResponder {
    return YES;
}

// 确保我们能响应选择和全选的动作
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(select:) || action == @selector(selectAll:)) {
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}

@end
