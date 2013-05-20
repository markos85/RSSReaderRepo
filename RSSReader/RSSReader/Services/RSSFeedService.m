//
//  RSSFeedService.m
//  RSSReader
//
//  Created by Marko Savic on 5/17/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import "RSSFeedService.h"
#import "ServiceAccessData.h"
#import "RSSFeed.h"
#import "TBXMLParser.h"
#import "CoreDataHelper.h"

@interface RSSFeedService ()

@end

@implementation RSSFeedService

#pragma mark - Public methods

- (void) getBBCNews
{
    [self sendRequestWithUrl:[ServiceAccessData getBBCNewsURL]];
}

- (void) processResponseSucceed:(NSData *)responseData
{
    NSManagedObjectContext *context = [[CoreDataHelper sharedInstance] managedObjectContext];
    
    [[CoreDataHelper sharedInstance] deleteAllObjects:ENTITY_FEED_NAME];
    
    [TBXMLParser parseAndStoreRSSFeeds:responseData inContext:[[CoreDataHelper sharedInstance] managedObjectContext]];

    NSError *error = nil;
    
    if (![context save:&error])
    {
        NSLog(@"Can't Save! %@ %@", error, [[CoreDataHelper sharedInstance] managedObjectContext]);
    }
    else
    {
        [self.delegate rssFeedListUpdated:[[CoreDataHelper sharedInstance] getAllObjects:ENTITY_FEED_NAME]];
    }
}

- (void) processResponseError:(NSError *)errorDescription
{
    [self.delegate rssFeedListError:errorDescription];
}

@end
