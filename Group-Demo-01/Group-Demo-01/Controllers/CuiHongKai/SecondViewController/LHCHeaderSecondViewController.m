//
//  LHCHeaderSecondViewController.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/6.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCHeaderSecondViewController.h"
#import "LHCTwoHeaderModel.h"

@interface LHCHeaderSecondViewController () <UIWebViewDelegate>

/**数据展示*/
@property (nonatomic,strong) UIWebView *myWeb;

@end

@implementation LHCHeaderSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
   
    self.tabBarController.tabBar.hidden = NO;
}

/**重写model的set方法来实现界面展示*/
- (void)setModel:(LHCTwoHeaderModel *)model {
    _model = model;

    NSString *url = model.object[@"url"];
    //将需要展示的url赋给webView
    [self.myWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

#pragma mark--------------webView相关-------------
- (UIWebView *)myWeb {
    if (_myWeb == nil) {
        _myWeb = [[UIWebView alloc] initWithFrame:self.view.bounds];

        _myWeb.scalesPageToFit = YES;
        
        _myWeb.scrollView.bounces = NO;
        
        _myWeb.delegate =self;
        
        [self.view addSubview:_myWeb];
    }
    return _myWeb;
}



@end
