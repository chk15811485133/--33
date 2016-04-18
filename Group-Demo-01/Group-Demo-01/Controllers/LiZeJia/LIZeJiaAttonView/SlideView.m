//
//  SlideView.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "SlideView.h"
#import "UICreateModel.h"
@interface SlideView ()

@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UIView * slideView;

@property (nonatomic,strong) NSMutableArray * buttons;

@end


@implementation SlideView

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc]init];
        _bgView.frame = CGRectMake(10, 7, self.bounds.size.width-2*10, self.bounds.size.height-2*7);
        _bgView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        _bgView.layer.cornerRadius = 4;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UIView *)slideView{
    if (_slideView == nil) {
        _slideView = [[UIView alloc]init];
        _slideView.backgroundColor = [UIColor whiteColor];
        _slideView.layer.cornerRadius = 4;
        _slideView.layer.masksToBounds = YES;
    }
    return _slideView;
}



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.slideView];
    
    if (_buttons == nil) {
        _buttons = [[NSMutableArray alloc]init];
    }
}

- (void)setTitles:(NSArray *)titles{
    CGFloat gap = 1;
    CGFloat width = (self.bgView.frame.size.width-2*gap)/titles.count;
    CGFloat height = self.bgView.frame.size.height-2*gap;
    
    self.slideView.frame = CGRectMake(gap, gap, width, height);
    
    for (int i = 0; i < titles.count; i++) {
        UIButton * button = [UICreateModel buttonWithFrame:CGRectMake(i*width, 0, width, height) title:titles[i] image:nil target:self select:@selector(buttonClick:)];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        
        if (i == 0) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
        button.tag = i + 11;
        [self.bgView addSubview:button];
        [self.buttons addObject:button];
        
    }
    
}


- (void)buttonClick:(UIButton *)button{
    NSInteger index = button.tag - 11;
    
    for(UIButton * but in _buttons) {
        if ([but isEqual:button]) {
            but.selected = YES;
        }else{
            but.selected = NO;
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.slideView.frame = CGRectMake(1+self.slideView.frame.size.width*index, 1, self.slideView.frame.size.width, self.slideView.frame.size.height);
        
    }];
    if (self.selectAtIndex) {
        _selectAtIndex(index);
    }
}

- (void)setSlideViewToOffsexX:(CGFloat)x{
    CGFloat width = self.slideView.frame.size.width;
    CGFloat offsexX =width*x;
    self.slideView.frame = CGRectMake(1+offsexX, self.slideView.frame.origin.y, self.slideView.frame.size.width, self.slideView.frame.size.height);
    
    NSInteger index = x/1;
    for (int i = 0; i < _buttons.count; i++) {
        UIButton * button = _buttons[i];
        if (i == index) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }
}

@end
