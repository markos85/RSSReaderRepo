//
//  RSSFeedProtocol.h
//  RSSReader
//
//  Created by Marko Savic on 5/20/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

@protocol RSSFeedProtocol <NSObject>

@required

- (void) rssFeedListUpdated : (NSArray *) rssFeedList;
- (void) rssFeedListError : (NSError *) error;

@end