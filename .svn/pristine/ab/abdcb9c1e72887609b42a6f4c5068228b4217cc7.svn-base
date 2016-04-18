//
//  LHCFooterSecondTableViewCell.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCFooterSecondTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface LHCFooterSecondTableViewCell () <NSXMLParserDelegate>

/**用户展示的图片*/
@property (nonatomic,strong) UIImageView *image;

/**用户发表的文本*/
@property (nonatomic,strong) UILabel *labelDigest;


@end

@implementation LHCFooterSecondTableViewCell {
    NSString *tmp;
    UIImage *img;
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    _image = nil;
    _labelDigest = nil;
    
    //得到图片
    [self.image sd_setImageWithURL:[NSURL URLWithString:dataDic[@"image"]]];
    
    img = self.image.image;
    
    /**根据请求到的图片大小修改imageView大小*/
    float width = self.image.image.size.width;
    
    self.image.height = self.image.width / width * self.image.image.size.height;
    [self.contentView addSubview:self.image];
    
    [self.contentView addSubview:self.labelDigest];
    NSString *digest = dataDic[@"digest"];
    //判断文本是否存在
    if (digest.length != 0) {
        [self aboutLabelDigest:digest];
    }
    //自定制cell高
    self.cellHeight = self.image.height + self.labelDigest.height;
}

/**实例化一个长按手势*/
- (UILongPressGestureRecognizer *)createLongPressGestureRecognizer {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    //长按时常
    longPress.minimumPressDuration = 1;
    
    return longPress;
}
/**手势触发事件*/
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    __weak typeof(self) weakSelf = self;
    if (longPress.state == UIGestureRecognizerStateBegan) {
        weakSelf.myblock(img);
    }
}

/**对数据进行XML解析*/
- (void)aboutLabelDigest:(NSString *)digest {
    
    //将字符串转换成二进制数据
    NSData *date = [digest dataUsingEncoding:NSUTF8StringEncoding];
    //通过一段二进制数据实例化xml对象
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:date];
    //设置代理
    parser.delegate =self;
    
    //开始解析
    [parser parse];
}

#pragma mark ------------XML协议方法------------
//找到节点间的字符串
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    tmp = string;
    NSLog(@"%@",string);
}
/**找到尾节点*/
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"p"]) {
        //将数据展示到label上
        self.labelDigest.text = tmp;
        
        CGFloat height = [tmp boundingRectWithSize:CGSizeMake(self.labelDigest.width, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT(18)} context:nil].size.height;
        
        self.labelDigest.height = height;
    }
}

#pragma mark------------懒加载-----------
- (UIImageView *)image {
    if (_image == nil) {
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
      
        _image.userInteractionEnabled = YES;
        /**给图片添加一个长按手势*/
        [_image addGestureRecognizer:[self createLongPressGestureRecognizer]];
    }
    return _image;
}

- (UILabel *)labelDigest {
    if (_labelDigest == nil) {
        _labelDigest = [[UILabel alloc] initWithFrame:CGRectMake(10, self.image.maxY, self.image.width-20, 0)];
        
        _labelDigest.numberOfLines = 0;
        
//        _labelDigest.backgroundColor = [UIColor yellowColor];
        
    }
    return _labelDigest;
}


@end
