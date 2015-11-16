//
//  TodoList.h
//  todo
//
//  Created by Hyde on 9/21/15.
//  Copyright (c) 2015 Hyde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol ValueOrdered
@required
@property (nonatomic, retain) NSNumber* orderValue;
@end

@class TodoItem;
@class TodoLabel;

@interface TodoList : NSManagedObject <ValueOrdered> {
  NSNumber* orderValue;
}

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSNumber* done;
@property (nonatomic, retain) NSSet* labels;
@property (nonatomic, retain) NSSet* todoItems;
@end

@interface TodoList (CoreDataGeneratedAccessors)

- (void)addTodoItemsObject:(TodoItem *)value;
- (void)removeTodoItemsObject:(TodoItem *)value;
- (void)addTodoItems:(NSSet *)values;
- (void)removeTodoItems:(NSSet *)values;

- (void)addTodoLabelsObject:(TodoLabel *)value;
- (void)removeTodoLabelsObject:(TodoLabel *)value;
- (void)addTodoLabels:(NSSet *)values;
- (void)removeTodoLabels:(NSSet *)values;

@end