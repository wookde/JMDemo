//
//  YSXIntegralLabel.m
//  YSXIntegralLabel
//
//  Created by 刘杰民 on 2020/12/8.
//

#import "YSXIntegralLabel.h"

#define TEXT_COLOR [UIColor blackColor];

@interface YSXIntegralLabel()

// 当前的数值
@property (nonatomic, copy) NSString                        *currentStr;
// 目标数值
@property (nonatomic, copy) NSString                        *targetStr;
// 显示的lable数组
@property (nonatomic, strong) NSMutableArray<UILabel *>     *cellArray;
// 未显示的label数组
@property (nonatomic, strong) NSMutableArray<UILabel *>     *targetCellArray;
// 字体大小
@property (nonatomic, strong) UIFont                        *font;
@property (nonatomic, strong) UIColor                       *textColor;
// 多少位
@property (nonatomic, assign) NSUInteger                    rowNumber;
// 每个字的宽度
@property (nonatomic, assign) CGFloat                       cellWidth;
// 每个字的高度
@property (nonatomic, assign) CGFloat                       cellHeight;

@property (nonatomic, assign) BOOL                          isAnimationing;

@end

@implementation YSXIntegralLabel

- (instancetype)initWithNumber:(NSString *)numberStr textColor:(UIColor *)textColor font:(UIFont *)font animated:(BOOL)animated {
    self = [super init];
    if (self) {
        self.currentStr    = numberStr;
        self.targetStr     = numberStr;
        self.textColor     = textColor;
        self.font          = font;
        self.rowNumber     = numberStr.length;
        
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self initCells];
    [self initParent];
}

- (void)initCells {
    CGRect rect = [@"6" boundingRectWithSize:CGSizeZero
                            options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{NSFontAttributeName:self.font}
                            context:nil];
    self.cellWidth = rect.size.width;
    self.cellHeight = rect.size.height;
    
    for (NSInteger i = 0; i < self.rowNumber; i++) {
        UILabel *strLabel = [self makeLabel];
        strLabel.frame = CGRectMake(i * self.cellWidth, 0, self.cellWidth, self.cellHeight);
        [self addSubview:strLabel];
        [self.cellArray addObject:strLabel];
        strLabel.text = [self.targetStr substringWithRange:NSMakeRange(i, 1)];
        
        UILabel *targetLabel = [self makeLabel];
        targetLabel.frame = CGRectMake(i * self.cellWidth, rect.size.height, self.cellWidth, self.cellHeight);
        [self addSubview:targetLabel];
        [self.targetCellArray addObject:targetLabel];
        targetLabel.text = [self.targetStr substringWithRange:NSMakeRange(i, 1)];
    }
}

- (void)initParent {
    self.bounds = CGRectMake(0, 0, self.rowNumber * self.cellWidth, self.cellHeight);
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
}

- (UILabel *)makeLabel {
    UILabel *cell = [[UILabel alloc] init];
    cell.font = self.font;
    cell.textColor = self.textColor;
    cell.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (void)changeToStr:(NSString *)targetStr animated:(BOOL)animated {
    if (self.isAnimationing) { return; }
    
    self.isAnimationing = YES;
    [self jm_changeToStr:targetStr animated:animated];
}

- (void)jm_changeToStr:(NSString *)targetStr animated:(BOOL)animated {
    self.targetStr = targetStr;
    // 两个长度相等
    if (self.rowNumber == targetStr.length) {
        for (NSInteger i = 0 ; i < targetStr.length; i++) {
            NSString *targetChar = [targetStr substringWithRange:NSMakeRange(i, 1)];
            NSString *currentChar = [self.currentStr substringWithRange:NSMakeRange(i, 1)];
            if (![targetChar isEqualToString:currentChar]) {
                [self makeAnimationWithIndex:i targetStr:targetChar animated:animated];
            }
        }
        self.currentStr = targetStr;
        self.rowNumber = targetStr.length;
    }
    
    // 需要变长
    if (self.rowNumber < targetStr.length) {
        NSUInteger count = targetStr.length - self.rowNumber;
        self.rowNumber = targetStr.length;
        [self increaseSelfFrame:count animated:animated];
    }
    
    // 需要变短
    if (self.rowNumber > targetStr.length) {
        NSUInteger count = self.rowNumber - targetStr.length;
        self.rowNumber = targetStr.length;
        [self decreaseSelfFrame:count animated:animated];
    }
}

// 增大自身视图
- (void)increaseSelfFrame:(NSUInteger)count animated:(BOOL)animated {
    // 创建未有的
    for (NSInteger i = 0; i < count; i++) {
        self.currentStr = [NSString stringWithFormat:@"a%@",self.currentStr];
        
        UILabel *newLabel = [self makeLabel];
        newLabel.frame = CGRectMake(i * self.cellWidth, 0, self.cellWidth, self.cellHeight);
        [self addSubview:newLabel];
        [self.cellArray insertObject:newLabel atIndex:i];
        
        UILabel *targetLabel = [self makeLabel];
        targetLabel.frame = CGRectMake(i * self.cellWidth, self.cellHeight, self.cellWidth, self.cellHeight);
        [self addSubview:targetLabel];
        [self.targetCellArray insertObject:targetLabel atIndex:i];
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.cellArray.count * self.cellWidth);
        make.height.mas_equalTo(self.cellHeight);
    }];
    
    // 改变现有的cell位置
    if (animated) {
        [UIView animateWithDuration:0.1 animations:^{
            for (NSInteger i = count ; i < self.cellArray.count; i++) {
                UILabel *label = self.cellArray[i];
                label.frame = CGRectMake(i * self.cellWidth, 0, self.cellWidth, self.cellHeight);
                
                UILabel *targetLabel = self.targetCellArray[i];
                targetLabel.frame = CGRectMake(i * self.cellWidth, self.cellHeight, self.cellWidth, self.cellHeight);
            }
        } completion:^(BOOL finished) {
            [self jm_changeToStr:self.targetStr animated:animated];
        }];
    } else {
        for (NSInteger i = count ; i < self.cellArray.count; i++) {
            UILabel *label = self.cellArray[i];
            label.frame = CGRectMake(i * self.cellWidth, 0, self.cellWidth, self.cellHeight);
            
            UILabel *targetLabel = self.targetCellArray[i];
            targetLabel.frame = CGRectMake(i * self.cellWidth, self.cellHeight, self.cellWidth, self.cellHeight);
        }
        [self jm_changeToStr:self.targetStr animated:animated];
    }
}

