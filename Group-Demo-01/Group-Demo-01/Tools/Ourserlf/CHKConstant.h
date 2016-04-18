//
//  CHKConstant.h
//  Practise
//
//  Created by qianfeng on 16/3/10.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#ifndef Practise_CHKConstant_h
#define Practise_CHKConstant_h

/*************************************颜色**********************************/
/**RGB颜色*/
#define UIColorRGB(_r,_g,_b) [UIColor colorWithRed:_r/255.f green:_g/255.f blue:_b/255.f alpha:1.f]

/**White*/
#define UIColorWhite(white) [UIColor colorWithWhite:white alpha:1]

/**随机色*/
#define ArcCOLOR [UIColor colorWithRed:arc4random()%256/255.f green:arc4random()%256/255.f blue:arc4random()%256/255.f alpha:1]
/***********************************字体、大小、位置*************************/
/**设置字体大小*/
#define FONT(_s) [UIFont systemFontOfSize:_s]
/**FRAME*/
#define RECT(_x,_y,_w,_h) CGRectMake(_x, _y, _w, _h)
/**SIZE*/
#define SIZE(_w,_h) CGSizeMake(_w, _h)
/**屏幕宽*/
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
/**屏幕高*/
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
/**导航栏高度*/
#define NavigationBar_HEIGHT 44

/***********************************系统****************************/
/**获取当前系统版本号*/
#define iOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/**********************************图片********************************/
/**读取本地图片带类型*/
#define LOAD_IMAGE(life,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]]
/**读取本地图片不带类型*/
#define IMAGE(A) LOAD_IMAGE(A, nil)
/**根据图片名字读取本地图片*/
#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]







#endif
