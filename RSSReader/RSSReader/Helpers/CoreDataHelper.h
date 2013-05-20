//
//  CoreDataHelper.h
//  RSSReader
//
//  Created by Marko Savic on 5/20/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataHelper : NSObject

- (void) deleteAllObjects : (NSString *) entityDescription;
- (NSArray *) getAllObjects : (NSString *) entityDescription;
- (NSManagedObjectContext *) managedObjectContext;
+ (CoreDataHelper *)sharedInstance;

@end
