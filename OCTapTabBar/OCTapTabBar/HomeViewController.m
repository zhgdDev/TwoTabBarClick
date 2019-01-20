//
//  HomeViewController.m
//  OCTabTabBar
//
//  Created by hhuc on 2019/1/20.
//  Copyright © 2019 hhuc. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic) NSInteger lastSelectedIndex;

@end

@implementation HomeViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:tapNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"home";
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.lastSelectedIndex = NSIntegerMax;
    
    
    //注册接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:tapNotification object:nil];
}


- (void)loadData
{
    NSLog(@"lastSelectedIndex %d",self.lastSelectedIndex);

    // 如果是连续选中2次, 直接刷新
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && [self isShowingOnKeyWindow])
    {
        
        NSLog(@"我正在刷新数据");
    }
    // 记录这一次选中的索引
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
    NSLog(@"lastSelectedIndex %d",self.lastSelectedIndex);

}

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.view.frame fromView:self.view.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.view.isHidden && self.view.alpha > 0.01 && self.view.window == keyWindow && intersects;
}




@end
