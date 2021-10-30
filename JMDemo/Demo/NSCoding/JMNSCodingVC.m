//
//  JMNSCodingVC.m
//  JMDemo
//
//  Created by liujiemin on 2021/10/27.
//

#import "JMNSCodingVC.h"
#import "JMNSCodingModel.h"
#import <pthread.h>

@interface JMNSCodingVC (){
    pthread_rwlock_t rwlock;
    NSLock *lock;
    int data;
}

@end

@implementation JMNSCodingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    
    [self invoke];
}

- (void)invoke {
//     pthread_rwlock_t rwlock;
    lock = [[NSLock alloc] init];
    data = 0;
    /// 初始化锁
    pthread_rwlock_init(&rwlock, NULL);

    dispatch_queue_t theQueue = dispatch_get_global_queue(0, 0);
    
    for (int i = 0; i < 100; ++i) {
        dispatch_async(theQueue, ^{
            [self write];
        });
    }
    
    for (int i = 0; i < 100; ++i) {
        dispatch_async(theQueue, ^{
            [self read];
        });
    }
}


- (void)write {
    [lock lock];
//    pthread_rwlock_wrlock(&rwlock);
//    sleep(3);
    NSLog(@"%s:%d", __func__,data);
    data++;
    [lock unlock];
//    pthread_rwlock_unlock(&rwlock);
}

- (void)read {
    pthread_rwlock_rdlock(&rwlock);
    
//    sleep(1);
//    NSLog(@"%s:%d", __func__,data);
    
    pthread_rwlock_unlock(&rwlock);
}



- (void)prepareUI {
    self.title = @"NSCoding";
    self.view.backgroundColor = [UIColor whiteColor];
    
    JMNSCodingModel *model = [[JMNSCodingModel alloc] init];
    model.name = @"wookde";
    model.age = @"18";
    [JMNSCodingModel saveModel:model];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    JMNSCodingModel *model = [JMNSCodingModel getModel];
    NSLog(@"name:%@/nage:%@",model.name,model.age);
}


@end
