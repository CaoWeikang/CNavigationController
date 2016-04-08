//
//  UINavigationController+CBackGesture.m
//  CNavigationController
//
//  Created by macairwkcao on 16/4/8.
//  Copyright © 2016年 CWK. All rights reserved.
//

#import "UINavigationController+CBackGesture.h"
#import <objc/runtime.h>

static const char *associatedKeyPanGesture = "__associated_key_pangesture";
static const char *associatedKeyEnableGesture = "__associated_key_enablegesture";

@interface UINavigationController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation UINavigationController (CBackGesture)

-(BOOL)enableBackGesture{
    NSNumber *enableGesture = objc_getAssociatedObject(self, associatedKeyEnableGesture);
    if (enableGesture) {
        return [enableGesture boolValue];
    }
    return NO;
}

-(void)setEnableBackGesture:(BOOL)enableBackGesture{
    NSNumber *enableGestureNum = @(enableBackGesture);
    objc_setAssociatedObject(self, associatedKeyEnableGesture, enableGestureNum, OBJC_ASSOCIATION_RETAIN);
    if (enableBackGesture) {
        [self.view addGestureRecognizer:[self panGestureRecognizer]];
    } else {
        [self.view removeGestureRecognizer:[self panGestureRecognizer]];
    }
}

-(UIPanGestureRecognizer *)panGestureRecognizer{
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, associatedKeyPanGesture);
    if (!panGestureRecognizer) {
        id target = self.interactivePopGestureRecognizer.delegate;
        panGestureRecognizer=[[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];
        [panGestureRecognizer setDelegate:self];
        self.interactivePopGestureRecognizer.enabled = NO;
        objc_setAssociatedObject(self, associatedKeyPanGesture, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN);
    }
    return panGestureRecognizer;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.childViewControllers.count <= 1) {
        return NO;
    }
    return YES;
}

@end
