//
//  TodoListTest.m
//  todo
//
//  Created by Hyde on 9/21/15.
//  Copyright (c) 2015 Hyde. All rights reserved.
//

@import UIKit;
@import XCTest;
#import "GJCoreData.h"
#import "TodoList.h"

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
  NSDictionary* attributes = @{@"title":@"test",
                               @"orderValue":@2.4,
                               @"done":@NO};
  TodoList* todoList = [TodoList createWithAttributes:attributes
                                            inContext:_context
                                       withErrorBlock:^(NSError *error) {
                                         XCTAssertNil(error);
                                       }];
  XCTAssertEqualObjects(todoList.title, @"test");
  XCTAssertGreaterThan(todoList.orderValue.floatValue, 0);
  XCTAssertFalse(todoList.done.boolValue);
  XCTAssertTrue(todoList.labels.count == 0);
  XCTAssertTrue(todoList.todoItems.count == 0);
}

- (void)testSave {
  TodoList* todoList = [TodoList objectInContext:_context];
  todoList.title = @"test";
  todoList.orderValue = @1.0;
  todoList.done = @NO;
  [todoList saveInContext:_context withErrorBlock:^(NSError *error) {
    XCTAssertNil(error);
  }];
}

@end
