//
//  JMGrayCell.m
//  JMDemo
//
//  Created by liujiemin on 2022/12/5.
//

#import "JMGrayCell.h"
#import "JMViewOverLay.h"

@interface JMGrayCell ()

// titleLabel
@property (nonatomic, strong) UILabel *titleLabel;

// FOSViewOverLay
@property (nonatomic, strong) JMViewOverLay *overLay;

// uiimageView
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation JMGrayCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    self.contentView.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.overLay];
    [self.overLay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    
//    if (title.intValue % 2 == 0) {
//        self.overLay.hidden = YES;
//    } else {
//        self.overLay.hidden = NO;
//    }
}

- (void)setGray:(BOOL)isGary {
    if (isGary) {
        self.overLay.hidden = NO;
    } else {
        self.overLay.hidden = YES;
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"Image1"];
    }
    return _imageView;
}

- (JMViewOverLay *)overLay {
    if (!_overLay) {
        _overLay = [[JMViewOverLay alloc] init];
        _overLay.translatesAutoresizingMaskIntoConstraints = NO;
        _overLay.backgroundColor = [UIColor lightGrayColor];
        _overLay.layer.compositingFilter = @"saturationBlendMode";
        _overLay.layer.zPosition = FLT_MAX;
        _overLay.hidden = YES;
    }
    return _overLay;
}

@end
