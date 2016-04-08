//
//  CNavigationController.m
//  CNavigationController
//
//  Created by macairwkcao on 16/4/8.
//  Copyright © 2016年 CWK. All rights reserved.
//

#import "CNavigationController.h"
#import "UINavigationController+CBackGesture.h"


@interface CNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation CNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setEnableBackGesture:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
