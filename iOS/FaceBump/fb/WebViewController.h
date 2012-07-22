//
//  WebViewController.h
//  FBump
//
//  Created by Michelle Luo on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@class WebViewController;

@protocol WebViewControllerDelegate
- (void)webViewControllerDidFinish:(WebViewController *)controller;
@end

@interface WebViewController : UIViewController

@property (weak, nonatomic) IBOutlet id <WebViewControllerDelegate> delegate;

@property (strong, nonatomic) NSString *friendId;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)returnToMain:(id)sender;

@end
