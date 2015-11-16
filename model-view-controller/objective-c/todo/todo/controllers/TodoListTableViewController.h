//
//  TodoListTableViewController.h
//  todo
//
//  Created by Hyde on 9/22/15.
//  Copyright (c) 2015 Hyde. All rights reserved.
//

@import UIKit;
@import CoreData;

@interface TodoListTableViewController : UITableViewController

@property (nonatomic, weak, readonly) NSManagedObjectContext* context;
@property (nonatomic, strong) NSFetchedResultsController* fetchController;

- (instancetype)initWithStoryBoard:(UIStoryboard*)storyBoard
                           context:(NSManagedObjectContext*)context
        andFetchedResultController:(NSFetchedResultsController*)fetchController;

+ (NSFetchedResultsController *)buildFetchedResultsControllerWithEntityName:(NSString *)entityName
                                                    andManagedObjectContext:(NSManagedObjectContext *)context;

@end
