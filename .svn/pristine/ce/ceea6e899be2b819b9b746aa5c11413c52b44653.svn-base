//
//  LHCOneViewController.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCOneViewController.h"
#import "SlideView.h"
#import "LHCSubjectViewController.h"
#import "LHCTraveDetailViewController.h"

@interface LHCOneViewController ()
@property (nonatomic, strong) LHCSubjectViewController * traveOne;

@property (nonatomic, strong) LHCTraveDetailViewController * traveTwo;




@end

@implementation LHCOneViewController

{
    SlideView * _slide;
}

- (LHCSubjectViewController *)traveOne {
    if (_traveOne == nil) {
        _traveOne = [[LHCSubjectViewController alloc]init];
    }
    return _traveOne;
}
- (LHCTraveDetailViewController *)traveTwo {
    if (_traveTwo == nil) {
        _traveTwo = [[LHCTraveDetailViewController alloc] init];
    }
    return _traveTwo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self addTableViewHeader];
    
}
- (void)loadData{
    
}

- (void)customNavigationBar{
    
}

- (void)backButton:(UIButton *)button{
}

- (void)addTableViewHeader{
    _slide = [[SlideView alloc]initWithFrame:CGRectMake(0, 0, XBScreenWidth, 49)];
    _slide.titles = @[@"游记",@"专题"];
    
    __weak LHCOneViewController * weakS = self;
    _slide.selectAtIndex = ^(NSInteger index){
        [UIView animateWithDuration:0.3 animations:^{
            weakS.scrollView.contentOffset = CGPointMake(XBScreenWidth*index, 0);
        }];
        
    };
    [self.view addSubview:_slide];
}

- (void)addScrollView{
    [super addScrollView];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*2, self.scrollView.frame.size.height);
    for (int i = 0; i < 2; i++) {
        if (i == 0) {
            LHCSubjectViewController * trave = self.traveOne;
            trave.view.frame = CGRectMake(self.scrollView.frame.size.width*i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            [self.scrollView addSubview:trave.view];
            [self addChildViewController:trave];
        }else{
            LHCTraveDetailViewController * trave = self.traveTwo;
            trave.view.frame = CGRectMake(self.scrollView.frame.size.width*i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            [self.scrollView addSubview:trave.view];
            [self addChildViewController:trave];
        }
        
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat xx = scrollView.contentOffset.x/XBScreenWidth;
    [_slide setSlideViewToOffsexX:xx];
}





@end
