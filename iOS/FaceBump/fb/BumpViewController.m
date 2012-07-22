//
//  BumpViewController.m
//  FBump
//
//  Created by Michelle Luo on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BumpViewController.h"
#import "BumpClient.h"

@implementation BumpViewController

@synthesize delegate = _delegate;
@synthesize webView = _webView;

- (IBAction)testBump:(id)sender
{
    [self didBumpWithFriendId:@"fang.jenn"];
}

- (void) didBumpWithFriendId:(NSString *)friendId
{
    //NSString *friendId = self.friendId; //@"fang.jenn";
    
    NSString *urlAddress = [NSString stringWithFormat:@"fb://profile/%@", friendId];
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [self.webView loadRequest:requestObj];
    
    [self.delegate bumpViewControllerDidFinish:self];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
