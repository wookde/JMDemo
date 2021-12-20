//
//  JMQrCodeViewController.m
//  RedcoreMobile
//
//  Created by ZhangChao on 2018/2/27.
//  Copyright © 2018年 yunshipei. All rights reserved.
//

#import "JMQrCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
//#import "RMAuthLoginViewController.h"
//#import "RMModelManager.h"

#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define k_percent_of_screen_height(height) height / 667.f * KGScreenH

#define k_percent_of_screen_width(width) width / 375.0 * KGScreenW

@interface JMQrCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

/// 拍摄会话
@property (nonatomic, strong) AVCaptureSession *captureSession;

/// 输入设备
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;

/// 输出数据
@property (nonatomic, strong) AVCaptureMetadataOutput *dataOutPut;

/// 预览视图
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

/// 扫描框
@property (nonatomic, weak) UIImageView *scanImageView;

/// 扫描线
@property (nonatomic, weak) UIImageView *scanLine;

/// 标题
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation JMQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];

    [self scanQrcode];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![self.captureSession isRunning])
    {
        [self.captureSession startRunning];
    }
}

- (void)setUpViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 扫码的框
    UIImageView *scanImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_scan_frame"]];
    [self.view addSubview:scanImageView];
    self.scanImageView = scanImageView;
    
    [scanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(KGScreenH * 0.24);
        make.height.width.equalTo(@(255.0 / 375.0 * KGScreenW));
    }];
    
    // 扫码的条
    UIImageView *scanLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_scan_line"]];
    [self.view addSubview:scanLine];
    scanLine.hidden = YES;
    self.scanLine = scanLine;
    
    [scanLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(scanImageView);
    }];
    
    // 四周的蒙版
    UIView *maskViewLeft = [[UIView alloc] init];
    maskViewLeft.backgroundColor = RGBA(0, 0, 0, 0.4);
    [self.view addSubview:maskViewLeft];
    
    [maskViewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.right.equalTo(scanImageView.mas_left).offset(4);
    }];
    
    UIView *maskViewRight = [[UIView alloc] init];
    maskViewRight.backgroundColor = RGBA(0, 0, 0, 0.4);
    [self.view addSubview:maskViewRight];
    
    [maskViewRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scanImageView.mas_right).offset(-4);
        make.top.right.bottom.equalTo(self.view);
    }];
    
    UIView *maskViewTop = [[UIView alloc] init];
    maskViewTop.backgroundColor = RGBA(0, 0, 0, 0.4);
    [self.view addSubview:maskViewTop];
    
    [maskViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(maskViewLeft.mas_right);
        make.bottom.equalTo(scanImageView.mas_top).offset(4);
        make.right.equalTo(maskViewRight.mas_left);
    }];
    
    UIView *maskViewBottom = [[UIView alloc] init];
    maskViewBottom.backgroundColor = RGBA(0, 0, 0, 0.4);
    [self.view addSubview:maskViewBottom];
    
    [maskViewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scanImageView.mas_bottom).offset(-4);
        make.left.equalTo(maskViewLeft.mas_right);
        make.right.equalTo(maskViewRight.mas_left);
        make.bottom.equalTo(self.view);
    }];
    
    // 返回按钮
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"app_scan_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToHome) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(32);
        make.left.equalTo(self.view).offset(16);
        make.width.height.equalTo(@32);
    }];
    
    // title
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"扫一扫";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(35);
        make.centerX.equalTo(self.view);
    }];
    
    // 提示文字
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"对准二维码/条形码到框内即可扫描";
    tipsLabel.font = [UIFont systemFontOfSize:15];
    tipsLabel.textColor = [UIColor whiteColor];
    [tipsLabel sizeToFit];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipsLabel];
    
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scanImageView.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];
    
    [self.view bringSubviewToFront:scanImageView];
}

- (void)scanQrcode
{
    if (![self.captureSession canAddInput:self.deviceInput])
    {
        NSLog(@"无法添加输入设备，请检查该app是否有相机权限");
//        [RMHud showMessageOnly:@"无法添加输入设备，请检查该app是否有相机权限"];
        
        return;
    }
    
    if (![self.captureSession canAddOutput:self.dataOutPut])
    {
        NSLog(@"无法添加输出设备，请检查该app是否有相机权限");
//        [RMHud showMessageOnly:@"无法添加输出设备，请检查该app是否有相机权限"];
        
        return;
    }
    
    [self.captureSession addInput:self.deviceInput];
    self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    
    // 耗时极高,可能是主线程卡死,异步一下就可以了
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.captureSession addOutput:self.dataOutPut];
        
        [self.captureSession startRunning];
        
        [self.dataOutPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        NSMutableArray *array = [NSMutableArray array];
        
        if ([self.dataOutPut.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode])
        {
            [array addObject:AVMetadataObjectTypeQRCode];
        }
        if ([self.dataOutPut.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code])
        {
            [array addObject:AVMetadataObjectTypeEAN13Code];
        }
        if ([self.dataOutPut.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN8Code])
        {
            [array addObject:AVMetadataObjectTypeEAN8Code];
        }
        if ([self.dataOutPut.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code])
        {
            [array addObject:AVMetadataObjectTypeCode128Code];
        }
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        
        self.dataOutPut.metadataObjectTypes = array.copy;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view.layer insertSublayer:self.previewLayer atIndex:0];
            
            // 设置扫码区域
