//
//  FOSKaraOKLabel.m
//  AuthDemo
//
//  Created by Wei Niu on 8/2/16.
//  Copyright (c) 2016 Fosafer Co.,Ltd. All rights reserved.
//

#import "FOSKaraOKLabel.h"

@interface FOSKaraOKLabel () {
    UILabel *_highlightedLabel;
}

@end

@implementation FOSKaraOKLabel

- (void)setText:(NSString *)text {
    [super setText:[self insertSpace:text]];
    [super sizeToFit];
    
    {
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        CGRect maskRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        CGPathRef path = CGPathCreateWithRect(maskRect, NULL);
        maskLayer.path = path;
        CGPathRelease(path);
        self.layer.mask = maskLayer;
    }
    
    {
        if (!_highlightedLabel) {
            _highlightedLabel = [[UILabel alloc] initWithFrame:self.frame];
        }
        _highlightedLabel.font = self.font;
        _highlightedLabel.text = self.text;
        _highlightedLabel.textColor = [UIColor colorWithRed:81/255.0 green:109/255.0 blue:216/255.0 alpha:255/255.0];
        [_highlightedLabel sizeToFit];

        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        CGRect maskRect = CGRectMake(0, 0, 0, self.frame.size.height);
        CGPathRef path = CGPathCreateWithRect(maskRect, NULL);
        maskLayer.path = path;
        CGPathRelease(path);
        _highlightedLabel.layer.mask = maskLayer;
    
        [self.superview addSubview:_highlightedLabel];
//        [_highlightedLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(self);
//        }];
        
    }
}

- (NSString *)insertSpace:(NSString *)string {
    if ([string length] == 8) {
        return [NSString stringWithFormat:@"%@ %@", [string substringToIndex:4], [string substringFromIndex:4]];
    } else {
        return string;
    }
}

#define ANIMATION_DURATION 3.0
#define ANIMATION_DELAY 0.0

- (void)startAnimating {
    {
        CAShapeLayer *maskLayer = (CAShapeLayer *)_highlightedLabel.layer.mask;
        CGPathRef old_path = maskLayer.path;
        CGRect maskRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

        CGPathRef new_path = CGPathCreateWithRect(maskRect, NULL);
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        pathAnimation.fromValue = (__bridge id)(old_path);
        pathAnimation.toValue = (__bridge id)(new_path);
        pathAnimation.duration = ANIMATION_DURATION;
        pathAnimation.beginTime = CACurrentMediaTime() + ANIMATION_DELAY;
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.removedOnCompletion = NO;
        [maskLayer addAnimation:pathAnimation forKey:@"path"];
        CGPathRelease(new_path);
    }
    {
        CAShapeLayer *maskLayer = (CAShapeLayer *)self.layer.mask;
        CGPathRef old_path = maskLayer.path;
        CGRect maskRect = CGRectMake(self.frame.size.width, 0, 0, self.frame.size.height);
        CGPathRef new_path = CGPathCreateWithRect(maskRect, NULL);

        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        pathAnimation.fromValue = (__bridge id)(old_path);
        pathAnimation.toValue = (__bridge id)(new_path);
        pathAnimation.duration = ANIMATION_DURATION;
        pathAnimation.beginTime = CACurrentMediaTime() + ANIMATION_DELAY;
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.removedOnCompletion = NO;
        [maskLayer addAnimation:pathAnimation forKey:@"path"];
        CGPathRelease(new_path);
    }
}

- (void)fill {
    {
        CAShapeLayer *maskLayer = (CAShapeLayer *)self.layer.mask;
        [maskLayer removeAllAnimations];
        CGRect maskRect = CGRectMake(0, 0, 0, self.frame.size.height);
        CGPathRef path = CGPathCreateWithRect(maskRect, NULL);
        maskLayer.path = path;
        CGPathRelease(path);
    }
    {
        CAShapeLayer *maskLayer = (CAShapeLayer *)_highlightedLabel.layer.mask;
        [maskLayer removeAllAnimations];
        CGRect maskRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        CGPathRef path = CGPathCreateWithRect(maskRect, NULL);
        maskLayer.path = path;
        CGPathRelease(path);
    }
}

- (void)clear {
    {
        CAShapeLayer *maskLayer = (CAShapeLayer *)self.layer.mask;
        [maskLayer removeAllAnimations];
        CGRect maskRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        CGPathRef path = CGPathCreateWithRect(maskRect, NULL);
        maskLayer.path = path;
        CGPathRelease(path);
    }
    {
        CAShapeLayer *maskLayer = (CAShapeLayer *)_highlightedLabel.layer.mask;
        [maskLayer removeAllAnimations];
        CGRect maskRect = CGRectMake(0, 0, 0, self.frame.size.height);
        CGPathRef path = CGPathCreateWithRect(maskRect, NULL);
        maskLayer.path = path;
        CGPathRelease(path);
    }
}

@end
