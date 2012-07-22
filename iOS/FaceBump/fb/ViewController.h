//
//  ViewController.h
//  FaceBump
//
//  Created by Alan Wagner, Michelle Luo, Jennifer Fang, Daniel Gur on 7/21/12.
//  Copyright (c) Bumpathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController 

- (void) didBumpWithFriendId:(NSString *)friendId;
- (void) tryAgain;
- (void) showBump;
- (void) connectToFB;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *againPrompt;
@property (weak, nonatomic) IBOutlet UILabel *bumpText;
@property (weak, nonatomic) IBOutlet UILabel *connectText;

@end