//            CGRect rectFrame = self.view.frame;
//            if (!CGRectEqualToRect(rectFrame, CGRectZero)) {
//                CGFloat y = rectFrame.origin.y / self.view.bounds.size.height;
//                CGFloat x = (self.view.bounds.size.width - rectFrame.origin.x - rectFrame.size.width) / self.view.bounds.size.width;
//                CGFloat h = rectFrame.size.height / self.view.bounds.size.height;
//                CGFloat w = rectFrame.size.width / self.view.bounds.size.width;
//                self.dataOutPut.rectOfInterest = CGRectMake(y, x, h, w);
//            }
            
            [self setUpAnimation];
        });
        
    });
}

- (void)setUpAnimation
{
    self.scanLine.hidden = NO;
    
    CABasicAnimation *anim = [[CABasicAnimation alloc] init];
    anim.keyPath = @"position.y";
    anim.fromValue = @(KGScreenH * 0.24 + 4);
    anim.toValue = @(KGScreenH * 0.24 + k_percent_of_screen_width(255) - 4);
    anim.duration = 2;
    anim.repeatCount = INTMAX_MAX;
    anim.removedOnCompletion = NO;
    
    [self.scanLine.layer addAnimation:anim forKey:nil];
}

- (void)backToHome
{
    if (![self.navigationController popViewControllerAnimated:YES])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)dealWithScanResult:(NSString *)result
{
    if ([result containsString:@"push/qrlogin"] && [result containsString:@"randomId="] && [result containsString:@"deviceId="])
    {
//        [self postRandomIdWithResult:result];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
            if (self.resultBlock)
            {
                self.resultBlock(result);
            }
        }];
    }
    
}

//- (void)postRandomIdWithResult:(NSString *)result
//{
//    NSDictionary *urlParamsDict = [result rm_dictFromURLParamsOnly];
//
//    NSURL *resultUrl = [NSURL URLWithString:result];
//
//    NSString *serverAddress = [[NSUserDefaults standardUserDefaults] objectForKey:k_company_server];
//
//    NSURL *serverUrl = [NSURL URLWithString:serverAddress];
//
//    if (resultUrl == nil || serverAddress == nil || ![resultUrl.host isEqualToString:serverUrl.host])
//    {
//        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"当前移动端服务器地址与扫描结果不匹配 " message:nil preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction *ensureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }];
//
//        [alertVC addAction:ensureAction];
//
//        [self presentViewController:alertVC animated:YES completion:nil];
//
//        return;
//    }
//
//    if ([urlParamsDict.allKeys containsObject:@"randomId"] &&
//        [urlParamsDict.allKeys containsObject:@"deviceId"])
//    {
//        NSString *randomId = urlParamsDict[@"randomId"];
//
//        NSString *deviceId = urlParamsDict[@"deviceId"];
//
//        NSString *companyId = [RMModelManager manager].loginModel.company._id;
//
//        NSDictionary *dict = @{
//                               @"randomId" : randomId,
//                               @"deviceId" : deviceId,
//                               @"companyId": companyId ? companyId : @""
//                               };
//
//        [RMHud showHudWithMessage:@""];
//
//        [RMNetworkApiManager qrcodeRequestLoginWithParams:dict success:^(NSURLSessionDataTask *task, id responseObject) {
//
//            if ([responseObject[@"errCode"] isEqualToString:@"0"])
//            {
//                [RMHud hide];
//
//                RMAuthLoginViewController *authVC = [[RMAuthLoginViewController alloc] init];
//
//                authVC.randomId = randomId;
//
//                authVC.deviceId = responseObject[@"data"][@"deviceId"];
//
//                authVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//
//                [self presentViewController:authVC animated:YES completion:nil];
//
//                authVC.successBlock = ^{
//
//                    [self backToHome];
//                };
//            }
//            else
//            {
//                [RMHud showMessageOnly:responseObject[@"message"]];
//
//                [self backToHome];
//            }
//
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//            [RMHud showMessageOnly:error.localizedDescription];
//
//            [self backToHome];
//        }];
//    }
//}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects != nil && metadataObjects.count > 0)
    {
        AVMetadataMachineReadableCodeObject *codeObject = metadataObjects[0];
        
        if ([codeObject isKindOfClass:[AVMetadataMachineReadableCodeObject class]])
        {
            NSLog(@"%@",codeObject.stringValue);
            // 处理扫码结果
            [self dealWithScanResult:codeObject.stringValue];
            
            [self.captureSession stopRunning];
        }
    }
}

#pragma mark - getter
- (AVCaptureSession *)captureSession
{
    if (!_captureSession)
    {
        _captureSession = [[AVCaptureSession alloc] init];
    }
    
    return _captureSession;
}

- (AVCaptureDeviceInput *)deviceInput
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSString * mediaType = AVMediaTypeVideo;
    
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if (authorizationStatus == AVAuthorizationStatusRestricted ||
        authorizationStatus == AVAuthorizationStatusDenied)
    {
        return nil;
    }
    else
    {
        return [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    }
}

- (AVCaptureMetadataOutput *)dataOutPut
{
    if (!_dataOutPut)
    {
        _dataOutPut = [[AVCaptureMetadataOutput alloc] init];
    }
    
    return _dataOutPut;
}

- (AVCaptureVideoPreviewLayer *)previewLayer
{
    if (!_previewLayer)
    {
        _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
        [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        _previewLayer.frame = self.view.frame;
    }
    
    return _previewLayer;
}

@end
