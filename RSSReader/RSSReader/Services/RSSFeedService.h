//
//  RSSFeedService.h
//  RSSReader
//
//  Created by Marko Savic on 5/17/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSReaderService.h"
#import "RSSFeedProtocol.h"

@interface RSSFeedService : RSSReaderService

@property (strong, nonatomic) id<RSSFeedProtocol> delegate;

- (void) getBBCNews;

@end
