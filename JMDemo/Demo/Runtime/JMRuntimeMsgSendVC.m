//
//  JMRuntimeMsgSendVC.m
//  JMDemo
//
//  Created by wookde on 2021/9/23.
//

#import "JMRuntimeMsgSendVC.h"
#import <objc/runtime.h>
#import "JMPerson.h"
#import "JMStudent.h"

@interface JMCat : NSObject

- (void)eat;
+ (void)eat;
- (void)sleep;

@end

@implementation JMCat

// Method Swizzling
//+ (void)load {
//    Method m1 = class_getInstanceMethod(self, @selector(eat));
//    Method m2 = class_getInstanceMethod(self, @selector(sleep));
//    method_exchangeImplementations(m1, m2);
//}

//+ (void)initialize { NSLog(@"I am JMCat..initialize Function!"); }
- (void)eat { NSLog(@"%s",__func__); }
+ (void)eat { NSLog(@"%s",__func__); }
- (void)sleep { NSLog(@"%s",__func__); }

@end

@interface JMAnimal : NSObject

- (void)eat;
+ (void)eat;

- (void)sleep;
+ (void)sleep;

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation JMAnimal

+ (void)initialize { NSLog(@"I am JMAnimal..initialize Function!"); }

- (void)sleep { NSLog(@"%s",__func__); }

+ (void)sleep { NSLog(@"%s",__func__); }

/*
    消息机制分为3个阶段
    1.消息的发送
    2.方法动态解析
    3.消息转发
 
 1. 消息的发送
    如果方法列表是经过排序的,则进行二分法查找,如果没有排序则进行遍历查找
    1> 判断receiver是否为nil,如果是,直接结束
    2> 根据receiver的isa找到receiverClass(class/meta-class)
    3> 去receiverClass的cache中查找,如果找到,结束
    4> 去receiverClass的class_rw_t的方法列表中查找(已经排序的:二分法;未排序:遍历查找),如果找到结束,并缓存到cache中
    5> 通过receiverClass的superclass指针找到superclass
    6> 去superclass的cache中查找,如果找到结束查找,并缓存到receiverClass的cache中
    7> 去superclass的class_rw_t中查找(已经排序的:二分法;未排序:遍历查找),如果找到结束,并缓存到receiverClass的cache中
    8> 进入动态解析
 
 2. 动态解析
    我们可以根据方法类型(实例方法or类方法)重写一下方法
    +(BOOL)resolveInstanceMethod:(SEL)sel
    +(BOOL)resolveClassMethod:(SEL)sel
    在方法中调用一下方法来动态添加方法的实现
    ** 参数1:给哪个类添加
    ** 参数2:给哪个方法添加
    ** 参数3:方法的实现地址
    ** 参数4:方法的编码类型
    BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types)
 
  3. 消息转发
    消息转发分为两步进行: Fast forwarding和 Normal forwarding
    1> Fast forwarding : 将消息转发给一个其他的OC对象(找一个备用接收者)
       重写以下方法,返回一个其他对象即可
       +/- (id)forwardingTargetForSelector:(SEL)aSelector
    2> Normal forwarding : 实现一个完整的消息转发过程
       如果Fast forwarding没有解决可以重写以下两个方法启动完整的消息的转发
 
       +/- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
       Runtime 会根据这个方法签名，创建一个NSInvocation对象（NSInvocation封装了未知消息的全部内容，
       包括：方法调用者 target、方法名 selector、方法参数 argument 等），
       然后调用第二个方法并将该NSInvocation对象作为参数传入。
  
       +/- (void)forwardInvocation:(NSInvocation *)invocation
       在该方法中：将未知消息转发给其它对象；改变未知消息的内容(如方法名、方法参数)再转发给其它对象；甚至可以定义任何逻辑。
 
       ⚠️如果第一个方法中没有返回方法签名，或者我们没有重写第二个方法，系统就会认为我们彻底不想处理这个消息了，
       这时候就会调用以下方法
       +/- (void)doesNotRecognizeSelector:(SEL)sel
       方法并抛出经典的 crash:unrecognized selector sent to instance/class，结束 objc_msgSend 的全部流程。
 */

// 动态解析
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(eat)) {
//        // 获取其它方法， Method 就是指向 method_t 结构体的指针
//        Method method = class_getInstanceMethod(self, @selector(sleep));
//        /*
//         ** 参数1:给哪个类添加
//         ** 参数2:给哪个方法添加
//         ** 参数3:方法的实现地址
//         ** 参数4:方法的编码类型
//        */
//        class_addMethod(self,
//                        sel,
//                        method_getImplementation(method),
//                        method_getTypeEncoding(method));
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}
//
//+ (BOOL)resolveClassMethod:(SEL)sel {
//    if (sel == @selector(eat)) {
//        // 获取其它方法， Method 就是指向 method_t 结构体的指针
//        Method method = class_getClassMethod(object_getClass(self), @selector(sleep));
//        class_addMethod(object_getClass(self),
//                        sel,
//                        method_getImplementation(method),
//                        method_getTypeEncoding(method));
//        return YES;
//    }
//    return [super resolveClassMethod:sel];
//}

// 消息转发
// Fast forwarding
//+ (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(eat)) {
//        // 还可以将 eat 消息转发给 JMCat 的类对象
//        return [JMCat class];
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}
//
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(eat)) {
//        // 将 eat 消息转发给 JMCat 的实例对象
//        return [JMCat new];
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}

// Normal forwarding
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(eat)) {
        return [[JMCat new] methodSignatureForSelector:aSelector];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:[JMCat new]];
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(eat)) {
        return [[JMCat class] methodSignatureForSelector:aSelector];
        //return [NSMethodSignature signatureWithObjCTypes:"v@:i"];
    }
    return [super methodSignatureForSelector:aSelector];
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:[JMCat class]];
    
    // 改变未知消息的内容(如方法名、方法参数)再转发给其它对象
    /*
    anInvocation.selector = @selector(sleep);
    anInvocation.target = [JMCat class];
    int age;
    [anInvocation getArgument:&age atIndex:2];  // 参数顺序：target、selector、other arguments
    [anInvocation setArgument:&age atIndex:2];  // 参数的个数由上个方法返回的方法签名决定，要注意数组越界问题
    [anInvocation invoke];
    
    int ret;
    [anInvocation getReturnValue:&age];  // 获取返回值
     */
    
    // 定义任何逻辑，如：只打印一句话
    /*
     NSLog(@"好好学习");
     */
}

@end

@interface JMRuntimeMsgSendVC ()

@end

@implementation JMRuntimeMsgSendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];

    [JMAnimal eat];
    JMAnimal *animal = [[JMAnimal alloc] init];
    [animal eat];

    [JMStudent action];
}

- (void)prepareUI {
    self.title = @"Runtime 消息机制";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    JMCat *animal = [[JMCat alloc] init];
    [animal eat];

}

@end
