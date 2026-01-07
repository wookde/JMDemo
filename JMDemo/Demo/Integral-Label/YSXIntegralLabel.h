//
//  YSXIntegralLabel.h
//  YSXIntegralLabel
//
//  Created by 刘杰民 on 2020/12/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSXIntegralLabel : UIView

- (instancetype)initWithNumber:(NSString *)numberStr textColor:(UIColor *)textColor font:(UIFont *)font animated:(BOOL)animated;

- (void)changeToStr:(NSString *)targetStr animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
