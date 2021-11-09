//
//  JMScrollViewVC.m
//  JMDemo
//
//  Created by liujiemin on 2021/11/8.
//

#import "JMScrollViewVC.h"
#import "JMScrollView.h"

#define MaxOffsetY 140

@interface JMScrollViewVC ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) JMScrollView *scrollView;

@property (nonatomic, strong) UIScrollView *subScrollView;

@property (nonatomic, assign) BOOL canScroll;


@end

@implementation JMScrollViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareUI];
}

- (void)prepareUI {
    self.title = @"嵌套SCrollView";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.scrollView];
    self.canScroll = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        if (scrollView.contentOffset.y >= MaxOffsetY) {
            scrollView.contentOffset = CGPointMake(0, MaxOffsetY);
            if (self.canScroll) {
                self.canScroll = NO;
            }
        } else {
            //子视图没到顶部
            if (!self.canScroll) {
                scrollView.contentOffset = CGPointMake(0, MaxOffsetY);
            }
        }
    } else {
        if (self.scrollView.contentOffset.y < MaxOffsetY) {
            scrollView.contentOffset = CGPointMake(0, 0);
        }
        if (scrollView.contentOffset.y <= 0) {
            self.canScroll = YES;
        }
    }
}

- (JMScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[JMScrollView alloc] initWithFrame:CGRectMake(0, 0, KGScreenW, KGScreenH)];
        _scrollView.backgroundColor = [UIColor greenColor];
        _scrollView.contentSize = CGSizeMake(KGScreenW, KGScreenH*2);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        view.backgroundColor = [UIColor redColor];
        [_scrollView addSubview:view];
        
        _subScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 150, KGScreenW, KGScreenH-150)];
        _subScrollView.backgroundColor = [UIColor orangeColor];
        _subScrollView.contentSize = CGSizeMake(KGScreenW, KGScreenH*3);
        _subScrollView.showsVerticalScrollIndicator = NO;
        _subScrollView.delegate = self;
        [_scrollView addSubview:_subScrollView];
        UILabel *label = [[UILabel alloc] init];
        label.text = @"君不见黄河之水天上来，奔流到海不复回。君不见高堂明镜悲白发，朝如青丝暮成雪。人生得意须尽欢，莫使金樽空对月。天生我材必有用，千金散尽还复来。烹羊宰牛且为乐，会须一饮三百杯。岑夫子，丹丘生，将进酒，杯莫停。与君歌一曲，请君为我倾耳听。钟鼓馔玉不足贵，但愿长醉不愿醒。古来圣贤皆寂寞，惟有饮者留其名。陈王昔时宴平乐，斗酒十千恣欢谑。主人何为言少钱，径须沽取对君酌。五花马、千金裘，呼儿将出换美酒，与尔同销万古愁。";
        label.frame = CGRectMake((KGScreenW-10)/2, 0, 20, KGScreenH*3);
        label.numberOfLines = 0;
        [_subScrollView addSubview:label];
    }
    return _scrollView;
}

@end
