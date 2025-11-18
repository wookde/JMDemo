//
//  JMStoreKitVC.m
//  JMDemo
//
//  Created by liujiemin on 2025/10/29.
//

#import "JMStoreKitVC.h"
#import <StoreKit/StoreKit.h>

@interface JMStoreKitVC () <SKProductsRequestDelegate>

@end

@implementation JMStoreKitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([SKPaymentQueue canMakePayments]) {
        [self getProductInfo];
    } else {
        NSLog(@"失败，用户禁止应用内付费购买");
    }
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

- (void)getProductInfo {
    NSSet *set = [NSSet setWithArray:@[@"ProductId"]];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    request.delegate = self;
    [request start];
}

// 查询结果的回调函数
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *myProduct = response.products;
    if (myProduct.count == 0) {
        NSLog(@"无法获取产品信息，购买失败");
        return;
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:myProduct[0]];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

// 购买结果

@end

