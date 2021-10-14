//
//  JMWebviewVC.m
//  JMDemo
//
//  Created by liujiemin on 2021/7/26.
//

#import "JMWebviewVC.h"
#import <WebKit/WebKit.h>

@interface JMWebviewVC ()

// webview
@property (nonatomic, strong) WKWebView *webview;

@end

@implementation JMWebviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webview];
    
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
}

- (WKWebView *)webview {
    if (!_webview) {
        _webview = [[WKWebView alloc] init];
    }
    return _webview;
}

@end
