//
//  JMRunLoopVC.m
//  JMDemo
//
//  Created by wookde on 2021/10/6.
//

#import "JMRunLoopVC.h"

@interface JMRunLoopVC ()

@property (nonatomic, strong) NSThread *thread;

@end

@implementation JMRunLoopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    
    // 使用常驻线程
    [self performSelector:@selector(action) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)prepareUI {
    self.title = @"RunLoop";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)action {
    NSLog(@"使用的常驻线程");
}

// 创建一个常驻线程
- (void)run {
    //只要往RunLoop中添加了  timer、source或者observer就会继续执行，一个Run Loop通常必须包含一个输入源或者定时器来监听事件，如果一个都没有，Run Loop启动后立即退出。
    @autoreleasepool {
    //1、添加一个input source
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    //2、添加一个定时器
//    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(test) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] run];
    }
}

- (NSThread *)thread {
    if (!_thread) {
        _thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
        [_thread start];
    }
    return _thread;
}

@end
