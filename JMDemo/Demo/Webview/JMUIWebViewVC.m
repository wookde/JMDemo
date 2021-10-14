//
//  JMUIWebViewVC.m
//  JMDemo
//
//  Created by wookde on 2021/8/26.
//

#import "JMUIWebViewVC.h"

@interface JMUIWebViewVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webview;

@end

@implementation JMUIWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
}

- (void)prepareUI {
    self.title = @"UIWebView";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webview];
    
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    NSString *scheme = request.URL.scheme;
    if ([request.URL.scheme isEqualToString:@"wvjbscheme"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
        return NO;
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc] init];
        _webview.delegate = self;
    }
    return _webview;
}

@end
