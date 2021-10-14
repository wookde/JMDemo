//
//  JMPerson.m
//  JMDemo
//
//  Created by liujiemin on 2021/9/23.
//

#import "JMPerson.h"
#import "JMStudent.h"

@implementation JMPerson

// 不管类有没有被调用，只要编译到就会执行load方法。
// 不管子类有没有写load方法，父类的load都只会执行一次
// load方法是线程安全的，内部已经使用了锁，一般的应用场景是在该方法中实现方法的交换
+ (void)load {
    NSLog(@"JMPerson load");
    [JMStudent class];
    [JMPerson class];
}

// 如果没有用到该类，就算加载完毕也不会执行该方法（这点与load方法不同，load方法是只要加载就执行，initialize方法必须是第一次使用该类的时候才触发
// 如果子类的initialize没有实现，那么它可能会继续执行一遍父类的initialize方法
+ (void)initialize {
    NSLog(@"Person initialize");
}

+ (void)eat {
    NSLog(@"Person Eat");
}

@end
