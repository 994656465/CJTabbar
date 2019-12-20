//
//  CJTabbar.m
//  CJTabbar
//
//  Created by dd luo on 2019/12/19.
//  Copyright © 2019 dd luo. All rights reserved.
//

#import "CJTabbar.h"
#define CJRandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//iPhoneXR / iPhoneXSMax
#define  isIphoneXR_XSMax    (YWWidth == 414.f && YWHeight == 896.f ? YES : NO)
//iPhoneX / iPhoneXS
#define   isIphoneX_XS     (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)
// iPhone XR
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

//异性全面屏
#define   isFULLSCREEN   (isIphoneX_XS || isIphoneXR_XSMax || IS_IPHONE_Xr )

#define videoCellHight           40+YWWidth/16*9.0
#define defaultImageVideoHight   YWWidth/16*9.0
#define STATUSHEIGHT       ((isFULLSCREEN)?44.0f:20.0f)
#define NAVBARHEIGHT       ((isFULLSCREEN)?88.0f:64.0f)
#define TABBARHEIGHT       ((isFULLSCREEN)?83.0f:49.0f)
#define TABBARSAFEAREAHEIGHT  ((isFULLSCREEN)?34.0f:0.0f)


@interface CJTabbar ()
@property(nonatomic,strong) UIButton * centerButton ;

@end
@implementation CJTabbar



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatCenterButton];
    }
    return self;
}

-(void)creatCenterButton{
    
    UIButton * centerButton = [UIButton buttonWithType:0];
    self.centerButton = centerButton;
    [centerButton addTarget:self action:@selector(centerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [centerButton setImage:[UIImage imageNamed:@"money"] forState:UIControlStateNormal];
    [self addSubview:centerButton];
    
}

-(void)centerButtonClick:(UIButton * )button{
    if (self.centerButtonClickEvent) {
        self.centerButtonClickEvent();
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonW = self.bounds.size.width / 5;
    NSInteger index = 0;
    for (NSInteger i = 0;  i < self.subviews.count; i++) {
        NSLog(@"i=%zd",i);
            UIView * tabbarButton = self.subviews[i];
            if ([tabbarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                NSLog(@"index = %zd",index);

                if (index == 2) {
                       index++;
                }
                tabbarButton.frame = CGRectMake(index*buttonW, 0, buttonW, 49);
                index++;
            }
        
    }
    self.centerButton.frame =  CGRectMake(2*buttonW, -20, buttonW, 49);

    
}



//hitTest的底层实现：
//
//    1.先看自己是否能接受触摸事件
//    2.再看触摸点是否在自己身上
//    3.从后往前遍历子控件，拿到子控件后，再次重复1，2步骤，要把父控件上的坐标点转换为子控件坐标系下的点，再次执行hitTest方法
//    4.若是最后还没有找到合适的view，那么就return self，自己就是合适的view
//
//备注:当控件接收到触摸事件的时候，不管能不能处理事件，都会调用hitTest方法

//  处理凸出部分点击事件不响应的问题
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    CGPoint tempPoint = [self convertPoint:point toView:self.centerButton];
    if ([self.centerButton pointInside:tempPoint withEvent:event]) {
        return self.centerButton;
    }else{
        return [super hitTest:point withEvent:event];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
