//
//  LHCRegistViewController.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/6.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCRegistViewController.h"

@interface LHCRegistViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UITextField *e_mail;   //验证邮箱

@property (weak, nonatomic) IBOutlet UITextField *niName;

@end

@implementation LHCRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.e_mail.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([self.username resignFirstResponder]) {
        [self.username resignFirstResponder];
    }
    if ([self.password resignFirstResponder]) {
        [self.password resignFirstResponder];
    }
}

//返回登录界面
- (IBAction)returnLogin:(id)sender {
    CATransition *transiction = [CATransition animation];
    transiction.type = @"cube";
    transiction.subtype = @"fromTop";
    [self.view.layer addAnimation:transiction forKey:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//注册
- (IBAction)registAction:(id)sender {
    [self selectOneUser:self.username.text];
    if (self.username.text.length <= 0 || self.password.text.length <= 0 || self.e_mail.text.length <= 0) {
        [Auxiliary alertWithTitle:@"注册失败" message:@"请补全注册信息" button:1 done:nil];
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectResult:) name:@"selectUser" object:nil];
    }
}

- (void)selectResult:(NSNotification *)noti {
    NSArray *arr = noti.userInfo[@"arr"];
    if (arr.count > 0) {
        [Auxiliary alertWithTitle:@"注册失败" message:@"用户名已存在" button:1 done:nil];
    } else {
        BmobUser *bUser = [[BmobUser alloc] init];
        [bUser setUserName:self.username.text];
        [bUser setPassword:self.password.text];
        [bUser setEmail:self.e_mail.text];
        [bUser setObject:self.niName.text forKey:@"name"];
        [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
            if (isSuccessful){
                //异步注册
                [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.username.text password:self.password.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
                    if (!error) {

                        [Auxiliary alertWithTitle:@"注册成功" message:@"请前往注册邮箱进行激活" button:1 done:nil];
                        
                    }
                    else {
                        [Auxiliary alertWithTitle:@"注册失败" message:@"邮箱已被占用" button:1 done:nil];
                    }
                } onQueue:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                NSLog(@"%@",error);
                [Auxiliary alertWithTitle:@"注册失败" message:@"邮箱已被占用" button:1 done:nil];
            }
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self registAction:nil];
    return YES;
}

@end
