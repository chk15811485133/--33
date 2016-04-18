//
//  LHCChatTextField.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCChatTextField.h"
#import "EaseMob.h"

#define icon_width 40


@interface LHCChatTextField  () <UITextFieldDelegate>
/**发送按钮点击事件*/
- (void)aboutSendAction;

/**发送图片按钮*/
@property (nonatomic,strong) UIImageView *icon;



/**发送按钮*/
@property (nonatomic,strong) UIButton *button;

@end

@implementation LHCChatTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self icon];
        [self textField];
        [self button];
    }
    return self;
}

#pragma mark-----------键盘代理-----------
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    /**键盘进入编辑状态回调*/
    self.editing();
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    /**键盘退出编辑状态回调*/
    self.endEdited();
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    /**点击return键的回调*/
    if (self.textField.text.length<=0) {
        return YES;
    }
    self.sendAction(self.textField.text);
    self.textField.text = nil;

    return YES;
}



#pragma mark ----------懒加载------------
- (UIImageView *)icon {
    if (_icon == nil) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, icon_width, self.height)];
        
        _icon.image = [UIImage imageNamed:@"tab_friends@2x"];
        
        [self addSubview:_icon];
    }
    return _icon;
}

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(icon_width, 0, SCREEN_WIDTH-2*icon_width, self.height)];
        //添加代理
        _textField.delegate = self;
        
        [self addSubview:_textField];
    }
    return _textField;
}

- (UIButton *)button {
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        /**设置发送按钮位置*/
        _button.frame = CGRectMake(self.textField.maxX, 0, icon_width, self.height);
        
        [_button setTitle:@"发送" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        /**添加发送事件*/
        [_button addTarget:self action:@selector(aboutSendAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_button];
    }
    return _button;
}

/**发送按钮点击事件*/
- (void)aboutSendAction {
    if (self.textField.text.length<=0) {
        return;
    }
    self.sendAction(self.textField.text);
    self.textField.text = nil;
}



@end
