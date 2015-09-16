//
//  GJCoreData.h
//  todo
//
//  Created by Hyde on 9/16/15.
//  Copyright (c) 2015 Hyde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface GJCoreData : NSObject
- (instancetype)initWithErrorBlock:(void (^)(NSError* error))errorBlock;

- (instancetype)initWithName:(NSString*)name
                      inPath:(NSURL*)path
                  withBundle:(NSBundle*)bundle
                     forType:(NSString*)type
               andErrorBlock:(void (^)(NSError* error))errorBlock;

- (NSManagedObjectContext*)buildManagedObjectContext;
@end

@interface NSManagedObjectContext (GJManagedObjectContext)
- (void)saveWithErrorBlock:(void (^)(NSError* error))errorBlock;
@end