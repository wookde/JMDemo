//
//  JMBlock.m
//  JMDemo
//
//  Created by liujiemin on 2021/10/6.
//

#import "JMBlock.h"

@implementation JMBlock

- (void)method {
    int multiplier = 6;
    int (^Block)(int) = ^int(int num) {
        return num * multiplier;
    };
    Block(2);
}

// 全局变量
int global_var = 4;
// 静态全局变量
static int static_global_var = 5;

- (void)catch {
    // 基本数据类型的局部变量
    int var = 1;
    // 对象类型的局部变量
    __unsafe_unretained id unsafe_obj = nil;
    __strong id strong_obj = nil;
    // 局部静态变量
    static int static_var = 3;
    
    // block
    void(^Block)(void) = ^{
        NSLog(@"局部变量<基本数据类型> var %d", var);
        NSLog(@"局部变量<__unsafe_unretained 对象类型> unsafe_obj %@", unsafe_obj);
        NSLog(@"局部变量<__strong 对象类型> strong_obj %@", strong_obj);
        NSLog(@"局部变量<静态变量> static_var %d", static_var);
        NSLog(@"全局变量 global_var %d", global_var);
        NSLog(@"静态全局变量 static_global_var %d", static_global_var);
    };
    
    Block();
}

@end
