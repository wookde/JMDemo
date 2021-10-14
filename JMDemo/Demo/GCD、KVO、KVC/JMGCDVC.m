//
//  JMGCDVC.m
//  JMDemo
//
//  Created by wookde on 2021/8/18.
//

#import "JMGCDVC.h"
#import <AFNetworking/AFNetworking.h>

@interface JMGCDVC ()

@end

@implementation JMGCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    
    [self exam];
}

- (void)exam {
    NSDictionary *res = [self httpRequest];
    NSLog(@"");
}

- (NSDictionary *)httpRequest {
    __block NSDictionary *response = @{};
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 给manager一个自己的线程
    manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    
    NSString *url = @"http://oss.jiaoshipai.com/online_province_city_area.txt";
    
    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        response = responseObject;
        NSLog(@"");
        dispatch_semaphore_signal(sem);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"");
        dispatch_semaphore_signal(sem);
    }];
    
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    return response;
}

- (void)prepareUI {
    self.title = @"GCD";
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
