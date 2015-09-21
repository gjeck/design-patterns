//
//  TodoListTest.m
//  todo
//
//  Created by Hyde on 9/21/15.
//  Copyright (c) 2015 Hyde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TodoList.h"
#import "GJCoreData.h"

@interface TodoListTest : XCTestCase
@property (nonatomic, strong) GJCoreData* core;
@property (nonatomic, strong) NSManagedObjectContext* context;
@end

@implementation TodoListTest

- (void)setUp {
    [super setUp];
    _core = [GJCoreData buildInMemoryStackWithErrorBlock:nil];
    _context = [_core buildManagedObjectContext];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCreate {
    NSDictionary* attributes = @{@"color":[UIColor redColor],
                                 @"name":@"test",
                                 @"orderValue":@2.4};
    TodoList* todoList = [TodoList createWithAttributes:attributes
                                              inContext:_context
                                         withErrorBlock:^(NSError *error) {
                                             XCTAssertNil(error);
                                         }];
    XCTAssertEqual(todoList.color, [UIColor redColor]);
    XCTAssertEqualObjects(todoList.name, @"test");
    XCTAssertGreaterThan(@0.0, todoList.orderValue);
    XCTAssertTrue(todoList.todoItems.count == 0);
}

@end
