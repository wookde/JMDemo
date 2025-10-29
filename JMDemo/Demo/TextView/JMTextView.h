//
//  JMTextView.h
//  JMDemo
//
//  Created by liujiemin on 2025/3/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMTextView : UITextView

@property (nonatomic, weak) UIResponder *overrideNextResponder; //覆盖下一个响应者

@end

NS_ASSUME_NONNULL_END
