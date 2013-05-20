//
//  NSArray+Tools.h
//  RSSReader
//
//  Created by Marko Savic on 5/20/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Tools)

+ (void) sortDateArray : (NSMutableArray *) dateArray withName : (NSString *) propertyName;

@end
