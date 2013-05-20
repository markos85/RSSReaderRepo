//
//  BasicViewController.h
//  RSSReader
//
//  Created by Marko Savic on 5/20/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicViewController : UIViewController

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

- (void) showActivityIndicator;
- (void) hideActivityIndicator;

@end
