//
//  JMItemModel.h
//  JMDemo
//
//  Created by liujiemin on 2025/10/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMItemModel : NSObject

@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger quantity;

@end

NS_ASSUME_NONNULL_END
