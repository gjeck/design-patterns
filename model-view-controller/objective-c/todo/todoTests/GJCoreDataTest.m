//
//  GJCoreDataTest.m
//  todo
//
//  Created by Hyde on 9/16/15.
//  Copyright (c) 2015 Hyde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GJCoreData.h"

@interface GJCoreDataTest : XCTestCase
@end

@implementation GJCoreDataTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInit {
    GJCoreData* core = [GJCoreData buildInMemoryStackWithErrorBlock:^(NSError *error) {
        XCTAssertNil(error);
    }];
    XCTAssertNotNil(core);
}

- (void)testBuildManagedObjectContext {
    GJCoreData* core = [GJCoreData buildInMemoryStackWithErrorBlock:^(NSError *error) {
        XCTAssertNil(error);
    }];
    
    NSManagedObjectContext* context = [core buildManagedObjectContext];
    XCTAssertNotNil(context);
    XCTAssertNotNil(context.persistentStoreCoordinator);
    XCTAssertNotNil(context.persistentStoreCoordinator.managedObjectModel);
}

@end
