//
//  WebViewController.m
//  RSSReader
//
//  Created by Marko Savic on 5/17/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

#pragma mark - View Lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSURL *url = [NSURL URLWithString:self.rssEntry.link];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    
    [super viewWillDisappear:YES];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == (UIInterfaceOrientationPortrait | UIInterfaceOrientationMaskLandscape));
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    
    [super viewDidUnload];
}

@end
