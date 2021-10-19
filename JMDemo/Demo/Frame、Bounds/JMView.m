//
//  JMView.m
//  JMDemo
//
//  Created by liujiemin on 2021/10/18.
//

#import "JMView.h"

@implementation JMView

/*
  隐式动画实现原理
  1.图层会首先检测它是否有委托，并且是否实现CALayerDelegate协议指定的-actionForLayer:forKey方法；如果有，就直接调用并返回结果。
  2.如果没有委托或者委托没有实现-actionForLayer:forKey方法，图层将会检查包含属性名称对应行为映射的actions字典
  3.如果actions字典没有包含对应的属性，图层接着在它的style字典里搜索属性名.
  4.最后，如果在style也找不到对应的行为，那么图层将会直接调用定义了每个属性的标准行为的+defaultActionForKey:方法
 
  UIView默认返回nil,关闭了隐式动画
 */
- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
    CATransition *theAnimation = nil;
    if ([event isEqualToString:@"backgroundColor"]){
        theAnimation = [[CATransition alloc] init];
        theAnimation.duration = 1.0;
        theAnimation.type = kCATransitionPush;
        theAnimation.subtype = kCATransitionFromLeft;
    }
    return theAnimation;
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView * view = [super hitTest:point withEvent:event];
//    if (view == nil) {
//        for (UIView * subView in self.subviews) {
//            // 将坐标系转化为自己的坐标系
//            CGPoint tp = [subView convertPoint:point fromView:self];
//            CGRect rect = subView.bounds;
//            if ([subView pointInside:tp withEvent:event]) {
//                view = subView;
//            }
//        }
//    }
//    return view;
//}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return YES;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = [super hitTest:point withEvent:event];
    for (UIView *subView in self.subviews) {
        CGPoint tp = [subView convertPoint:point fromView:self];
        if ([subView pointInside:tp withEvent:event]) {
            view = subView;
        }
//        if (CGRectContainsPoint(subView.bounds, tp)) {
//            view = subView;
//        }
    }
    return view;
}

@end
