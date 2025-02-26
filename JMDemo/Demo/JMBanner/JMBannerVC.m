//
//  JMBannerVC.m
//  JMDemo
//
//  Created by liujiemin on 2021/10/21.
//

#import "JMBannerVC.h"
#import "JMBannerView.h"

@interface JMBannerVC ()

@end

@implementation JMBannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
}

- (void)prepareUI {
    self.title = @"CALayer";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr = @[@"banner1",@"banner2",@"banner3"];
    JMBannerView *bannerView = [[JMBannerView alloc] initWithImages:arr];
    bannerView.interval = 2.0;
    [self.view addSubview:bannerView];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = 1080 * width / 1920;
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KGNaviBarH);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(height);
    }];
}

@end
