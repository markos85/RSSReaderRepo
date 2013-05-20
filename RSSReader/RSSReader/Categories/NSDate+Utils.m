//
//  NSDate+Utils.m
//  RSSReader
//
//  Created by Marko Savic on 5/20/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)

+ (NSDate *) convertFromServerUTCStringToLocalTime : (NSString *) utcTime
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [fmt setLocale:enUSPOSIXLocale];
    [fmt setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];//Fri Mar 02 08:52:11:233 UTC 2012
    NSDate *timeString = [fmt dateFromString:utcTime];
    
    return timeString;
}

@end
