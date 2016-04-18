//
//  LHCThreeViewController.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCThreeViewController.h"
#import "LHCTrendsViewController.h"
#import "LHCNewsViewController.h"
#import "LHCChatViewController.h"
@interface LHCThreeViewController ()

@end

@implementation LHCThreeViewController{
    LHCRootViewController *vc;
    UIAlertController *alert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"聊天";
    // Do any additional setup after loading the view.
    
    self.tagItemSize = SIZE(SCREEN_WIDTH/2, 30);
    self.backgroundColor = [UIColor whiteColor];
    self.selectedTitleColor = [UIColor blackColor];
    self.selectedIndicatorColor = UIColorRGB(35, 255, 128);
    NSArray *titleArr = @[@"消息",@"好友列表"];
    
    NSArray *classArr = @[[LHCNewsViewController class],[LHCTrendsViewController class]];
    
    [self reloadDataWith:titleArr andSubViewdisplayClasses:classArr];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    button.layer.cornerRadius = 15;
    button.clipsToBounds = YES;
    [button setBackgroundImage:[UIImage imageNamed:@"tab_record.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hadAddFriend:) name:@"selectOneFriend" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hadUser:) name:@"selectUser" object:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (instancetype)init {
    self = [super initWithTagViewHeight:35];
    return self;
}

- (void)buttonAction {
    alert = [UIAlertController alertControllerWithTitle:@"添加好友" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *add = [UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *friend = alert.textFields.firstObject;
        vc = [[LHCRootViewController alloc] init];
        [vc selectOneUser:friend.text];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:cancel];
    [alert addAction:add];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"好友账号";
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectUser" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectOneFriend" object:nil];
}

- (void)hadUser:(NSNotification *)noti {
    NSArray *arr = noti.userInfo[@"arr"];
    if (arr.count) {
        [vc selectONeFriend:alert.textFields.firstObject.text];
    } else {
        [Auxiliary alertWithTitle:@"提示" message:@"无该用户" button:1 done:nil];
    }
}

- (void)hadAddFriend:(NSNotification *)noti {
    NSArray *arr = noti.userInfo[@"arr"];
    if (arr.count) {
        [Auxiliary alertWithTitle:@"提示" message:@"该好友已存在" button:1 done:nil];
    } else {
        [vc addFriend:alert.textFields.firstObject.text];
    }
}

@end
