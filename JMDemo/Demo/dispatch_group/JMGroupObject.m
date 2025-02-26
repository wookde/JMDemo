//
//  JMGroupObject.m
//  JMDemo
//
//  Created by liujiemin on 2025/2/20.
//

#import "JMGroupObject.h"

@interface JMGroupObject ()

// 并发队列
@property (nonatomic, strong) dispatch_queue_t concurrent_queue;
// 下载图片的数组
@property (nonatomic, strong) NSMutableArray *arrayURLs;

@end

@implementation JMGroupObject

- (instancetype)init {
    if (self = [super init]) {
        // 通过宏定义 DISPATCH_QUEUE_CONCURRENT 创建一个并发队列
        self.concurrent_queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
        // 创建数据容器
        self.arrayURLs = [[NSMutableArray alloc] init];
        
        [self.arrayURLs addObject:@"百度"];
        [self.arrayURLs addObject:@"天猫"];
    }
    return self;
}

- (void)handle {
    // 创建一个group
    dispatch_group_t group = dispatch_group_create();
    
    // for循环遍历下载图片
    for (NSURL *url in self.arrayURLs) {
        dispatch_group_async(group, self.concurrent_queue, ^{
            // 根据url下载图片
            NSLog(@"url is %@", url);
        });
    }
    
    dispatch_group_enter(group);
    dispatch_group_leave(group);
    
    dispatch_group_notify(group, self.concurrent_queue, ^{
        // 当数组中所有的图片都下载完成后会调用该block
        NSLog(@"所有图片已全部下载完成");
    });
}

@end
