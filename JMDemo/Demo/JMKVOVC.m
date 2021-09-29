//
//  JMKVOVC.m
//  JMDemo
//
//  Created by liujiemin on 2021/9/27.
//

#import "JMKVOVC.h"

@interface JMKVOVC ()

@property (nonatomic ,copy) NSString *shenfan;

@end

@implementation JMKVOVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

- (void)prepareUI {
    self.title = @"KVO";
    self.view.backgroundColor = [UIColor whiteColor];
    self.name = @"111";
    
    [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    [self addObserver:self forKeyPath:@"suibian" options:NSKeyValueObservingOptionNew context:nil];
    self.suibian = @"111";
}

// 只允许监听name属性
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    BOOL automatic = NO;
    if ([key isEqualToString:@"name"]) {
        automatic = YES;
    } else {
        automatic = [super automaticallyNotifiesObserversForKey:key];
    }
    return automatic;
}

+ (BOOL)automaticallyNotifiesObserversOfShenfan {
    return NO;
}

+ (BOOL)automaticallyNotifiesObserversOfSuibian {
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 手动触发KVO
    [self willChangeValueForKey:@"nickName"];
    _nickName = @"111";
    [self didChangeValueForKey:@"nickName"];
    
    // 自动触发KVO
//    self.name = @"111";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"");
}

@end
