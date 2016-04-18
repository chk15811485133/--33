//
//  LHCAttentionViewController.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/12.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCAttentionViewController.h"
#import "LHCChatViewController.h"

@interface LHCAttentionViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datasource;

@end

@implementation LHCAttentionViewController {
    NSNotification *nnn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的粉丝";
    [self selectUsers];
    [self tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData:) name:@"selectAllUsers" object:nil];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];

    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectAllUsers" object:nil];
}

- (void)loadData:(NSNotification *)noti {
    nnn = noti;
    [self.datasource addObjectsFromArray:noti.userInfo[@"arr"]];
    [self.tableView reloadData];
}

- (NSMutableArray *)datasource {
    if (_datasource == nil) {
        _datasource = [[NSMutableArray alloc] init];
    }
    return _datasource;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.datasource[indexPath.row];
    return cell;
}

//选中好友进入下一级聊天界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LHCChatViewController *chat = [[LHCChatViewController alloc] init];
    
    NSLog(@"%@",indexPath);
    
    chat.friendId = nnn.userInfo[@"arr"][indexPath.row];
    //推入聊天界面
    [self.navigationController pushViewController:chat animated:YES];
}

@end
