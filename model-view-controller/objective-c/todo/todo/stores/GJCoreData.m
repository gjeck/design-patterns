//
//  GJCoreData.m
//  todo
//
//  Created by Hyde on 9/16/15.
//  Copyright (c) 2015 Hyde. All rights reserved.
//

#import "GJCoreData.h"

@interface GJCoreData()
@property (nonatomic, weak) NSString* name;
@property (nonatomic, weak) NSURL* filePath;
@property (nonatomic, weak) NSBundle* bundle;
@property (nonatomic, weak) NSString* storeType;
@property (nonatomic, strong) NSManagedObjectModel* managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator* persistentStoreCoordinator;
@end

@implementation GJCoreData

- (instancetype)init {
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* productName = [[bundle infoDictionary] objectForKey:@"CFBundleName"];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSURL* path = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [self initWithName:productName
                       inPath:path
                   withBundle:bundle
                      forType:NSSQLiteStoreType
                andErrorBlock:nil];
}

- (instancetype)initWithErrorBlock:(void (^)(NSError* error))errorBlock {
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* productName = [[bundle infoDictionary] objectForKey:@"CFBundleName"];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSURL* path = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [self initWithName:productName
                       inPath:path
                   withBundle:bundle
                      forType:NSSQLiteStoreType
                andErrorBlock:^(NSError *error) {
                    if (errorBlock) errorBlock(error);
                }];
}

- (instancetype)initWithName:(NSString*)name
                      inPath:(NSURL*)path
                  withBundle:(NSBundle*)bundle
                     forType:(NSString*)type
               andErrorBlock:(void (^)(NSError* error))errorBlock {
    if (self = [super init]) {
        _name = name;
        _filePath = path;
        _bundle = bundle;
        _storeType = type;
        
        if ([_storeType isEqualToString:NSInMemoryStoreType]) {
            _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:@[_bundle]];
        } else {
            _managedObjectModel = [GJCoreData buildManagedObjectModelInBundle:_bundle withName:_name];
        }
        
        void (^persistError)(NSError* error) = ^void(NSError* error) {
            if (errorBlock) errorBlock(error);
        };
        _persistentStoreCoordinator = [GJCoreData buildPersistentStoreCoordinatorWithModel:_managedObjectModel
                                                                               inDirectory:_filePath
                                                                                  withName:_name
                                                                                   forType:_storeType
                                                                             andErrorBlock:persistError];
    }
    return self;
}

+ (NSManagedObjectModel*)buildManagedObjectModelInBundle:(NSBundle*)bundle withName:(NSString*)name {
    NSURL* modelURL = [bundle URLForResource:name withExtension:@"momd"];
    NSManagedObjectModel* objModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return objModel;
}

+ (NSPersistentStoreCoordinator*)buildPersistentStoreCoordinatorWithModel:(NSManagedObjectModel*)model
                                                              inDirectory:(NSURL*)dir
                                                                 withName:(NSString*)name
                                                                  forType:(NSString*)type
                                                            andErrorBlock:(void (^)(NSError* error))errorBlock {
    NSPersistentStoreCoordinator* persistentStore = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    NSURL* storeURL = [dir URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", name]];
    NSError* error = nil;
    BOOL success = [persistentStore addPersistentStoreWithType:type
                                                 configuration:nil
                                                           URL:storeURL
                                                       options:nil
                                                         error:&error];
    if (!success) {
        if (errorBlock) errorBlock(error);
    }
    
    return persistentStore;
}

- (NSManagedObjectContext*)buildManagedObjectContext {
    NSManagedObjectContext* context = [[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator:_persistentStoreCoordinator];
    return context;
}

@end

@implementation NSManagedObjectContext (GJManagedObjectContext)
- (void)saveWithErrorBlock:(void (^)(NSError* error))errorBlock {
    NSError *error = nil;
    if ([self hasChanges] && [self save:&error]) {}
    if (errorBlock) errorBlock(error);
}
@end
