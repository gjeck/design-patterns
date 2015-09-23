//
//  TodoLabel.h
//  todo
//
//  Created by Hyde on 9/22/15.
//  Copyright (c) 2015 Hyde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>


@class TodoList;

@interface TodoLabel : NSManagedObject

@property (nonatomic, retain) UIColor* color;
@property (nonatomic, retain) NSString* title;

@end
