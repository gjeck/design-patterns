//
//  TodoListTableViewController.h
//  todo
//
//  Created by Hyde on 9/22/15.
//  Copyright (c) 2015 Hyde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoListTableViewController : UITableViewController

@property (nonatomic, weak) NSManagedObjectContext* context;

- (instancetype)initWithStoryBoard:(UIStoryboard*)storyBoard andContext:(NSManagedObjectContext*)context;

@end
