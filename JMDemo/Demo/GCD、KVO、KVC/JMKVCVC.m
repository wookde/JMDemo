//
//  JMKVCVC.m
//  JMDemo
//
//  Created by wookde on 2021/10/5.
//

#import "JMKVCVC.h"

@interface JMKVCVC (){
    NSString *_name1;
}

@end

@implementation JMKVCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

- (void)prepareUI {
    self.title = @"KVC";
    self.view.backgroundColor = [UIColor grayColor];
    
    // 当调用setValue forKey时，底层的执行顺序：
    // 1、调用set方法，set<key>
    // 2、如果没有找到set方法，会检查+(BOOL)accessInstanceVariablesDirectly方法是否被重写，
    //   默认返回的是YES,如果重写返回的是NO,会执行setValue forUndefineKey
    // 3、如果没有找到set<Key>,会找_<key>,_is<key>的成员变量是否存在，如果存在，赋值
    // 4、如果3中的成员变量不存在，会找<key>,is<key>的成员变量赋值
    JMKVCVC *vc = [[JMKVCVC alloc] init];
    [vc setValue:@"11" forKey:@"name1"];
    NSLog(@"%@",_name1);
    [vc setValue:@"11" forKey:@"name2"];
}

+ (BOOL)accessInstanceVariablesDirectly {
//    return NO;
    return YES;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"抛出异常");
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
