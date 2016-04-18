//
//  CHKTabBarController.m
//  kitchen
//
//  Created by qianfeng on 16/3/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CHKTabBarController.h"

#import "UIImage+LHCOriginalImage.h"

@interface CHKTabBarController ()

@end

@implementation CHKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**传入tabBarItem标题、类名、图标、高亮图标*/
- (void)addItemsTitle:(NSArray *)titles ClassName:(NSArray *)classes images:(NSArray *)images highLight:(NSArray *)highLight {
    
    Class class = nil;
    for (int i = 0; i<classes.count; i++) {
        class = NSClassFromString(classes[i]);
        
        UIViewController *vc = [[class alloc] init];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        vc.title = titles[i];
        //定制分类元素
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:titles[i] image:[[UIImage imageNamed:images[i]] originalImage] selectedImage:[[UIImage imageNamed:highLight[i]] originalImage]];

        [self addChildViewController:nav];
    }
}




@end
