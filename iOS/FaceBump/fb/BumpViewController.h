//
//  BumpViewController.h
//  FBump
//
//  Created by Michelle Luo on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BumpViewController;

@protocol BumpViewControllerDelegate
- (void)bumpViewControllerDidFinish:(BumpViewController *)controller;
@end

@interface BumpViewController : UIViewController

@property (weak, nonatomic) IBOutlet id <BumpViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (void)didBumpWithFriendId:(NSString *)friendId;

- (IBAction)testBump:(id)sender;

@end
