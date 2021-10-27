//
//  JMNSCodingModel.m
//  JMDemo
//
//  Created by liujiemin on 2021/10/27.
//

#import "JMNSCodingModel.h"

#define JMModelFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"JMModel.data"]

@implementation JMNSCodingModel

// iOS的归档.需要自定义对象实现以下两个NSCoding的协议方法
// 在归档的时候,需要做存储操作 archiveRootObject
// 解档的时候,需要做获取操作 unarchiveObjectWithFile

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.age = [coder decodeObjectForKey:@"age"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.age forKey:@"age"];
}

+ (void)saveModel:(JMNSCodingModel *)model {
    JMNSCodingModel *oldModel = [JMNSCodingModel getModel];
    
    model.name = model.name ? model.name : oldModel.name;
    model.age = model.age ? model.age : oldModel.age;
    
    [NSKeyedArchiver archiveRootObject:model toFile:JMModelFile];
}

+ (JMNSCodingModel *)getModel {
    if (JMModelFile) {
        JMNSCodingModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:JMModelFile];
        if (!model) {
            model = [[JMNSCodingModel alloc] init];
        }
        return model;
    }
    return [[JMNSCodingModel alloc] init];
}

@end
