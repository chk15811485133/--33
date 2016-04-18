//
//  LHCMyHomeViewController.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/12.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCMyHomeViewController.h"

@interface LHCMyHomeViewController ()

@property (nonatomic,strong) UIImageView *bgImage;
@property (nonatomic,strong) UIImageView *image;
@property (nonatomic,strong) UILabel *niName;
@property (nonatomic,strong) UILabel *username;
@property (nonatomic,strong) UILabel *guanzhu;
@property (nonatomic,strong) UILabel *fans;
@property (nonatomic,strong) UIImageView *footImage;

@end

@implementation LHCMyHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self selectUsers];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(friend:) name:@"selectFriends" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadInteger:) name:@"selectAllUsers" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
    [self.bgImage removeFromSuperview];
    [self.image removeFromSuperview];
    [self.niName removeFromSuperview];
    [self.username removeFromSuperview];
    [self.guanzhu removeFromSuperview];
    [self.fans removeFromSuperview];
    [self.footImage removeFromSuperview];
}

- (void)loadInteger:(NSNotification *)noti {
    NSArray *arr = noti.userInfo[@"arr"];
    [HaoYue sharedUser].fans = arr.count;
    [self selectFriends];
}

- (void)friend:(NSNotification *)noti {
    NSArray *arr = noti.userInfo[@"arr"];
    [HaoYue sharedUser].guanzhu = arr.count;
    [self createView];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectFriends" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectAllUsers" object:nil];
}

- (void)createView {
    self.bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2.5)];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"meitu_1" ofType:@"jpg"];
    self.bgImage.image = [UIImage imageWithContentsOfFile:path];
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, self.bgImage.maxY-60, 80, 80)];
    self.image.image = [HaoYue sharedUser].icon;
    self.image.layer.cornerRadius = 40;
    self.image.clipsToBounds = YES;
    self.image.layer.borderWidth = 2;
    self.image.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.niName = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, self.image.maxY+10, self.image.width, 30)];
    self.niName.text = [HaoYue sharedUser].niName;
    self.niName.textAlignment = NSTextAlignmentCenter;
    
    self.username = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-60, self.niName.maxY+10, self.image.width+40, 15)];
    self.username.text = [NSString stringWithFormat:@"ID:%@",[HaoYue sharedUser].username];
    self.username.font = [UIFont systemFontOfSize:12];
    self.username.textColor = UIColorWhite(0.3);
    self.username.textAlignment = NSTextAlignmentCenter;
    
    self.guanzhu = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5, self.username.maxY+20, SCREEN_WIDTH/5, 20)];
    self.guanzhu.text = [NSString stringWithFormat:@"关注：%lu",[HaoYue sharedUser].guanzhu];
    self.guanzhu.textAlignment = NSTextAlignmentCenter;
    
    self.fans = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5*3, self.guanzhu.y, self.guanzhu.width, self.guanzhu.height)];
    self.fans.text = [NSString stringWithFormat:@"粉丝：%lu",[HaoYue sharedUser].fans];
    self.fans.textAlignment = NSTextAlignmentCenter;
    
    self.footImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.fans.maxY+30, SCREEN_WIDTH, SCREEN_HEIGHT-self.fans.maxY-30)];
    NSString *pathfoot = [[NSBundle mainBundle] pathForResource:@"meitu2" ofType:@"jpg"];
    self.footImage.image = [UIImage imageWithContentsOfFile:pathfoot];
    
    self.footImage.backgroundColor = ArcCOLOR;
    
    [self.view addSubview:self.bgImage];
    [self.view addSubview:self.image];
    [self.view addSubview:self.niName];
    [self.view addSubview:self.username];
    [self.view addSubview:self.guanzhu];
    [self.view addSubview:self.fans];
    [self.view addSubview:self.footImage];
}

@end