// 减小自身视图
- (void)decreaseSelfFrame:(NSUInteger)count animated:(BOOL)animated {
    self.currentStr = [self.currentStr substringWithRange:NSMakeRange(0, self.currentStr.length - count)];
    
    // 创建未有的
    for (int i = 0; i < count; i++) {
        
        UILabel *oldLabel = self.cellArray.lastObject;
        [oldLabel removeFromSuperview];
        [self.cellArray removeLastObject];
        
        UILabel *targetLabel = self.targetCellArray.lastObject;
        [targetLabel removeFromSuperview];
        [self.targetCellArray removeLastObject];
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.cellArray.count * self.cellWidth);
        make.height.mas_equalTo(self.cellHeight);
    }];
    // 改变现有的cell位置
    [self jm_changeToStr:self.targetStr animated:animated];
}

- (void)makeAnimationWithIndex:(NSUInteger)index targetStr:(NSString *)targetChar animated:(BOOL)animated {
    UILabel *currentLabel = self.cellArray[index];
    UILabel *targetLable = self.targetCellArray[index];
    targetLable.text = targetChar;
    if (!animated) {
        currentLabel.frame = CGRectMake(index * self.cellWidth, -self.cellHeight, self.cellWidth, self.cellHeight);
        targetLable.frame = CGRectMake(index * self.cellWidth, 0, self.cellWidth, self.cellHeight);
        currentLabel.text = targetChar;
        currentLabel.frame = CGRectMake(index * self.cellWidth, self.cellHeight, self.cellWidth, self.cellHeight);
        [self.cellArray replaceObjectAtIndex:index withObject:targetLable];
        [self.targetCellArray replaceObjectAtIndex:index withObject:currentLabel];
        self.isAnimationing = NO;
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            currentLabel.frame = CGRectMake(index * self.cellWidth, -self.cellHeight, self.cellWidth, self.cellHeight);
            targetLable.frame = CGRectMake(index * self.cellWidth, 0, self.cellWidth, self.cellHeight);
        } completion:^(BOOL finished) {
            currentLabel.text = targetChar;
            currentLabel.frame = CGRectMake(index * self.cellWidth, self.cellHeight, self.cellWidth, self.cellHeight);
            [self.cellArray replaceObjectAtIndex:index withObject:targetLable];
            [self.targetCellArray replaceObjectAtIndex:index withObject:currentLabel];
            self.isAnimationing = NO;
        }];
    }
}

#pragma mark - 懒加载
- (NSMutableArray<UILabel *> *)cellArray {
    if (!_cellArray) {
        _cellArray = [[NSMutableArray alloc] init];
    }
    return _cellArray;
}

- (NSMutableArray<UILabel *> *)targetCellArray {
    if (!_targetCellArray) {
        _targetCellArray = [[NSMutableArray alloc] init];
    }
    return _targetCellArray;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
