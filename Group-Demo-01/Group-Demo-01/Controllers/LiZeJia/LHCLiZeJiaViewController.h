//
//  LHCLiZeJiaViewController.h
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCRootViewController.h"

@interface LHCLiZeJiaViewController : LHCRootViewController <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIScrollView * scrollView;

@property (nonatomic,strong) AFHTTPRequestOperationManager * manager;

@property (nonatomic,strong) MJRefreshHeaderView * headView;
@property (nonatomic,strong) MJRefreshFooterView * footView;
@property (nonatomic) int currentPage;

@property (nonatomic,strong) HUProgressView * huProgress;

- (void)addUI;

- (void)mjRrfresh;

- (void)customNavigationBar;

- (void)backButton:(UIButton *)button;

- (void)addScrollView;

- (void)addTableView;

- (void)loadData;

- (void)loadMoreData;

- (void)loadDataWithPath:(NSString *)path;

- (void)loadDataMoreWithPath:(NSString *)path;

- (void)paseData:(id)data;

- (void)paseMoreData:(id)data;




@end
