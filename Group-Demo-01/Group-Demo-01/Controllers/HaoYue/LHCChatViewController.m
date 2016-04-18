//
//  LHCChatViewController.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCChatViewController.h"
#import "LHCChatTableViewCell.h"
#import "LHCChatTextField.h"

#import "LHCMessage.h"

/**复用ID*/
#define identifier @"1465457"
/**输入框高度*/
#define TEXT_WIDTH 40

@interface LHCChatViewController () <UITableViewDataSource,UITableViewDelegate,EMChatManagerDelegate>

/**内容展示*/
@property (nonatomic,strong) UITableView *tableView;

/**输入框*/
@property (nonatomic,strong) LHCChatTextField *myTextField;

@end

@implementation LHCChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createEMConversation];
    
    
    [self tableView];
    [self myTextField];
    
    //添加代理
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

- (void)dealloc {
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}
/**实例化一个会话*/
- (void)createEMConversation {
    /**实例化一个同当前对象的会话*/
    EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:self.friendId conversationType:eConversationTypeChat];
    /**接收此会话消息*/
    conversation.enableUnreadMessagesCountEvent = YES;
    
    NSArray *arr = [conversation loadAllMessages];
    
    for (EMMessage *message in arr) {
        /**获取消息体*/
        id<IEMMessageBody> messageBody = message.messageBodies.firstObject;
        
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text://文字聊天
            {
                NSString * txt = ((EMTextMessageBody*)messageBody).text;//获得文字信息
                /**得到信息添加进数据源*/
                LHCMessage *mess = [[LHCMessage alloc] init];
                mess.messages = txt;
                mess.from = message.from;
                
                NSLog(@"%@\n%@",self.friendId,message.from);
                
                [self.dataSource addObject:mess];
            }
                break;
                
            default:
                break;
        }
    }
    [self.tableView reloadData];
}
#pragma mark--------------聊天代理方法--------------
- (void)didReceiveMessage:(EMMessage *)message {
    /**如果这个消息不是当前会话好友发来的不接收*/
    if (![message.from isEqualToString:self.friendId]) {
        return;
    }
    /**获取消息体*/
    id<IEMMessageBody> messageBody = message.messageBodies.firstObject;
    
    switch (messageBody.messageBodyType) {
        case eMessageBodyType_Text://文字聊天
        {
            NSString * txt = ((EMTextMessageBody*)messageBody).text;//获得文字信息
            /**得到信息添加进数据源*/
            LHCMessage *mess = [[LHCMessage alloc] init];
            mess.messages = txt;
            mess.from = message.from;
            [self.dataSource addObject:mess];
        }
            break;
            
        default:
            break;
    }
    
    [self.tableView reloadData];
}

#pragma mark ------------TableView协议---------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHCChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    /**得到要显示的消息*/
    LHCMessage *message = self.dataSource[indexPath.row];
    cell.friendID = self.friendId;
    cell.messagess = message;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
/**自定制cell高*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHCChatTableViewCell *cell = (LHCChatTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeight;
}

#pragma mark --------------懒加载-------------
- (UITableView *)tableView {
    if ( _tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        /**留出输入框的高度*/
        _tableView.height -= TEXT_WIDTH;
        
        /**打开TableView用户交互*/
        _tableView.userInteractionEnabled = YES;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        /**添加一个手键盘手势*/
        [_tableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
        
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        [self.view addSubview:_tableView];
    }
    //注册一个cell
    [_tableView registerClass:[LHCChatTableViewCell class] forCellReuseIdentifier:identifier];
    return _tableView;
}

- (LHCChatTextField *)myTextField {
    if (_myTextField == nil) {
        _myTextField = [[LHCChatTextField alloc] initWithFrame:CGRectMake(0, self.tableView.maxY, SCREEN_WIDTH, TEXT_WIDTH)];
        
        /**发送事件*/
        [self sendAction];
        /**进入编辑*/
        [self aboutEditing];
        /**退出编辑*/
        [self endEditing];
        
        /**键盘聚焦手势*/
        [_myTextField addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldAction)]];
        
        _myTextField.backgroundColor = UIColorRGB(230, 230, 230);
        
        [self.view addSubview:_myTextField];
    }
    return _myTextField;
}

/**将键盘聚焦*/
- (void)textFieldAction {
    [self.myTextField.textField becomeFirstResponder];
}

#pragma mark -----------键盘的收放------------
/**推出键盘*/
- (void)aboutEditing {
    __weak typeof(self) weakSelf = self;
    
    CGFloat y = SCREEN_HEIGHT - self.myTextField.height - 216-55;
    
    self.myTextField.editing = ^ {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.myTextField.y = y;
        }];
    };
}
/**收键盘手势*/
- (void)tapAction {
    /**取消键盘第一响应者*/
    [self.myTextField.textField resignFirstResponder];
}

/**收键盘*/
- (void)endEditing {
    __weak typeof(self) weakSelf = self;
    
    self.myTextField.endEdited = ^ {
       [UIView animateWithDuration:0.3 animations:^{
           weakSelf.myTextField.y = weakSelf.tableView.maxY;
       }];
    };
}

#pragma mark -------------关于消息的发送--------------
/**发送点击事件实现*/
- (void)sendAction {
    __weak typeof(self) weakSelf = self;
    self.myTextField.sendAction = ^(NSString *message){
        NSLog(@"%@",message);
        /**将需要发送的信息添加到数据源*/
        LHCMessage *mess = [[LHCMessage alloc] init];
        mess.messages = message;

        [weakSelf.dataSource addObject:mess];
        /**刷新数据源*/
        [weakSelf.tableView reloadData];
        
        /**实例化消息体并发送*/
        [weakSelf sendMessage:message];
    };
}

/**实例化消息体并发送*/
- (void)sendMessage:(NSString *)message {
    //1 封装消息内容
    EMChatText * text = [[EMChatText alloc] initWithText:message];
    
    //2 封装消息体
    EMTextMessageBody * body = [[EMTextMessageBody alloc] initWithChatObject:text];
    
    //3 构造消息
    //第一个参数为消息的接收者
    //第二个参数为消息体，是数组，但只能有一个消息体
    EMMessage * messages = [[EMMessage alloc] initWithReceiver:self.friendId bodies:@[body]];
        
//    messages.messageType = eMessageTypeChat; // 设置为单聊消息
    
    //4 发送消息
    EMError * error;
    [[EaseMob sharedInstance].chatManager sendMessage:messages progress:nil error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
}


@end
