//
//  Util.m
//  FaceBump
//
//  Created by Alan Wagner on 7/22/12.
//  Copyright (c) 2012 Massachusetts Institute of Technology. All rights reserved.
//

#import "Util.h"

@implementation Util

- (void) writeToPList:(NSString *)ID 
{
    NSString *error;
    
    NSString *rootPath = 
    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"data.plist"];
    
    NSDictionary *plistDict = 
    [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: ID, nil] 
                                forKeys:[NSArray arrayWithObjects: @"id", nil]];
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict 
                                                                   format:NSPropertyListXMLFormat_v1_0 
                                                         errorDescription:&error];
    
    if (plistData) 
    {
        [plistData writeToFile:plistPath atomically:YES];
    } 
    else 
    {
        NSLog(@"%@", error);
    }
}

- (NSString *) readFromPList 
{
    NSString *errorDesc = nil;
    
    NSPropertyListFormat format;
    
    NSString *plistPath;
    NSString *rootPath = 
    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) 
     objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"data.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) 
    {
        plistPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temp) 
    {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    
    return[temp objectForKey:@"id"];
}

@end
