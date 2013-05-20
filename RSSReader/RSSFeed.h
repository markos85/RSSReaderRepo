//
//  RSSFeed.h
//  RSSReader
//
//  Created by Marko Savic on 5/17/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define ENTITY_FEED_NAME     @"RSSFeed"

@interface RSSFeed : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * pubDate;
@property (nonatomic, retain) NSString * thumbnailLarge;
@property (nonatomic, retain) NSString * thumbnailSmall;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * guid;

@end
