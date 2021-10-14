//
//  UIView+KGAnimation.m
//  JMDemo
//
//  Created by wookde on 2021/7/1.
//

#import "UIView+KGAnimation.h"
#import <pop/POP.h>

@interface UIView (KGAnimation)

@end

@implementation UIView (KGAnimation)

// 移动
- (void)moveTo:(CGPoint)point duration:(NSTimeInterval)duration forKey:(NSString *)key completion:(completionBlock _Nullable)completion {
    [self.superview layoutIfNeeded];
    // 透明度
    POPBasicAnimation *opacityAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    opacityAnim.additive = YES;
    opacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    opacityAnim.duration = 0.25;
    opacityAnim.toValue = @1.0;
    [self pop_addAnimation:opacityAnim forKey:@"opacityAnim"];
    // 惯性移动
    POPSpringAnimation *positionAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    positionAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (completion) {
            completion(finished);
        }
    };
    positionAnim.springBounciness = 4;
    positionAnim.springSpeed = 10;
    positionAnim.fromValue = @(CGPointMake(self.center.x, self.center.y));
    positionAnim.toValue = @(CGPointMake(point.x + self.frame.size.width / 2.0, point.y + self.frame.size.height / 2.0));
    [self pop_addAnimation:positionAnim forKey:@"positionAnim"];
}

// 变换
- (void)changeScale:(CGFloat)scale duration:(NSTimeInterval)duration forKey:(NSString *)key completion:(completionBlock _Nullable)completion {
    [self.superview layoutIfNeeded];
    // 改变大小
    POPBasicAnimation *scaleAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleAnim.removedOnCompletion = NO;
    scaleAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (completion) {
            completion(finished);
        }
    };
    scaleAnim.duration = duration;
    scaleAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    scaleAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(scale, scale)];
    [self pop_addAnimation:scaleAnim forKey:key];
}

- (void)springChangeScale:(CGFloat)scale forKey:(NSString *)key completion:(completionBlock _Nullable)completion {
    [self.superview layoutIfNeeded];
    // 改变大小
    POPSpringAnimation *springScaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    springScaleAnim.removedOnCompletion = NO;
    springScaleAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (completion) {
            completion(finished);
        }
    };
    // [0-20] 弹力 越大则震动幅度越大 默认值：4
    springScaleAnim.springBounciness = 12.0;
    // [0-20] 速度 越大则动画结束越快 默认值：12.
    springScaleAnim.springSpeed = 15.0;
    springScaleAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    springScaleAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(scale, scale)];
    [self pop_addAnimation:springScaleAnim forKey:key];
}

- (void)changeSizeWithSize:(CGSize)newSize duration:(NSTimeInterval)duration forKey:(NSString *)key completion:(completionBlock _Nullable)completion {
    [self.superview layoutIfNeeded];
    
    POPBasicAnimation *sizeAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewSize];
    sizeAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (completion) {
            completion(finished);
        }
    };
    sizeAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    sizeAnim.duration = duration;
    sizeAnim.toValue = [NSValue valueWithCGSize:newSize];
    [self pop_addAnimation:sizeAnim forKey:key];
}

// 旋转
- (void)rotation:(CGFloat)degree duration:(NSTimeInterval)duration forKey:(NSString *)key completion:(completionBlock _Nullable)completion {
    POPBasicAnimation *rotationAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotationAnim.additive = YES;
    rotationAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (completion) {
            completion(finished);
        }
    };
    rotationAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnim.duration = duration;
    rotationAnim.fromValue = @0;
    rotationAnim.toValue = @(degree / 180.0 * M_PI);
    [self.layer pop_addAnimation:rotationAnim forKey:key];
}

// 旋转
// POP的kPOPLayerRotationY存在Bug，大于90度就会出错
- (void)rotateWithType:(RotationType)type degree:(CGFloat)degree duration:(NSTimeInterval)duration forKey:(NSString *)key completion:(completionBlock _Nullable)completion {
    NSString *typeStr = kPOPLayerRotation;
    if (type == KGPOPLayerRotation) {
        typeStr = kPOPLayerRotation;
    } else if (type == KGPOPLayerRotationX) {
        typeStr = kPOPLayerRotationX;
    } else if (type == KGPOPLayerRotationY) {
        typeStr = kPOPLayerRotationY;
    }
    
    POPBasicAnimation *rotationAnim = [POPBasicAnimation animationWithPropertyNamed:typeStr];
    rotationAnim.removedOnCompletion = NO;
    rotationAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (completion) {
            completion(finished);
        }
    };
    rotationAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnim.duration = duration;
    rotationAnim.fromValue = @0;
    rotationAnim.toValue = @(degree / 180.0 * M_PI);
    [self.layer pop_addAnimation:rotationAnim forKey:key];
}

- (void)springRotateWithType:(RotationType)type degree:(CGFloat)degree forKey:(NSString *)key completion:(completionBlock _Nullable)completion {
    NSString *typeStr = kPOPLayerRotation;
    if (type == KGPOPLayerRotation) {
        typeStr = kPOPLayerRotation;
    } else if (type == KGPOPLayerRotationX) {
        typeStr = kPOPLayerRotationX;
    } else if (type == KGPOPLayerRotationY) {
        typeStr = kPOPLayerRotationY;
    }
    
    POPSpringAnimation *rotationAnim = [POPSpringAnimation animationWithPropertyNamed:typeStr];
    // [0-20] 弹力 越大则震动幅度越大 默认值：4
    rotationAnim.springBounciness = 18.0;
    // [0-20] 速度 越大则动画结束越快 默认值：12.
    rotationAnim.springSpeed = 12.0;
    rotationAnim.additive = YES;
    rotationAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (completion) {
            completion(finished);
        }
    };
    
    rotationAnim.fromValue = @0;
    rotationAnim.toValue = @(degree / 180.0 * M_PI);
    [self.layer pop_addAnimation:rotationAnim forKey:key];
}

// 抖动
- (void)shake {
    POPBasicAnimation *shakeAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    shakeAnim.additive = YES;
    shakeAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        [self rotation:0 duration:0.025 forKey:@"shakeFinished" completion:^(BOOL finish) {
                    
        }];
    };
    shakeAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    shakeAnim.duration = 0.1;
    shakeAnim.repeatCount = 2;
    shakeAnim.fromValue = @(-10 / 180.0 * M_PI);
    shakeAnim.toValue = @(10 / 180.0 * M_PI);
    [self.layer pop_addAnimation:shakeAnim forKey:@"shakeAnim"];
    
//    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    shake.fromValue = @(-10 / 180.0 * M_PI);
//    shake.toValue = @(10 / 180.0 * M_PI);
//    shake.duration = 0.1;//执行时间
//    shake.autoreverses = YES;//是否重复
//    shake.repeatCount = 2;//次数
//    [self.layer addAnimation:shake forKey:@"shakeAnimation"];
}

@end
