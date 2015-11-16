//
//  TodoItem.h
//  todo
//
//  Created by Hyde on 9/21/15.
//  Copyright (c) 2015 Hyde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TodoList.h"


@interface TodoItem : NSManagedObject <ValueOrdered> {
  NSNumber* orderValue;
}

@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSNumber* done;
@property (nonatomic, retain) NSString* title;

@end
