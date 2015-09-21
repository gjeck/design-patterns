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
- (instancetype)initWithManagedObjectModel:(NSManagedObjectModel*)model
             andPersistentStoreCoordinator:(NSPersistentStoreCoordinator*)coordinator;

+ (GJCoreData*)buildDefaultStackWithErrorBlock:(void (^)(NSError* error))errorBlock;
+ (GJCoreData*)buildInMemoryStackWithErrorBlock:(void (^)(NSError* error))errorBlock;
- (NSManagedObjectContext*)buildManagedObjectContext;
@end

@interface NSManagedObjectContext (GJManagedObjectContext)
- (void)saveWithErrorBlock:(void (^)(NSError* error))errorBlock;
@end

@interface NSManagedObject (GJManagedObject)
+ (instancetype)createWithAttributes:(NSDictionary*)attributes
                           inContext:(NSManagedObjectContext*)context
                      withErrorBlock:(void (^)(NSError* error))errorBlock;
@end