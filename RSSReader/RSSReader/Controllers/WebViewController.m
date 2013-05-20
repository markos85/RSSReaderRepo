//
//  WebViewController.m
//  RSSReader
//
//  Created by Marko Savic on 5/17/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

- (void) setDelegates;

@end

@implementation WebViewController 

#pragma mark - View Lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setDelegates];
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

#pragma mark - UIWebViewDelegate methods

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    [self showActivityIndicator];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideActivityIndicator];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideActivityIndicator];
}

#pragma mark - Public methods

- (void) showActivityIndicator
{
    [super showActivityIndicator];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
}

- (void) hideActivityIndicator
{
    [super hideActivityIndicator];
    
    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - Private methods

- (void) setDelegates
{
    [self.webView setDelegate:self];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    
    [super viewDidUnload];
}

@end
