//
//  ServiceAccessData.m
//  RSSReader
//
//  Created by Marko Savic on 5/17/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import "ServiceAccessData.h"

#define BBC_NEWS_FEED @"http://feeds.bbci.co.uk/news/rss.xml"

@implementation ServiceAccessData

+ (NSURL *) getBBCNewsURL
{
    return [NSURL URLWithString:BBC_NEWS_FEED];
}

@end
