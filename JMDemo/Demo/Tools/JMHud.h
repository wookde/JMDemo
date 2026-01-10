//
//  JMHud.h
//  JMChatBot
//
//  Created by liujiemin on 2023/4/30.
//

#import <SVProgressHUD/SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMHud : NSObject

+ (void)showLoad:(NSString *)message;

+ (void)showSuccess:(NSString * __nullable)status;

+ (void)showError:(NSString * __nullable)status;

+ (void)show;

+ (void)showMessageOnly:(NSString *__nullable)message;

/**
 * 消除现在显示的hud
 */
+ (void)hide;


@end

NS_ASSUME_NONNULL_END
