//
//  RSSFeedViewController.m
//  RSSReader
//
//  Created by Marko Savic on 5/17/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import "RSSFeedViewController.h"
#import "RSSFeed.h"
#import "UIImageView+WebCache.h"
#import "WebViewController.h"
#import "ReachabilityTM.h"
#import "AppDelegate.h"

#define RSS_FEED_IMAGE 101
#define RSS_FEED_TITLE 102

#define RSS_FEED_CELL       @"rssFeedCell"
#define WEB_VIEW_CONTROLLER @"webViewController"

@interface RSSFeedViewController ()

@property (strong, nonatomic) RSSFeedService          *feedService;
@property (strong, nonatomic) NSMutableArray          *rssFeedList;
@property (strong, nonatomic) UIAlertView             *alertView;
@property (nonatomic)         BOOL                     isOnline;

- (void) refresh;
- (NSManagedObjectContext *) managedObjectContext;
- (RSSFeed *) getRssFeedAtIndexPath : (NSIndexPath *) indexPath;
- (void) showActivityIndicator;
- (void) hideActivityIndicator;
- (UITableViewCell *) setCell : (UITableViewCell *) cell withRssData : (RSSFeed *) rssEntry;
- (void) addNotifications;
- (void) showNoInternetConnectionAlert;

@end

@implementation RSSFeedViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addNotifications];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == (UIInterfaceOrientationPortrait | UIInterfaceOrientationMaskLandscape));
}

#pragma mark - Private methods

- (void) refresh
{
    if (self.isOnline)
    {
        [self showActivityIndicator];
        [self.feedService getBBCNews];
    }
    else
    {
        [self showNoInternetConnectionAlert];
    }
}

/*--------------------------------------------------------------
 * Lazy initialization
 *-------------------------------------------------------------*/

- (RSSFeedService *) feedService
{
    if (!_feedService)
    {
        _feedService = [[RSSFeedService alloc] init];
        _feedService.delegate = self;
    }
    
    return _feedService;
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (RSSFeed *) getRssFeedAtIndexPath : (NSIndexPath *) indexPath
{
    return [self.rssFeedList objectAtIndex:indexPath.row];
}

- (UITableViewCell *) setCell : (UITableViewCell *) cell withRssData : (RSSFeed *) rssEntry
{
    UILabel *rssFeedLabel = (UILabel *)[cell viewWithTag:RSS_FEED_TITLE];
    UIImageView *rssFeedImageView = (UIImageView *)[cell viewWithTag:RSS_FEED_IMAGE];
    
    [rssFeedLabel setText:rssEntry.title];
    [rssFeedImageView setImageWithURL:[NSURL URLWithString:rssEntry.thumbnailSmall]];
    
    return cell;
}

- (void) addNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityStatusReceived:)
                                                 name:NOTIFICATION_REACHABILITY_STATUS_CHANGED
                                               object:nil];
}

- (void) showNoInternetConnectionAlert
{
    self.alertView = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"No internet connection!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [self.alertView show];
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
    
    self.navigationItem.rightBarButtonItem = self.rightBarButton;
}

#pragma mark - Action methods

- (IBAction)refreshRSS:(UIBarButtonItem *)sender
{
    [self refresh];
}

/*--------------------------------------------------------------
 * DELEGATES
 *-------------------------------------------------------------*/

/*--------------------------------------------------------------
 * Table View initialization
 *-------------------------------------------------------------*/

#pragma mark - Table View data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numberOfSections = 1;
    
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = self.rssFeedList.count;
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *rssFeedCellIdentifier = RSS_FEED_CELL;
    
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:rssFeedCellIdentifier];
    
    RSSFeed *rssEntry = [self getRssFeedAtIndexPath:indexPath];
    
    return [self setCell:cell withRssData:rssEntry];
}

#pragma mark - Table View delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isOnline)
    {
        RSSFeed *rssEntry = [self getRssFeedAtIndexPath:indexPath];
        
        WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:WEB_VIEW_CONTROLLER];
        webViewController.rssEntry = rssEntry;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
    else
    {
        [self showNoInternetConnectionAlert];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 0.01f;
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
    
    return height;
}

#pragma mark - RSSFeedServiceProtocol

- (void) rssFeedListUpdated : (NSArray *) rssFeedList
{
    self.rssFeedList = [rssFeedList mutableCopy];
    [self.rssFeedTableView reloadData];
    [self hideActivityIndicator];
}
- (void) rssFeedListError : (NSError *) error
{
    [self hideActivityIndicator];
    NSLog(@"Error %@",error);
}

#pragma mark - Notifications

- (void) reachabilityStatusReceived : (NSNotification *) infoNotification
{
    BOOL status = [[infoNotification.userInfo objectForKey:@"status"] boolValue];
    self.isOnline = status;
    [self refresh];
}

#pragma mark - Memory managment

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [self setFeedService:nil];
    [self setRssFeedList:nil];
    [self setRssFeedTableView:nil];
    [self setRightBarButton:nil];
    
    [super viewDidUnload];
}

@end
