//
//  JMItemView.h
//  JMDemo
//
//  Created by liujiemin on 2025/10/26.
//

#import <UIKit/UIKit.h>

@class JMItemViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface JMItemView : UIView

- (void)bindViewModel:(JMItemViewModel *)viewModel;
- (void)unbindViewModel; // 可选，用于主动解除绑定

@end

NS_ASSUME_NONNULL_END
