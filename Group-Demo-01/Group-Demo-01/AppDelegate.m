//
//  AppDelegate.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/1.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "CHKTabBarController.h"
#import <BmobSDK/Bmob.h>
#import "LHCLoginViewController.h"



#import "UMSocial.h"

@interface AppDelegate ()

- (void)createWindow;//实例化窗口

- (void)addRootViewController;//添加跟视图

- (NSArray *)createTabBarItem;//tabBarItem元素定制

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //初始化友盟
    [self createUment];
    
    //初始化环信SDK
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"6666664765464#lizejiahaoyuecuihongkai" apnsCertName:@"ease"];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    
    /**向APNS服务器注册*/
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
    
    HaoYue *haoyue = [HaoYue sharedUser];
    NSUserDefaults *people = [NSUserDefaults standardUserDefaults];
    haoyue.username = [people objectForKey:@"username"];
    haoyue.password = [people objectForKey:@"password"];
    
    [Bmob registerWithAppKey:@"4a10b9fcd993ded9feee67e42ec42b50"];
    [self createWindow];
    
    [self addRootViewController];
    
    return YES;
}

- (void)createUment {
    
    //初始化友盟社会化组件
    [UMSocialData setAppKey:UMENG_APPKEY];
    
    //    //隐藏未安装客户端的平台
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
}

/**注册成功后将deviceToken传给环信SDK*/
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
    NSLog(@"error -- %@",error);
}

//获得远程推送消息
-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    //相关业务处理
    NSLog(@"%@",userInfo);
    NSInteger num = [UIApplication sharedApplication].applicationIconBadgeNumber;
    [UIApplication sharedApplication].applicationIconBadgeNumber = num-1>0?(num-1):0;
}

//app进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}
//app将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}
//申请处理时间
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

/**实例化窗口*/
- (void)createWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
}
/**添加跟视图*/
- (void)addRootViewController {
   
    CHKTabBarController *tab = [self createTabBarController];
    
    LHCLoginViewController *login = [[LHCLoginViewController alloc] init];
    
    if ([HaoYue sharedUser].username.length > 0) {
        self.window.rootViewController = tab;
        EMError *error = nil;
        NSDictionary *loginInfo = [[EaseMob sharedInstance].chatManager loginWithUsername:[HaoYue sharedUser].username password:[HaoYue sharedUser].password error:&error];
        
        if (!error && loginInfo ) {
            NSLog(@"登陆成功");
        }
            
    } else {
        self.window.rootViewController = login;
    }
}

/**实例化tab*/
- (CHKTabBarController *)createTabBarController {
    NSArray *arr = [self createTabBarItem];
    
    CHKTabBarController *tab = [[CHKTabBarController alloc] init];
    
    [tab addItemsTitle:arr[3] ClassName:arr[0] images:arr[1] highLight:arr[2]];
    
    return tab;
}

/**tabBarItem元素定制*/
- (NSArray *)createTabBarItem {
    NSArray *classNames = @[@"LHCOneViewController",@"LHCTwoViewController",@"LHCThreeViewController",@"LHCFourViewController"];
    
    NSArray *images = @[@"tab_friends@2x",@"tab_me@2x",@"tab_search@2x",@"tab_star@2x"];
    
    NSArray *highLight = @[@"tab_friends_on@2x",@"tab_me_on@2x",@"tab_search_on@2x",@"tab_star_on@2x"];
    
    NSArray *titles = @[@"美景",@"娱乐",@"聊天",@"我"];
    
    return @[classNames,images,highLight,titles];
}

+ (void)updateRootViewController{
    
    AppDelegate * delegate =(AppDelegate*) [UIApplication sharedApplication].delegate;
    
    /**实例化tab*/
    CHKTabBarController *tab = [delegate createTabBarController];
    
    delegate.window.rootViewController = tab;
    //刷新内容
    [delegate.window reloadInputViews];
    
}

@end