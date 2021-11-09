//
//  JMInitObjWithStrVC.m
//  JMDemo
//
//  Created by liujiemin on 2021/10/30.
//

#import "JMInitObjWithStrVC.h"
#import <objc/runtime.h>

@interface JMInitObjWithStrVC ()

@end

@implementation JMInitObjWithStrVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
}

- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"动态创建类";
    
    NSDictionary *classInfo = @{@"className":@"ViewController"};
    
    id myObj = [[NSClassFromString(classInfo[@"className"]) alloc] init];
    if (myObj) {
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList([myObj class], &outCount);
        NSMutableDictionary *tmpInfo = [NSMutableDictionary dictionary];

        for (i = 0; i < outCount; i++) {

            objc_property_t property = properties[i];

            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];

            tmpInfo[propertyName]=@"1";

        }
        free(properties);
        
        [classInfo enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            if (tmpInfo[key]!=nil&&[tmpInfo[key] isEqualToString:@"1"]) {
                [myObj setValue:obj forKey:key];
            }

        }];
        
        [self.navigationController pushViewController:myObj animated:YES];
    }
}

@end
