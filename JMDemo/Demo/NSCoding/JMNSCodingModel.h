//
//  JMNSCodingModel.h
//  JMDemo
//
//  Created by liujiemin on 2021/10/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMNSCodingModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *age;

+ (void)saveModel:(JMNSCodingModel *)model;

+ (JMNSCodingModel *)getModel;

@end

NS_ASSUME_NONNULL_END
