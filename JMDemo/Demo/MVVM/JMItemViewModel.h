//
//  JMItemViewModel.h
//  JMDemo
//
//  Created by liujiemin on 2025/10/26.
//

#import <Foundation/Foundation.h>
#import "JMItemModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface JMItemViewModel : NSObject

- (instancetype)initWithModel:(JMItemModel *)model;

// 供View绑定的属性
@property (nonatomic, strong) JMItemModel *model;

// 可以在此定义修改数据的方法，例如更新数量
- (void)updateModel:(JMItemModel *)model;

@end

NS_ASSUME_NONNULL_END
