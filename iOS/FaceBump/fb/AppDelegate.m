//
//  AppDelegate.m
//  FaceBump
//
//  Created by Alan Wagner, Michelle Luo, Jennifer Fang, Daniel Gur on 7/21/12.
//  Copyright (c) Bumpathon. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BumpClient.h"
#import "Util.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize facebook;
@synthesize util;

- (void) configureBump 
{
    // userID is a string that you could use as the user's name,
    // or an ID that is semantic within your environment
    [BumpClient configureWithAPIKey:@"dfca7e34d43c4c9dbfb30e13724f2e18" 
                          andUserID:[[UIDevice currentDevice] name]];
    
    [[BumpClient sharedClient] setMatchBlock:^(BumpChannelID channel) 
    { 
        NSLog(@"Matched with user: %@", 
              [[BumpClient sharedClient] userIDForChannel:channel]);
        
        [[BumpClient sharedClient] confirmMatch:YES onChannel:channel];
    }];
    
    [[BumpClient sharedClient] setChannelConfirmedBlock:^(BumpChannelID channel) 
    {
        NSLog(@"Channel with %@ confirmed.",
              [[BumpClient sharedClient] userIDForChannel:channel]);
        
        [[BumpClient sharedClient] sendData:
         [[NSString stringWithFormat:[self.util readFromPList]] 
          dataUsingEncoding:NSUTF8StringEncoding] toChannel:channel];
    }];
    
    [[BumpClient sharedClient] setDataReceivedBlock:^(BumpChannelID channel, NSData *data) 
    {
        NSString *bumpData = [NSString stringWithCString:[data bytes] 
                                                encoding:NSUTF8StringEncoding];
        
        NSLog(@"Data received from %@: %@", 
              [[BumpClient sharedClient] userIDForChannel:channel], 
              bumpData);
        
        ViewController *viewController = 
        (ViewController *)self.window.rootViewController;
        
        [viewController didBumpWithFriendId:bumpData];        
    }];
    
    
    // optional callback
    [[BumpClient sharedClient] setConnectionStateChangedBlock:^(BOOL connected) 
    {
        if (connected) 
        {
            NSLog(@"Bump connected...");
            [(ViewController *)self.window.rootViewController showBump];
        } 
        else 
        {
            NSLog(@"Bump disconnected...");
        }
    }];
    
    // optional callback
    [[BumpClient sharedClient] setBumpEventBlock:^(bump_event event) 
    {
        switch(event) 
        {
            case BUMP_EVENT_BUMP:
                NSLog(@"Bump detected.");
                break;
            case BUMP_EVENT_NO_MATCH:
                NSLog(@"No match.");
                [(ViewController *)self.window.rootViewController tryAgain];
                break;
        }
    }];
} 

- (BOOL)application:(UIApplication *)application 
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.util = [Util alloc];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
        
    facebook = [[Facebook alloc] initWithAppId:@"449201188434000" andDelegate:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) 
    {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    if (![facebook isSessionValid]) 
    {
        [facebook authorize:nil];
    }
    
    [self configureBump];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url 
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation 
{
    return [facebook handleOpenURL:url]; 
}

- (void)fbDidLogin 
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [self getFacebookName];
}

- (void)fbDidNotLogin:(BOOL)cancelled 
{
    [(ViewController *)self.window.rootViewController connectToFB];
}

- (void)fbDidLogout
{
    [(ViewController *)self.window.rootViewController connectToFB];
}

- (void)fbSessionInvalidated
{
    [(ViewController *)self.window.rootViewController connectToFB];
}

- (void) getFacebookName 
{
    [facebook requestWithGraphPath:@"me?fields=id" andDelegate:self];  
}

- (void)request:(FBRequest *)request didLoad:(id)result 
{
    NSLog(@"Result: %@", result);
    
    NSDictionary *userInfo = (NSDictionary *)result;
    NSString *userID = [userInfo objectForKey:@"id"];
    
    NSLog(@"%@", userID);
    
    [self.util writeToPList:userID];
}

- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt
{
    // do nothing
}

@end
