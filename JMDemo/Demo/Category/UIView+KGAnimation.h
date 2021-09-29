//
//  UIView+KGAnimation.h
//  JMDemo
//
//  Created by liujiemin on 2021/7/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 动画类型
typedef NS_ENUM(NSInteger, RotationType) {
    KGPOPLayerRotation = 0,
    KGPOPLayerRotationX,
    KGPOPLayerRotationY,
};

typedef void (^completionBlock)(BOOL finish);

@interface UIView (KGAnimation)

/// 控件移动
/// @param point 终点位置，控件的左上角
/// @param duration 动画时长
/// @param key 动画名称
/// @param completion 完成的回调
- (void)moveTo:(CGPoint)point duration:(NSTimeInterval)duration forKey:(NSString *)key completion:(completionBlock __nullable)completion;

// 改变大小
- (void)changeScale:(CGFloat)scale duration:(NSTimeInterval)duration forKey:(NSString *)key completion:(completionBlock __nullable)completion;

// 弹性的改变大小
- (void)springChangeScale:(CGFloat)scale forKey:(NSString *)key completion:(completionBlock _Nullable)completion;

// 改变大小，指定长和宽
- (void)changeSizeWithSize:(CGSize)newSize duration:(NSTimeInterval)duration forKey:(NSString *)key completion:(completionBlock __nullable)completion;

// 旋转
- (void)rotation:(CGFloat)degree duration:(NSTimeInterval)duration forKey:(NSString *)key completion:(completionBlock __nullable)completion;

// 可以选择方向的旋转
- (void)rotateWithType:(RotationType)type degree:(CGFloat)degree duration:(NSTimeInterval)duration forKey:(NSString *)key completion:(completionBlock __nullable)completion;

// 含有阻尼的旋转
- (void)springRotateWithType:(RotationType)type degree:(CGFloat)degree forKey:(NSString *)key completion:(completionBlock __nullable)completion;

// 抖动
- (void)shake;
@end

NS_ASSUME_NONNULL_END
