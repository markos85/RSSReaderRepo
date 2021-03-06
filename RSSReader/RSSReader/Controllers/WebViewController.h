//
//  WebViewController.h
//  RSSReader
//
//  Created by Marko Savic on 5/17/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSFeed.h"
#import "BasicViewController.h"

@interface WebViewController : BasicViewController <UIWebViewDelegate>

@property (strong, nonatomic) RSSFeed *rssEntry;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
