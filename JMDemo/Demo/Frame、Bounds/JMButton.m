//
//  JMButton.m
//  JMDemo
//
//  Created by liujiemin on 2025/3/12.
//

#import "JMButton.h"

@implementation JMButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGFloat x1 = point.x;
    CGFloat y1 = point.y;
    
    CGFloat x2 = self.frame.size.width / 2;
    CGFloat y2 = self.frame.size.height / 2;
    
    double dis = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
    
    if (dis <= self.frame.size.width / 2) {
        return YES;
    } else {
        return NO;
    }
    
}

@end
