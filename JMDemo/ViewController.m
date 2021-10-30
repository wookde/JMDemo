//
//  ViewController.m
//  JMDemo
//
//  Created by wookde on 2021/7/21.
//

#import "ViewController.h"
#import "JMData.h"
#import "JMCATransitionVC.h"
#import "JMWebviewVC.h"
#import "JMPopVC.h"
#import "JMGCDVC.h"
#import "JMUIWebViewVC.h"
#import "JMRuntimeMsgSendVC.h"
#import "JMOperatorVC.h"
#import "JMBlockVC.h"
#import "JMKVOVC.h"
#import "JMKVCVC.h"
#import "JMRunLoopVC.h"
#import "JMDelegateVC.h"
#import "JMFrameAndBoundsVC.h"
#import "JMCALayerVC.h"
#import "JMBannerVC.h"
#import "JMNSCodingVC.h"
#import "JMInitObjWithStrVC.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

// tableView
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareUI];
}

- (void)prepareUI {
    self.title = @"JMDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSInteger counts = [JMData getTableViewData].count;
//        NSIndexPath *path = [NSIndexPath indexPathForRow:counts-1 inSection:0];
//        [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    });
    
    dispatch_after(1.0, dispatch_get_main_queue(), ^{
        NSInteger counts = [JMData getTableViewData].count;
        NSIndexPath *path = [NSIndexPath indexPathForRow:counts-1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [JMData getTableViewData].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *showUserInfoCellIdentifier = @"ShowUserInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (cell == nil)
    {
        // Create a cell to display an ingredient.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:showUserInfoCellIdentifier];
    }
        
    // Configure the cell.
    NSString *title = [[JMData getTableViewData] objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            JMCATransitionVC *vc = [[JMCATransitionVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            JMWebviewVC *vc = [[JMWebviewVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            JMUIWebViewVC *vc = [[JMUIWebViewVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            JMPopVC *vc = [[JMPopVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            JMGCDVC *vc = [[JMGCDVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            JMRuntimeMsgSendVC *vc = [[JMRuntimeMsgSendVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            JMOperatorVC *vc = [[JMOperatorVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7:
        {
            JMBlockVC *vc = [[JMBlockVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 8:
        {
            JMKVOVC *vc = [[JMKVOVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 9:
        {
            JMKVCVC *vc = [[JMKVCVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10:
        {
            JMRunLoopVC *vc = [[JMRunLoopVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 11:
        {
            JMDelegateVC *vc = [[JMDelegateVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 12:
        {
            JMFrameAndBoundsVC *vc = [[JMFrameAndBoundsVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 13:
        {
            JMCALayerVC *vc = [[JMCALayerVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 14:
        {
            JMBannerVC *vc = [[JMBannerVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 15:
        {
            JMNSCodingVC *vc = [[JMNSCodingVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 16:
        {
            JMInitObjWithStrVC *vc = [[JMInitObjWithStrVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
