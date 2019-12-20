//
//  CJTabbarController.m
//  CJTabbar
//
//  Created by dd luo on 2019/12/19.
//  Copyright © 2019 dd luo. All rights reserved.
//

#import "CJTabbarController.h"
#import "CJTabbar.h"
#define CJRandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
@interface CJTabbarController ()
@property (nonatomic, assign) NSInteger  itemSelectIndex;
@end

@implementation CJTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CJTabbar * tabbar = [[CJTabbar alloc]init];
    [self setValue:tabbar forKey:@"tabBar"];
    [self creatTabbar];
    
  __weak  typeof(self)  weakself= self;
    tabbar.centerButtonClickEvent = ^{
        [weakself didClickCenterButton];
    };
    
    // Do any additional setup after loading the view.
}
-(void)creatTabbar{
    

    NSArray * controllers = @[@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController"];
    NSArray * titles = @[@"首页",@"二页",@"三页",@"四页"];
    NSArray * normalImages = @[@"home_normal",@"start_normal",@"play_normal",@"pause_normal"];
    NSArray * selectImage = @[@"home_select",@"start_select",@"play_select",@"pause_select"];
    [self creatChildControllerWithControllers:controllers andTiles:titles NormalImages:normalImages andSelectImages:selectImage];

}
-(void)creatChildControllerWithControllers:(NSArray * )controllers andTiles:(NSArray * )titles NormalImages:(NSArray * )normalImages andSelectImages:(NSArray *)selectImages{
    self.itemSelectIndex =  0;
    NSMutableArray * navArr = [NSMutableArray array];
    for (NSInteger i = 0 ; i < controllers.count; i++) {
        Class  vcClass = NSClassFromString(controllers[i]);
        
        UIViewController * vc = [[vcClass alloc]init];
        vc.title = titles[i];
        vc.view.backgroundColor = CJRandomColor;
        vc.tabBarItem.image = [[UIImage imageNamed:normalImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSMutableDictionary *md = [NSMutableDictionary dictionary];
        md[NSFontAttributeName] =[UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
        md[NSForegroundColorAttributeName] =RGB(96, 96, 96);
        [vc.tabBarItem setTitleTextAttributes:md forState:UIControlStateNormal];
        // 设置高亮状态文字的颜色
        NSMutableDictionary *higMd = [NSMutableDictionary dictionary];
        higMd[NSForegroundColorAttributeName] = [UIColor blueColor];
        higMd[NSFontAttributeName] =[UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
        [vc.tabBarItem setTitleTextAttributes:higMd forState:UIControlStateSelected];
        UINavigationController * navVC = [[UINavigationController alloc]initWithRootViewController:vc];
        [navArr addObject:navVC];
        
    }
    self.viewControllers = navArr;
 
    
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
        NSInteger index = [self.tabBar.items indexOfObject:item];
         if (index != self.itemSelectIndex) {
               //获取按钮
               NSMutableArray *arry = [NSMutableArray array];
               for (UIView *btn in self.tabBar.subviews) {
                   if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                        [arry addObject:btn];
                   }
               }
                //添加动画
                 //放大效果
                 CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                 //速度控制函数，控制动画运行的节奏
                 animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                 animation.duration = 0.2;       //执行时间
                 animation.repeatCount = 1;      //执行次数
                 animation.removedOnCompletion = NO;
                 animation.fillMode = kCAFillModeForwards;           //保证动画效果延续
                 animation.fromValue = [NSNumber numberWithFloat:1.0];   //初始伸缩倍数
                 animation.toValue = [NSNumber numberWithFloat:1.15];     //结束伸缩倍数
                 [[arry[index] layer] addAnimation:animation forKey:nil];
                 //移除其他tabbar的动画
                 for (int i = 0; i<arry.count; i++) {
                     if (i != index) {
                         [[arry[i] layer] removeAllAnimations];
                     }
                 }
                 self.itemSelectIndex = index;
             }

}
-(void)didClickCenterButton{
    NSLog(@"didClickCenterButton");
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
