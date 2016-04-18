//
//  LHCChangeViewController.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCChangeViewController.h"

@interface LHCChangeViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *oldPassword;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UITextField *okPassword;

@end

@implementation LHCChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.oldPassword.delegate = self;
    self.password.delegate = self;
    self.okPassword.delegate = self;
    self.oldPassword.secureTextEntry = YES;
    self.password.secureTextEntry = YES;
    self.okPassword.secureTextEntry = YES;
}

- (IBAction)changeAction:(id)sender {
    if (![self.password.text isEqualToString:self.okPassword.text]) {
        [Auxiliary alertWithTitle:@"提示" message:@"密码确认失败" button:1 done:nil];
    } else if (self.oldPassword.text.length == 0 || self.password.text.length == 0 || self.okPassword.text.length == 0) {
        [Auxiliary alertWithTitle:@"提示" message:@"请补全未填写内容" button:1 done:nil];
    } else {
        BmobUser *user = [BmobUser getCurrentUser];
        [user updateCurrentUserPasswordWithOldPassword:self.oldPassword.text newPassword:self.password.text block:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                //用新密码登录
                [BmobUser loginInbackgroundWithAccount:[HaoYue sharedUser].username andPassword:self.password.text block:nil];
                __weak typeof(self) weakself = self;
                [Auxiliary alertWithTitle:@"提示" message:@"修改密码成功" button:1 done:^{
                    [weakself.navigationController popViewControllerAnimated:YES];
                }];
            } else {
                NSLog(@"change password error:%@",error);
            }
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.oldPassword resignFirstResponder];
    [self.password resignFirstResponder];
    [self.okPassword resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self changeAction:nil];
    return YES;
}
@end
