//
//  JMOperatorVC.m
//  JMDemo
//
//  Created by wookde on 2021/9/24.
//

#import "JMOperatorVC.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@interface JMOperatorVC ()

@property (nonatomic, strong) UILabel *operatorLabel;

@end

@implementation JMOperatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

- (void)prepareUI {
    self.title = @"运营商";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.operatorLabel];
    [self.operatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //获取本机运营商名称

    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    //iOS12以上可使用
    //当前手机所属运营商名称
    __block NSString *operatorName = [NSString string];
    if (@available(iOS 12.0, *)) {
        NSDictionary *carrierDic = [info serviceSubscriberCellularProviders];
        
        __block NSString *opers = @"";
        [carrierDic.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CTCarrier *carrier = obj;
            //NSLog(@"carrier = %@", carrier);
            NSString *code = [carrier mobileNetworkCode];
            if (code == nil) {
                operatorName = @"没有SIM卡";
                opers = operatorName;
            } else {
                if ([code isEqualToString:@"00"] || [code isEqualToString:@"02"] || [code isEqualToString:@"04"] || [code isEqualToString:@"07"] || [code isEqualToString:@"08"]) {
                    operatorName = @"移动运营商";
                } else if ([code isEqualToString:@"01"] || [code isEqualToString:@"06"] || [code isEqualToString:@"09"]) {
                    operatorName = @"联通运营商";
                } else if ([code isEqualToString:@"03"] || [code isEqualToString:@"05"] || [code isEqualToString:@"11"]) {
                    operatorName = @"电信运营商";
                } else if ([code isEqualToString:@"20"]) {
                    operatorName = @"铁通运营商";
                }
                opers = [opers stringByAppendingFormat:@"卡%lu:%@\n",(unsigned long)idx,operatorName];
            }
            
            NSLog(@"%@",operatorName);
        }];
        self.operatorLabel.text = opers;
    } else {
        // Fallback on earlier versions
        CTCarrier *carrier = [info subscriberCellularProvider];
        //当前手机所属运营商名称
        //先判断有没有SIM卡，如果没有则不获取本机运营商
        if (!carrier.isoCountryCode) {

            NSLog(@"没有SIM卡");
            operatorName = @"无运营商";

        }else{
            operatorName = [carrier carrierName];

        }
        self.operatorLabel.text = operatorName;
    }
    
    NSLog(@"当前运营商为:%@",operatorName);
}

- (UILabel *)operatorLabel {
    if (!_operatorLabel) {
        _operatorLabel = [[UILabel alloc] init];
        _operatorLabel.text = @"点击获取";
        _operatorLabel.textColor = [UIColor blackColor];
        _operatorLabel.numberOfLines = 0;
    }
    return _operatorLabel;
}

@end
