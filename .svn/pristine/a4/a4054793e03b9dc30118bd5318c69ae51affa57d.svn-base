//
//  LHCTrendsViewController.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCTrendsViewController.h"
#import "LHCChatViewController.h"

@interface LHCTrendsViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *datasource;

@end

@implementation LHCTrendsViewController {
    NSNotification *nnn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self selectFriends];
    [self tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData:) name:@"selectFriends" object:nil];
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
}

- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectFriends" object:nil];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = self.datasource[indexPath.row];
    [self deleteFriend:str];
    [self.datasource removeObject:str];
    [self.tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"取消关注";
}
@end
