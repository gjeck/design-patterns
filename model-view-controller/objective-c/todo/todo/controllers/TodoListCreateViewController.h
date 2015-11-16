//
//  TodoListCreateViewController.h
//  todo
//
//  Created by Greg on 11/15/15.
//  Copyright © 2015 Hyde. All rights reserved.
//

@import UIKit;
#import "TodoList.h"

@interface TodoListCreateViewController : UIViewController

@property (nonatomic, weak) NSManagedObjectContext* context;
@property (nonatomic, strong) TodoList* potentialTodoList;

@end
