//
//  RSSReaderService.m
//  RSSReader
//
//  Created by Marko Savic on 5/17/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import "RSSReaderService.h"

@implementation RSSReaderService

- (void) sendRequestWithUrl : (NSURL *) url
{    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self processResponseSucceed:[request responseData]];
}

- (void) requestFailed:(ASIHTTPRequest *)request
{
    [self processResponseError:[request error]];
}

@end
