//
//  JMQrCodeViewController.h
//  RedcoreMobile
//
//  Created by wookde on 2018/2/27.
//

#import <UIKit/UIKit.h>

typedef void(^QrCodeScanResult)(NSString *);

@interface JMQrCodeViewController : UIViewController

/// 扫码成功的回调
@property (nonatomic, copy) QrCodeScanResult resultBlock;

@end
