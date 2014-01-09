//
//  NXDataModel.h
//  board-mobile
//
//  Created by KIMJOOHWEE on 2013. 12. 4..
//  Copyright (c) 2013년 KIMJOOHWEE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXDataModel : NSObject <NSURLConnectionDataDelegate>

@property UITableViewController *aController;
-(void)saveId:(NSString*)userId
withPassword:(NSString*)password;

-(NSDictionary*)objectAtIndex:
    (NSUInteger)index;

-(NSUInteger)ArrayLengthCount;

-(BOOL)authenticateID:(NSString*)userid
         withPassword:(NSString*)password;

-(void)newPostTitle:(NSString*)title withContent:(NSString*)content withImage:(UIImage*)image withImageTitle:(NSString*)imagetitle;


@end
