//
//  JMGrayVC.m
//  JMDemo
//
//  Created by liujiemin on 2022/12/5.
//

#import "JMGrayVC.h"
#import "JMGrayCell.h"

@interface JMGrayVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

// collection
@property (nonatomic, strong) UICollectionView *collectionView;

// dataArry
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation JMGrayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
}

- (void)initSubviews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(KGStatusBarH);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSMutableArray *dataArr = self.dataArray;
    return dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JMGrayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JMGrayCell" forIndexPath:indexPath];
    
    NSString *title = self.dataArray[indexPath.row];
    [cell setTitle:title];
    
    if (indexPath.row < 5) {
        [cell setGray:YES];
    } else {
        [cell setGray:NO];
    }
    return cell;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(KGScreenW/2.0, KGScreenH/3.0);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
//        layout.sectionInset = UIEdgeInsetsMake(0, SCREEN_ZOOM(30), SCREEN_ZOOM(44), SCREEN_ZOOM(30));
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KGScreenW, KGScreenH) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[JMGrayCell class] forCellWithReuseIdentifier:@"JMGrayCell"];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        NSArray *datas = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
        _dataArray = [[NSMutableArray alloc] initWithArray:datas];
    }
    return _dataArray;
}

@end
