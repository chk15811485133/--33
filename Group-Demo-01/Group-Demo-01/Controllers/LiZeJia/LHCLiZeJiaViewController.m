//
//  LHCLiZeJiaViewController.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCLiZeJiaViewController.h"

@interface LHCLiZeJiaViewController ()

@end

@implementation LHCLiZeJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.bounds = CGRectMake(0, -64, XBScreenWidth, XBScreenHeight);
    
    [self customNavigationBar];
    
    [self addUI];
    
    [self loadData];
    
}

- (void)addUI{
    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
        [_manager.securityPolicy setAllowInvalidCertificates:YES];
    }
    
    [self addTableView];
    [self addScrollView];
    
    [self mjRrfresh];
}

- (void)mjRrfresh{
    _headView = [MJRefreshHeaderView header];
    __weak typeof(self) weakSelf = self;
    
    _headView.beginRefreshingBlock = ^(MJRefreshBaseView * refreshView){
        [weakSelf loadData];
    };
    _headView.scrollView = _tableView;
    
    _footView = [MJRefreshFooterView footer];
    
    _footView.beginRefreshingBlock = ^(MJRefreshBaseView * refreshView){
        [weakSelf loadMoreData];
    };
    _footView.scrollView = _tableView;
    
    _currentPage = 1;
}

- (void)addScrollView{
    [self.view addSubview:self.scrollView];
}

- (void)addTableView{
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
    
}



- (void)customNavigationBar{
    
    
    
}

- (void)backButton:(UIButton *)button{
    
}



- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, -10, self.view.frame.size.width, self.view.frame.size.height-100);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        
    }
    return _scrollView;
}





- (void)loadData{
    _huProgress = [[HUProgressView alloc]initWithProgressIndicatorStyle:HUProgressIndicatorStyleLarge];
    _huProgress.center = CGPointMake(self.view.center.x, self.view.center.y-60);
    _huProgress.strokeColor = [UIColor redColor];
    [self.view addSubview:_huProgress];
    [_huProgress startProgressAnimating];
    //[self loadDataWithPath:nil];
}



- (void)loadDataWithPath:(NSString *)path{
    
    [_manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self paseData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"---------%@",error);
    }];
}

- (void)paseData:(id)data{
    [_huProgress stopProgressAnimating];
    [_headView endRefreshing];
}

- (void)loadMoreData{
    _currentPage++;
}

- (void)loadDataMoreWithPath:(NSString *)path{
    [_manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self paseMoreData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"---------%@",error);
    }];
}

- (void)paseMoreData:(id)data{
    [_footView endRefreshing];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = nil;
    return cell;
}


@end
