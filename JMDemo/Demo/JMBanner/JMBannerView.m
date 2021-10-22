//
//  JMBannerView.m
//  JMDemo
//
//  Created by liujiemin on 2021/10/21.
//

#import "JMBannerView.h"
#import "NSTimer+JMWeakTimer.h"

@interface JMBannerView ()<UIScrollViewDelegate>
// 图片数组
@property (nonatomic, strong) NSMutableArray *imageArr;
// imageViews
@property (nonatomic, strong) NSMutableArray *imageViewArr;
// 当前index
@property (nonatomic, assign) NSInteger currentIndex;
// scrollView
@property (nonatomic, strong) UIScrollView *scrollView;
// 定时器
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation JMBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithImages:(NSArray *)images {
    if (images.count == 0) {
        return nil;
    }
    self.imageArr = [NSMutableArray arrayWithArray:images];
    [self.imageArr insertObject:images.lastObject atIndex:0];
    [self.imageArr addObject:images.firstObject];
    
    return [self initWithFrame:self.frame];
}

- (void)createUI {
    [self addSubview:self.scrollView];
    
    for (int i = 0; i < self.imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:self.imageArr[i]];
        
        [self.scrollView addSubview:imageView];
        [self.imageViewArr addObject:imageView];
    }
    
//    self.timer = [NSTimer scheduledWeakTimerWithTimeInterval:3.0 target:self selector:@selector(showNext) userInfo:nil repeats:YES];
//    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
//    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)showNext {
    NSLog(@"%s",__func__);
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat offsetX = self.scrollView.contentOffset.x;
        [self.scrollView setContentOffset:CGPointMake(offsetX + self.frame.size.width, 0) animated:YES];
    });
}

- (void)setInterval:(NSTimeInterval)interval {
    [self.timer fire];
    self.timer = nil;
    
    dispatch_after(interval, dispatch_get_main_queue(), ^{
        self.timer = [NSTimer scheduledWeakTimerWithTimeInterval:interval target:self selector:@selector(showNext) userInfo:nil repeats:YES];
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
    });
}

- (void)layoutSubviews {
    self.scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * self.imageArr.count, self.frame.size.height);
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    for (int i = 0; i < self.imageArr.count; i++) {
        UIImageView *imageView = self.imageViewArr[i];
        imageView.backgroundColor = [UIColor redColor];
        CGFloat left = self.frame.size.width * i;
        imageView.frame = CGRectMake(left, 0, self.frame.size.width, self.frame.size.height);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.currentIndex = scrollView.contentOffset.x / self.frame.size.width - 2;
    if (scrollView.contentOffset.x >= self.frame.size.width*(self.imageViewArr.count - 1)) {
        [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    }
    
    if (scrollView.contentOffset.x < 0) {
        [scrollView setContentOffset:CGPointMake(self.frame.size.width*(self.imageViewArr.count - 2), 0)];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.timer setFireDate:[NSDate date]];
}

#pragma mark - 懒加载
- (NSMutableArray *)imageArr {
    if (!_imageArr) {
        _imageArr = [[NSMutableArray alloc] init];
    }
    return _imageArr;
}

- (NSMutableArray *)imageViewArr {
    if (!_imageViewArr) {
        _imageViewArr = [[NSMutableArray alloc] init];
    }
    return _imageViewArr;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
