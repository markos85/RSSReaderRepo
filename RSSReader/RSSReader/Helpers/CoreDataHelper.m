//
//  CoreDataHelper.m
//  RSSReader
//
//  Created by Marko Savic on 5/20/13.
//  Copyright (c) 2013 Gecko Solutions. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper

#pragma mark - Public methods

- (NSManagedObjectContext *) managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void) deleteAllObjects : (NSString *) entityDescription
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items)
    {
    	[[self managedObjectContext] deleteObject:managedObject];
    	NSLog(@"%@ object deleted",entityDescription);
    }
    if (![[self managedObjectContext] save:&error])
    {
    	NSLog(@"Error deleting %@ - error:%@",entityDescription,error);
    }
}

- (NSArray *) getAllObjects : (NSString *) entityDescription
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityDescription];
    return [managedObjectContext executeFetchRequest:fetchRequest error:nil];
}

static CoreDataHelper *shared = nil;

+ (CoreDataHelper *) sharedInstance
{
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        shared = [[CoreDataHelper alloc] init];
    });
    return shared;
}

@end
