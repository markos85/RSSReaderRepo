//
//  RSSFeedViewController.h
//  RSSReader
//
//  Created by Marko Savic on 5/17/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSFeedService.h"
#import "RSSFeedProtocol.h"

@interface RSSFeedViewController : UIViewController <RSSFeedProtocol>

@property (strong, nonatomic) IBOutlet UITableView *rssFeedTableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *rightBarButton;

- (IBAction)refreshRSS:(UIBarButtonItem *)sender;



@end
