//
//  TBXMLParser.m
//  RSSReader
//
//  Created by Marko Savic on 5/20/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import "TBXMLParser.h"
#import "TBXML.h"
#import "RSSFeed.h"
#import "NSDate+Utils.h"

#define CHANNEL  @"channel"
#define ITEM     @"item"
#define TITLE    @"title"
#define MEDIA    @"media:thumbnail"
#define LINK     @"link"
#define URL      @"url"
#define DATE     @"pubDate"

@implementation TBXMLParser

+ (void) parseAndStoreRSSFeeds : (NSData *) xmlData inContext : (NSManagedObjectContext *) context
{
    TBXML * tbxml = [[TBXML alloc] initWithXMLData:xmlData];
    TBXMLElement *root = tbxml.rootXMLElement;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (root)
    {
        TBXMLElement * channel = [TBXML childElementNamed:CHANNEL parentElement:root];
        if (channel)
        {
            TBXMLElement *item = [TBXML childElementNamed:ITEM parentElement:channel];
            while (item != nil)
            {
                RSSFeed *RSSFeedEntry = [NSEntityDescription
                                         insertNewObjectForEntityForName:ENTITY_FEED_NAME
                                         inManagedObjectContext:context];
                
                TBXMLElement *title = [TBXML childElementNamed:TITLE parentElement:item];
                if (title != nil)
                {
                    RSSFeedEntry.title = [TBXML textForElement:title];
                }
                TBXMLElement *link = [TBXML childElementNamed:LINK parentElement:item];
                if (link != nil)
                {
                    RSSFeedEntry.link = [TBXML textForElement:link];
                }
                TBXMLElement *smallImage = [TBXML childElementNamed:MEDIA parentElement:item];
                if (smallImage != nil)
                {
                    RSSFeedEntry.thumbnailSmall = [TBXML valueOfAttributeNamed:URL forElement:smallImage];
                }
                TBXMLElement *largeImage = [TBXML nextSiblingNamed:MEDIA searchFromElement:smallImage];
                if (largeImage != nil)
                {
                    RSSFeedEntry.thumbnailLarge = [TBXML valueOfAttributeNamed:URL forElement:largeImage];
                }
                TBXMLElement *releaseDate = [TBXML childElementNamed:DATE parentElement:item];
                if (releaseDate != nil)
                {
                    NSString *date = [TBXML textForElement:releaseDate];
                    RSSFeedEntry.pubDate = [NSDate convertFromServerUTCStringToLocalTime:date];
                }
                
                
                item = [TBXML nextSiblingNamed:ITEM searchFromElement:item];
            }
        }
    }

}

@end
