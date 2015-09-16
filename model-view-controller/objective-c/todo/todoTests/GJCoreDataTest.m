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
@property (nonatomic, strong) NSURL* path;
@property (nonatomic, strong) NSBundle* bundle;
@property (nonatomic, strong) NSString* type;
@end

@implementation GJCoreDataTest

- (void)setUp {
    [super setUp];
    _path = [NSURL fileURLWithPath:NSTemporaryDirectory()];
    _bundle = [NSBundle bundleForClass:[self class]];
    _type = NSInMemoryStoreType;
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInit {
    GJCoreData* core = [[GJCoreData alloc] initWithName:@"test"
                                                 inPath:_path
                                             withBundle:_bundle
                                                forType:_type
                                          andErrorBlock:^(NSError *error) {
                                              XCTAssertNil(error);
                                          }];
    XCTAssertNotNil(core);
}

- (void)testBuildManagedObjectContext {
    GJCoreData* core = [[GJCoreData alloc] initWithName:@"test"
                                                 inPath:_path
                                             withBundle:_bundle
                                                forType:_type
                                          andErrorBlock:^(NSError *error) {
                                              XCTAssertNil(error);
                                          }];
    NSManagedObjectContext* context = [core buildManagedObjectContext];
    XCTAssertNotNil(context);
    XCTAssertNotNil(context.persistentStoreCoordinator);
    XCTAssertNotNil(context.persistentStoreCoordinator.managedObjectModel);
}

@end
