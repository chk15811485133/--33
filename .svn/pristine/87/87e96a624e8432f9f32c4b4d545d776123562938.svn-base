//
//  LHCTwoViewController.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCTwoViewController.h"
#import "LHCTwoHeaderModel.h"
#import "LHCTwoFooterModel.h"
#import "UIImageView+WebCache.h"
#import "LHCTwoCustomView.h"
#import "LHCHeaderSecondViewController.h"
#import "LHCFooterSecondViewController.h"


#define PATH_URL @"http://api.lofter.com/v1.1/batchdata.api?product=lofter-android-5.0.1&method=newrecomcontent"

#define INTERVAL 40

@interface LHCTwoViewController () <UIScrollViewDelegate>

#warning 添加好友功能
/**
 打算在最上方添加一个搜索添加好友的功能
 */

- (void)createUI;//界面搭建

- (void)loadData;//请求数据

/**头视图显示*/
@property (nonatomic,strong) UIScrollView *headerScroll;
/**头视图数据*/
@property (nonatomic,strong) NSMutableArray *headerSource;

/**尾视图显示*/
@property (nonatomic,strong) UIScrollView *footerScroll;
/**尾视图数据*/
@property (nonatomic,strong) NSMutableArray *footerSource;

/**自动滚动头视图*/
@property (nonatomic,strong) NSTimer *myTimer;

@end

@implementation LHCTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    self.view.backgroundColor = UIColorRGB(238, 238, 238);
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    

    //数据请求
    [self loadData];
}

/**定时器事件*/
- (void)timerAction {
    float width = self.headerScroll.width;
    [self.headerScroll setContentOffset:CGPointMake(self.headerScroll.contentOffset.x+width, 0) animated:YES];
}
/**销毁定时器*/
-(void)dealloc {
    if (_myTimer != nil) {
        [_myTimer invalidate];
    }
}

/**界面搭建*/
- (void)createUI {
    
    [self addImagesForHeaderScroll];
    
    
    [self addViewsForFooterScroll];
}
/**给尾视图添加子视图*/
- (void)addViewsForFooterScroll {
    float width = SCREEN_WIDTH-2*INTERVAL;
    float height = self.footerScroll.height-99;
    
    for (int i = 0; i<self.footerSource.count+2; i++) {
        LHCTwoCustomView *custom = [[LHCTwoCustomView alloc] initWithFrame:CGRectMake(i*(width+2*INTERVAL)+INTERVAL, 20, width, height)];
        
        custom.backgroundColor = [UIColor whiteColor];
        
        custom.userInteractionEnabled = YES;
        [custom addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFooterAction)]];
        
        if (i<self.footerSource.count+1 && i>0) {
            custom.model = self.footerSource[i-1];
        }
        else if (i==0){
            custom.model = self.footerSource.lastObject;
        }
        else if (i==self.footerSource.count+1){
            custom.model = self.footerSource.firstObject;
        }
        
        [self.footerScroll addSubview:custom];
        
        self.footerScroll.contentSize = SIZE(custom.maxX+INTERVAL, 0);
    }
    
    self.footerScroll.contentOffset = CGPointMake(self.footerScroll.width, 0);
    
}

/**尾视图点击事件*/
- (void)tapFooterAction {
    LHCFooterSecondViewController *footerSecond = [[LHCFooterSecondViewController alloc] init];
    
    NSInteger page = self.footerScroll.contentOffset.x / self.footerScroll.width;
    
    if (page == self.footerSource.count+1) {
        page = 0;
    }
    else if (page == 0) {
        page = self.footerSource.count-1;
    }
    else {
        page -=1;
    }
    footerSecond.model = self.footerSource[page];
    
    [self.navigationController pushViewController:footerSecond animated:YES];
}

/**给头视图添加图片*/
- (void)addImagesForHeaderScroll {
    float width = SCREEN_WIDTH;
    float height = self.headerScroll.height;
    
    for (int i = 0; i < self.headerSource.count+2;i++ ) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*width, 0, width, height)];
        imageView.userInteractionEnabled = YES;
        
        //添加点击手势
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeaderAction)]];
        
        LHCTwoHeaderModel *model = nil;
        if (i<self.headerSource.count+1 && i>0) {
            model =self.headerSource[i-1];
        }
        else if (i==0){
            model = self.headerSource.lastObject;
        }
        else if (i==self.headerSource.count + 1){
            model = self.headerSource.firstObject;
        }
        [imageView sd_setImageWithURL:[NSURL URLWithString: model.img]];
        //添加图片
        [self.headerScroll addSubview:imageView];
        //设置滚动视图的contentSize
        self.headerScroll.contentSize = SIZE(imageView.maxX, 0);
    }
    
    self.headerScroll.contentOffset = CGPointMake(self.headerScroll.width, 0);
}

