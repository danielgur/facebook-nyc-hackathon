//
//  ViewController.m
//  FaceBump
//
//  Created by Alan Wagner, Michelle Luo, Jennifer Fang, Daniel Gur on 7/21/12.
//  Copyright (c) Bumpathon. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize webView = _webView;
@synthesize againPrompt = _againPrompt;
@synthesize bumpText = _bumpText;
@synthesize connectText = _connectText;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.againPrompt setAlpha:0];
    [self.bumpText setAlpha:0];
    [self.connectText setAlpha:0];
}

- (void) didBumpWithFriendId:(NSString *)friendId
{    
    NSString *urlAddress = [NSString stringWithFormat:@"fb://profile/%@", friendId];
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [self.webView loadRequest:requestObj];
}

- (void) tryAgain
{
    [self.againPrompt setAlpha:1];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:4];
    [self.againPrompt setAlpha:0];
    [UIView commitAnimations];
}

- (void) showBump
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [self.bumpText setAlpha:1];
    [UIView commitAnimations];
}

- (void) connectToFB
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:4];
    [self.connectText setAlpha:1];
    [UIView commitAnimations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return FALSE;
}

@end
