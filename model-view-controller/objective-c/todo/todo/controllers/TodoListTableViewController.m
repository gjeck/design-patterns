//
//  TodoListTableViewController.m
//  todo
//
//  Created by Hyde on 9/22/15.
//  Copyright (c) 2015 Hyde. All rights reserved.
//

#import "TodoListTableViewController.h"
#import "TodoList.h"
#import "TodoListCreateViewController.h"
#import "GJCoreData.h"

@interface TodoListTableViewController () <NSFetchedResultsControllerDelegate>
@property (nonatomic, weak) IBOutlet UIBarButtonItem* addButtonItem;
@end

static NSString* const DefaultCellIdentifier = @"TodoListCell";
static NSString* const TodoListCreateControllerSegueIdentifier = @"TodoListCreateControllerSegue";

@implementation TodoListTableViewController

#pragma mark - Initializers

- (instancetype)initWithStoryBoard:(UIStoryboard*)storyBoard
                           context:(NSManagedObjectContext*)context
        andFetchedResultController:(NSFetchedResultsController*)fetchController {
  NSString* className = NSStringFromClass([self class]);
  self = [storyBoard instantiateViewControllerWithIdentifier:className];
  if (self) {
    _context = context;
    _fetchController = fetchController;
  }
  return self;
}

#pragma mark - Builder Methods

+ (NSFetchedResultsController *)buildFetchedResultsControllerWithEntityName:(NSString *)entityName
                                                    andManagedObjectContext:(NSManagedObjectContext *)context {
  NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
  NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"orderValue" ascending:NO];
  [fetchRequest setSortDescriptors:@[sortDescriptor]];
  NSString* cacheName = [NSString stringWithFormat:@"%@-table", entityName];
  return [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                             managedObjectContext:context
                                               sectionNameKeyPath:nil
                                                        cacheName:cacheName];
}

#pragma mark - UIViewController Life

- (void)viewDidLoad {
  [super viewDidLoad];
  [NSFetchedResultsController deleteCacheWithName:_fetchController.cacheName];
  [_fetchController setDelegate:self];
  [_fetchController performFetch:nil];
  
  self.navigationItem.leftBarButtonItem = self.editButtonItem;
  self.navigationItem.rightBarButtonItem = _addButtonItem;
  
  self.clearsSelectionOnViewWillAppear = NO;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Private Methods
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  TodoList *todoList = [_fetchController objectAtIndexPath:indexPath];
  [cell.textLabel setText:todoList.title];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [[_fetchController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSInteger rowCount = 0;
  if ([[_fetchController sections] count] > 0) {
    id sectionInfo = [[_fetchController sections] objectAtIndex:section];
    rowCount = [sectionInfo numberOfObjects];
  }
  return rowCount;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DefaultCellIdentifier
                                                          forIndexPath:indexPath];
  [self configureCell:cell atIndexPath:indexPath];
  return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
  switch(editingStyle) {
    case UITableViewCellEditingStyleDelete:
      [_context deleteObject:[_fetchController objectAtIndexPath:indexPath]];
      [_context save:nil];
      break;
    case UITableViewCellEditingStyleInsert:
      // Create instance and insert
      break;
    case UITableViewCellEditingStyleNone:
      break;
  }
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
  [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
  
  switch(type) {
    case NSFetchedResultsChangeInsert:
      [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                    withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeDelete:
      [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                    withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeMove:
      break;
    case NSFetchedResultsChangeUpdate:
      break;
  }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
  
  UITableView *tableView = self.tableView;
  
  switch(type) {
      
    case NSFetchedResultsChangeInsert:
      [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                       withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeDelete:
      [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                       withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeUpdate:
      [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
              atIndexPath:indexPath];
      break;
      
    case NSFetchedResultsChangeMove:
      [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                       withRowAnimation:UITableViewRowAnimationFade];
      [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                       withRowAnimation:UITableViewRowAnimationFade];
      break;
  }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  [self.tableView endUpdates];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:TodoListCreateControllerSegueIdentifier]) {
    TodoListCreateViewController* vc = segue.destinationViewController;
    vc.context = _context;
    vc.potentialTodoList = [TodoList objectInContext:_context];
    vc.potentialTodoList.orderValue = @([self.tableView numberOfRowsInSection:0]);
  }
}


@end
