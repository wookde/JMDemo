//
//  JMKVOVC.m
//  JMDemo
//
//  Created by wookde on 2021/9/27.
//

#import "JMKVOVC.h"
#import <objc/runtime.h>
#import "JMKVOVC+JMCategory.h"

@interface JMKVOVC ()

typedef struct  {
    int a;
}jiegouti;

@property (nonatomic ,copy) NSString *shenfan;

@property (nonatomic, copy) NSString *suibian;

@property (nonatomic, copy) NSString *_shenfan;

@end

@implementation JMKVOVC

// @property：帮我们自动生成属性的setter和getter方法的声明。
// @synthesize：帮我们自动生成setter和getter方法的实现以及下划线成员变量。
// @dynamic：告诉编译器不用自动进行 @synthesize，等到运行时再添加方法实现，但是它不会影响@property生成的setter和getter方法的声明。@dynamic是 OC 为动态运行时语言的体现。动态运行时语言与编译时语言的区别：动态运行时语言将函数决议推迟到运行时，编译时语言在编译器进行函数决议。
// 如果重写了属性的gette和setter方法,@property默认生成的 @synthesize就不起作用了,这样就不会自动生成实例变量了
// @property 已经帮我们重写了get set 方法 ,而现在我们又全部重写了get set 方法.导致Xcode 认为我们写的这 get set 方法的属性和@propery 声明的属性不是同一个属性了,所以会报错
@synthesize name = _name;

@dynamic suibian;
- (NSString *)suibian {
    return objc_getAssociatedObject(self, @selector(suibian));
}

- (void)setSuibian:(NSString *)suibian {
    objc_setAssociatedObject(self, @selector(suibian), suibian, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setShenfan:(NSString *)shenfan {
    _shenfan = shenfan;
}

-(void)setName:(NSString *)name {
    _name = name;
}

- (NSString *)name {
    return _name;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

- (void)prepareUI {
    self.title = @"KVO";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"suibian" options:NSKeyValueObservingOptionNew context:nil];
    
    // 此处的self.name是调用的name的get方法
    NSString *str = self.name;
    NSLog(@"%@", str);
    // 此处的self.name是调用的name的set方法
    self.name = @"111";
    
    self.suibian = @"111";
    NSString *str1 = self.suibian;
    NSLog(@"%@", str1);
    
    // 结构体的初始化
    jiegouti a = {1};
    NSLog(@"%d",a.a);
    
    [self JMAddMethod];
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

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
