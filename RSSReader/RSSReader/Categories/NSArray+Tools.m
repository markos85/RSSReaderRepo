//
//  NSArray+Tools.m
//  RSSReader
//
//  Created by Marko Savic on 5/20/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import "NSArray+Tools.h"

@implementation NSArray (Tools)

+ (void) sortDateArray : (NSMutableArray *) dateArray withName : (NSString *) propertyName
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:propertyName ascending:FALSE];
    [dateArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

@end