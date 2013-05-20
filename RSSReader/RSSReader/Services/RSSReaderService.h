//
//  RSSReaderService.h
//  RSSReader
//
//  Created by Marko Savic on 5/17/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface RSSReaderService : NSObject <ASIHTTPRequestDelegate>

- (void) sendRequestWithUrl : (NSURL *) url;

- (void) processResponseSucceed : (NSData *) responseData;

- (void) processResponseError : (NSError *) errorDescription;

@end
