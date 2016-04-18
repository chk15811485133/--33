//
//  CHKTabBarController.h
//  kitchen
//
//  Created by qianfeng on 16/3/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHKTabBarController : UITabBarController

/**添加item传入标题、类名、图标、高亮图标*/
- (void)addItemsTitle:(NSArray *)titles ClassName:(NSArray *)classes images:(NSArray *)images highLight:(NSArray *)highLight;

@end
