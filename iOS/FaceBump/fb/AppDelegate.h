//
//  AppDelegate.h
//  FaceBump
//
//  Created by Alan Wagner, Michelle Luo, Jennifer Fang, Daniel Gur on 7/21/12.
//  Copyright (c) Bumpathon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "Util.h"

@interface AppDelegate : UIResponder 
<UIApplicationDelegate, FBSessionDelegate, FBRequestDelegate> {
    Facebook *facebook;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;
@property (nonatomic, retain) Facebook *facebook;
@property (strong, nonatomic) Util *util;

@end
