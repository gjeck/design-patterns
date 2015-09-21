//
//  TodoList.h
//  todo
//
//  Created by Hyde on 9/21/15.
//  Copyright (c) 2015 Hyde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class TodoItem;

@interface TodoList : NSManagedObject

@property (nonatomic, retain) UIColor* color;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * orderValue;
@property (nonatomic, retain) NSSet *todoItems;
@end

@interface TodoList (CoreDataGeneratedAccessors)

- (void)addTodoItemsObject:(TodoItem *)value;
- (void)removeTodoItemsObject:(TodoItem *)value;
- (void)addTodoItems:(NSSet *)values;
- (void)removeTodoItems:(NSSet *)values;

@end
