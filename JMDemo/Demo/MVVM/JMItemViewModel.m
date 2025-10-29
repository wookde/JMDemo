//
//  JMItemViewModel.m
//  JMDemo
//
//  Created by liujiemin on 2025/10/26.
//

#import "JMItemViewModel.h"
#import "JMItemModel.h"

@interface JMItemViewModel ()

@end

@implementation JMItemViewModel

- (instancetype)initWithModel:(JMItemModel *)model {
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

- (void)updateModel:(JMItemModel *)model {
    self.model = model;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
