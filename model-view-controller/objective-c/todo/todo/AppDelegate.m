//
//  AppDelegate.m
//  todo
//
//  Created by Hyde on 9/16/15.
//  Copyright (c) 2015 Hyde. All rights reserved.
//

#import "AppDelegate.h"
#import "GJCoreData.h"
#import "TodoListTableViewController.h"
#import "TodoList.h"


@interface AppDelegate ()
@property (nonatomic, strong, readonly) NSManagedObjectContext* context;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  GJCoreData* core = [GJCoreData buildDefaultStackWithErrorBlock:^(NSError *error) {
    if (error) {
      NSLog(@"CoreDaraError: %@", error.localizedDescription);
    }
  }];
  _context = [core buildManagedObjectContext];
  
  [self setInitialViewController];
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
  [_context saveWithErrorBlock:nil];
}

- (void)setInitialViewController {
  NSFetchedResultsController* fc = [TodoListTableViewController buildFetchedResultsControllerWithEntityName:@"TodoList"
                                                                                    andManagedObjectContext:_context];
  UIStoryboard* todoStory = [UIStoryboard storyboardWithName:@"TodoList" bundle:nil];
  TodoListTableViewController* root = [[TodoListTableViewController alloc] initWithStoryBoard:todoStory
                                                                                      context:_context
                                                                   andFetchedResultController:fc];
  UINavigationController* initialVC = (UINavigationController*) _window.rootViewController;
  [initialVC setViewControllers:@[root]];
}

@end
