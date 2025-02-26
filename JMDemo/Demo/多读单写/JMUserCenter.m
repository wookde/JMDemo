//
//  JMUserCenter.m
//  JMDemo
//
//  Created by liujiemin on 2025/2/20.
//

#import "JMUserCenter.h"

@interface JMUserCenter ()

// 并发队列
@property (nonatomic, strong) dispatch_queue_t concurrent_queue;

// 用户数据中心，可能有多个线程需要数据访问
@property (nonatomic, strong) NSMutableDictionary *userCenterDic;

@end

@implementation JMUserCenter

- (instancetype)init {
    if (self = [super init]) {
        // 通过宏定义 DISPATCH_QUEUE_CONCURRENT 创建一个并发队列
        self.concurrent_queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
        // 创建数据容器
        self.userCenterDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id)objectForKey:(NSString *)key {
    __block id obj;
    // 同步读取指定数据，由于是同步调用，并发，所以当多个线程来获取数据的时候都可以并发获取并返回结果
    dispatch_sync(self.concurrent_queue, ^{
        obj = [self.userCenterDic objectForKey:key];
    });
    
    return obj;
}

- (void)setObject:(id)obj forKey:(NSString *)key {
    // 异步栅栏调用设置数据
    dispatch_barrier_async(self.concurrent_queue, ^{
        [self.userCenterDic setObject:obj forKey:key];
    });
}

@end
