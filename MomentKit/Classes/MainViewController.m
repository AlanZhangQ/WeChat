//
//  MainViewController.m
//  MomentKit
//
//  Created by Alan on 2018/07/12.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "MainViewController.h"
#import "DiscoverViewController.h"
#import "DiscoverViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.layer.borderWidth = 0.5;
    self.tabBar.layer.borderColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0].CGColor;
    self.tabBar.tintColor = [UIColor colorWithRed:14.0/255.0 green:178.0/255.0 blue:10.0/255.0 alpha:1.0];

    NSArray *titles = @[@"微信",@"通讯录",@"发现",@"我"];
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i ++) {
        // 图片
        UIImage *comImage = [[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%d",i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *comImageH = [[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_hl_%d",i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 项
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titles[i] image:comImage selectedImage:comImageH];
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:10.0]} forState:UIControlStateNormal];
        // 控制器
        DiscoverViewController *controller = [[DiscoverViewController alloc] init];
        controller.vcType = i;
        controller.title = [titles objectAtIndex:i];
        controller.tabBarItem = item;
        // 导航
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        navController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:19.0]};
        [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigaitonbar"] forBarMetrics:UIBarMetricsDefault];
        navController.navigationBar.tintColor = [UIColor whiteColor];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        navController.navigationBar.translucent = NO;
        [viewControllers addObject:navController];
    }
    self.viewControllers = viewControllers;
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