/**头视图点击事件*/
- (void)tapHeaderAction {
    LHCHeaderSecondViewController *headerSecond = [[LHCHeaderSecondViewController alloc] init];
    
    NSInteger page = self.headerScroll.contentOffset.x / self.headerScroll.width;
    
    if (page == self.headerSource.count+1) {
        page = 0;
    }
    else if (page == 0) {
        page = self.headerSource.count-1;
    }
    else {
        page -=1;
    }
    
    headerSecond.model = self.headerSource[page];
    
    [self.navigationController pushViewController:headerSecond animated:YES];
}

#pragma mark ----------数据请求相关----------
/**数据请求*/
- (void)loadData {
    //显示加载指示器
    self.isLoadIndicator = YES;
    [self showIndicatorInView:self.view  isDisplay:YES];
    
    //数据请求
    [self request:@"GET" url:PATH_URL para:nil];
}
/**数据解析*/
- (void)parserData:(id)data {
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *allData = response[@"response"][@"items"];
    
    for (NSDictionary *dic in allData) {
        if ([dic[@"type"] integerValue] == 0) {
            NSArray *arr = dic[@"item"];
            //将数据添加到数据源中
            for (NSDictionary *dict in arr) {
                LHCTwoHeaderModel *model = [[LHCTwoHeaderModel alloc] initWithDictionary:dict error:nil];
                if (model.type == 4) {
                    [self.headerSource addObject:model];
                }
            }
        }
        else if ([dic[@"type"] integerValue] == 1) {
            NSArray *arr = dic[@"item"];
            for (NSDictionary *dict in arr) {
                NSDictionary *dict1 = dict[@"item"];
                LHCTwoFooterModel *model = [[LHCTwoFooterModel alloc] initWithDictionary:dict1 error:nil];
                [self.footerSource addObject:model];
            }
        }
    }
    
    //得到数据之后搭建界面
    [self createUI];
    //取消加载指示器
    [self showIndicatorInView:self.view isDisplay:NO];
}

#pragma mark ----------懒加载---------
- (UIScrollView *)headerScroll {
    if (_headerScroll == nil) {
        _headerScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT-64)/3)];
        //打开按页滚动
        _headerScroll.pagingEnabled = YES;
        
        _headerScroll.delegate = self;
        
        [self.view addSubview:_headerScroll];
    }
    return _headerScroll;
}
- (NSMutableArray *)headerSource {
    if (_headerSource == nil) {
        _headerSource = [NSMutableArray array];
    }
    return _headerSource;
}

- (UIScrollView *)footerScroll {
    if ( _footerScroll == nil) {
        _footerScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headerScroll.maxY, SCREEN_WIDTH, (SCREEN_HEIGHT-64)/3*2)];
        //打开按页滚动
        _footerScroll.pagingEnabled = YES;
        
        _footerScroll.backgroundColor = ArcCOLOR;
        
        _footerScroll.delegate = self;
        
        [self.view addSubview:_footerScroll];
    }
    return _footerScroll;
}

- (NSMutableArray *)footerSource {
    if (_footerSource == nil) {
        _footerSource = [NSMutableArray array];
    }
    return _footerSource;
}


#pragma mark ------------滚动视图代理方法--------------
//停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
   
    if ([scrollView isEqual:self.headerScroll]) {
        NSInteger page = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
        
        if (page == self.headerSource.count+1) {
            self.headerScroll.contentOffset = CGPointMake(CGRectGetWidth(scrollView.frame), 0);
            page = 1;
        }else if (page == 0) {
            self.headerScroll.contentOffset = CGPointMake(self.headerSource.count*CGRectGetWidth(scrollView.frame), 0);
            page = self.headerSource.count;
        }
    }
    else if ([scrollView isEqual:self.footerScroll]){
        NSInteger page = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
        
        if (page == self.footerSource.count+1) {
            self.footerScroll.contentOffset = CGPointMake(CGRectGetWidth(scrollView.frame), 0);
            page = 1;
        }else if (page == 0) {
            self.footerScroll.contentOffset = CGPointMake(self.footerSource.count*CGRectGetWidth(scrollView.frame), 0);
            page = self.footerSource.count;
        }
    }
}

//动画结束
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    
    if (page == self.headerSource.count+1) {
        self.headerScroll.contentOffset = CGPointMake(CGRectGetWidth(scrollView.frame), 0);
        page = 1;
    }else if (page == 0) {
        self.headerScroll.contentOffset = CGPointMake(self.headerSource.count*CGRectGetWidth(scrollView.frame), 0);
        page = self.headerSource.count;
    }
}







@end
