//
//  RootViewController.m
//  OCTabTabBar
//
//  Created by hhuc on 2019/1/20.
//  Copyright © 2019 hhuc. All rights reserved.
//

#import "RootViewController.h"

#import "HomeViewController.h"
#import "MineViewController.h"

@interface RootViewController ()<UITabBarDelegate, UITabBarControllerDelegate>

@property (nonatomic)NSDate *lastDate;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupUI];
}

- (void)setupUI
{
    self.tabBarController.delegate = self;
    self.delegate = self;
    
    UINavigationController *homeNV = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    UINavigationController *mineNV = [[UINavigationController alloc] initWithRootViewController:[[MineViewController alloc] init]];
    
    self.viewControllers = @[homeNV,mineNV];//promoteNav
    
    homeNV.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"home" image:nil selectedImage:nil ];
    mineNV.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"mine" image:nil selectedImage:nil];
}

////UITabBarController代理方法
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//
//    if([((UINavigationController *)viewController).visibleViewController isKindOfClass:[HomeViewController class]]){
//
//        //当tabBar被点击时发出一个通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:tapNotification object:nil userInfo:nil];
//
//    }
//}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0)
{
    UIViewController * vc = tabBarController.selectedViewController;
    NSDate *date = [NSDate date];
    
    if (vc == viewController)
    {
        if (tabBarController.selectedIndex == 0)
        {
            
            if (date.timeIntervalSince1970 - self.lastDate.timeIntervalSince1970 <= 8.5)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:tapNotification object:nil userInfo:nil];
                
                //            switch tabBarController.selectedIndex {
                //
                //                  case 0:                    (vc as! ViewController).tableView?.mj_header.beginRefreshing()
                //                case 1:                    (vc as! AViewController).tableView?.mj_header.beginRefreshing()                default:                    (vc as! BViewController).tableView?.mj_header.beginRefreshing()                }                //如果双击，就将lastDate置成一个较小的值，防止多次重复点击造成的方法重复调用
                //

                self.lastDate = [NSDate dateWithTimeIntervalSinceReferenceDate:1000];
            }
            else
            {
                //如果不是双击，记录最后一次点击时间
                self.lastDate = date;
            }
        }
        
        return false;
    }
    else
    {
        //如果换了按钮点击，记录下最后一次点击时间
        self.lastDate = date;
        
    }        return true;
}


@end
