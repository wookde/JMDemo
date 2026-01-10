//
//  JMHud.m
//  JMChatBot
//
//  Created by liujiemin on 2023/4/30.
//

#import "JMHud.h"

@implementation JMHud

+ (void)showLoad:(NSString *)message {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    [SVProgressHUD setHapticsEnabled:NO];
    
    [SVProgressHUD showWithStatus:message];
}

+ (void)showSuccess:(NSString * __nullable)status {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    [SVProgressHUD showSuccessWithStatus:status];
    
    [SVProgressHUD dismissWithDelay:0.8];
}

+ (void)showError:(NSString * __nullable)status {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMaximumDismissTimeInterval:2.5];
    
    [SVProgressHUD showErrorWithStatus:status];
}

+ (void)show {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD show];
}

+ (void)showMessageOnly:(NSString *)message {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:message];
}

+ (void)hide {
    [SVProgressHUD dismiss];
}

@end
