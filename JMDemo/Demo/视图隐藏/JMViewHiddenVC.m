//
//  JMViewHiddenVC.m
//  JMDemo
//
//  Created by liujiemin on 2026/1/8.
//

#import "JMViewHiddenVC.h"
#import "SDWebImage/SDWebImage.h"

@interface JMViewHiddenVC ()

@property (nonatomic, strong) UIView *view1;

@property (nonatomic, strong) UIView *view2;

@property (nonatomic, strong) UIView *view3;

@property (nonatomic, strong) SDAnimatedImageView *imageView;

@end

@implementation JMViewHiddenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.view1];
    [self.view addSubview:self.view2];
    [self.view addSubview:self.view3];
    
    [self.view addSubview:self.imageView];
    
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@100);
    }];
    
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view1.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@100);
    }];
    
    [self.view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view2.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@100);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view3.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.width.height.mas_equalTo(200);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.view2.hidden = !self.view2.hidden;
    
//    NSString *url = @"https://raw.githubusercontent.com/wookde/PicGo/refs/heads/main/guitar.gif";
    NSString *url = @"https://raw.githubusercontent.com/wookde/PicGo/refs/heads/main/loading-apng.png";
    
    [self.imageView sd_setHighlightedImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image.images.count) {
            self.imageView.image = image.images.lastObject;
            self.imageView.animationImages = image.images;
            self.imageView.animationDuration = image.duration;
            [self.imageView startAnimating];
        }
    }];
    
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url]];
}

#pragma mark - 懒加载

- (UIView *)view1 {
    if (!_view1) {
        _view1 = [[UIView alloc] init];
        _view1.backgroundColor = [UIColor redColor];
    }
    return _view1;
}

- (UIView *)view2 {
    if (!_view2) {
        _view2 = [[UIView alloc] init];
        _view2.backgroundColor = [UIColor orangeColor];
    }
    return _view2;
}

- (UIView *)view3 {
    if (!_view3) {
        _view3 = [[UIView alloc] init];
        _view3.backgroundColor = [UIColor blueColor];
    }
    return _view3;
}

- (SDAnimatedImageView *)imageView {
    if (!_imageView) {
        _imageView = [[SDAnimatedImageView alloc] init];
        _imageView.shouldCustomLoopCount = YES;
        _imageView.playbackRate = 0.1;
        _imageView.animationRepeatCount = 1;
    }
    return _imageView;
}

@end
