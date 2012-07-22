//
//  Util.h
//  FaceBump
//
//  Created by Alan Wagner on 7/22/12.
//  Copyright (c) 2012 Massachusetts Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Util : NSObject

- (void) writeToPList:(NSString *)ID;
- (NSString *) readFromPList;

@end
