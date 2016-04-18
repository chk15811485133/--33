//
//  LHCChatTextField.h
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SendAction)(NSString *);

@interface LHCChatTextField : UIView

/**内容输入框*/
@property (nonatomic,strong) UITextField *textField;

/**发送按钮点击事件*/
@property (nonatomic,strong) SendAction sendAction;

/**键盘进入编辑的回调*/
@property (nonatomic,strong) void(^editing)();

/**键盘退出编辑的回调*/
@property (nonatomic,strong) void(^endEdited)();

@end
