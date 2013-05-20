//
//  BasicViewController.m
//  RSSReader
//
//  Created by Marko Savic on 5/20/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

#pragma mark - View Lifecycle

@implementation BasicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
}

#pragma mark - Public methods

- (UIActivityIndicatorView *) activityIndicator
{
    if (!_activityIndicator)
    {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    
    return _activityIndicator;
}

- (void) showActivityIndicator
{
    self.activityIndicator.hidesWhenStopped = YES;
    [self.activityIndicator startAnimating];
}

- (void) hideActivityIndicator
{
    [self.activityIndicator stopAnimating];
}

#pragma mark - Private methods

#pragma mark - Memory managment

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [self setActivityIndicator:nil];
    
    [super viewDidUnload];
}

@end
