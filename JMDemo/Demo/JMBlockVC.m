//
//  JMBlockVC.m
//  JMDemo
//
//  Created by liujiemin on 2021/9/26.
//

#import "JMBlockVC.h"
#import "JMKVOVC.h"

@interface JMBlockVC ()

@property (nonatomic, strong) JMKVOVC *vc;

@end

@implementation JMBlockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
}

- (void)prepareUI {
    self.title = @"Block";
    self.view.backgroundColor = [UIColor whiteColor];
    
    void(^block1)(void) = ^{
        NSLog(@"hello");
    };
    /*  block2
     ** 在ARC下会自动copy，从栈复制到堆，所以为__NSMallocBlock__类型
     ** 在MRC下为__NSStackBlock__类型，需要手动调用copy方法才会变为__NSMallocBlock__类型
     **     同时，在不需要该block的时候需要手动调用release方法
     */
    int age = 10;
    void(^block2)(void) = ^{
        NSLog(@"%d",age);
    };
    
    id block3 = ^{
        NSLog(@"%d",age);
    };
    
    NSLog(@"%@,%@,%@", [block1 class], [block2 class], [^{
        NSLog(@"%d",age);
    } class]);
    
//    Class class = [block1 class];
//    while (class) {
//        NSLog(@"%@",class);
//        class = [class superclass];
//    }
    
    self.vc = [[JMKVOVC alloc] init];
    
    [self.vc addObserver:self forKeyPath:@"nickName" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.vc willChangeValueForKey:@"nickName"];
    self.vc.nickName = @"222";
    [self.vc didChangeValueForKey:@"nickName"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"");
}

@end
