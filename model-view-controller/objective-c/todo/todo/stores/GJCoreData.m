//
//  GJCoreData.m
//  todo
//
//  Created by Hyde on 9/16/15.
//  Copyright (c) 2015 Hyde. All rights reserved.
//

#import "GJCoreData.h"

@interface GJCoreData()
@property (nonatomic, strong) NSManagedObjectModel* managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator* persistentStoreCoordinator;
@end

@implementation GJCoreData

- (instancetype)init {
    return [GJCoreData buildDefaultStackWithErrorBlock:nil];
}

- (instancetype)initWithManagedObjectModel:(NSManagedObjectModel*)model
             andPersistentStoreCoordinator:(NSPersistentStoreCoordinator*)coordinator {
    if (self = [super init]) {
        _managedObjectModel = model;
        _persistentStoreCoordinator = coordinator;
    }
    return self;
}

+ (GJCoreData*)buildDefaultStackWithErrorBlock:(void (^)(NSError* error))errorBlock {
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* productName = [[bundle infoDictionary] objectForKey:@"CFBundleName"];
    NSManagedObjectModel* model = [GJCoreData buildManagedObjectModelInBundle:bundle withName:productName];
    
    void (^persistError)(NSError* error) = ^void(NSError* error) {
        if (errorBlock) errorBlock(error);
    };
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSURL* directory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSString* pathComponent = [NSString stringWithFormat:@"%@.sqlite", productName];
    NSURL* storeURL = [directory URLByAppendingPathComponent:pathComponent];
    NSPersistentStoreCoordinator* pscoord = [GJCoreData buildPersistentStoreCoordinatorWithModel:model
                                                                                            type:NSSQLiteStoreType
                                                                                   configuration:nil
                                                                                             URL:storeURL
                                                                                         options:nil
                                                                                   andErrorBlock:persistError];
    
    return [[GJCoreData alloc] initWithManagedObjectModel:model andPersistentStoreCoordinator:pscoord];
}

+ (GJCoreData*)buildInMemoryStackWithErrorBlock:(void (^)(NSError* error))errorBlock {
    NSBundle* bundle = [NSBundle mainBundle];
    NSManagedObjectModel* model = [NSManagedObjectModel mergedModelFromBundles:@[bundle]];
    
    void (^persistError)(NSError* error) = ^void(NSError* error) {
        if (errorBlock) errorBlock(error);
    };
    NSPersistentStoreCoordinator* pscoord = [GJCoreData buildPersistentStoreCoordinatorWithModel:model
                                                                                            type:NSInMemoryStoreType
                                                                                   configuration:nil
                                                                                             URL:nil
                                                                                         options:nil
                                                                                   andErrorBlock:persistError];
    return [[GJCoreData alloc] initWithManagedObjectModel:model andPersistentStoreCoordinator:pscoord];
}

+ (NSManagedObjectModel*)buildManagedObjectModelInBundle:(NSBundle*)bundle withName:(NSString*)name {
    NSURL* modelURL = [bundle URLForResource:name withExtension:@"momd"];
    NSManagedObjectModel* objModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return objModel;
}

+ (NSPersistentStoreCoordinator*)buildPersistentStoreCoordinatorWithModel:(NSManagedObjectModel*)model
                                                                     type:(NSString*)type
                                                            configuration:(NSString*)configuration
                                                                      URL:(NSURL*)url
                                                                  options:(NSDictionary*)options
                                                            andErrorBlock:(void (^)(NSError* error))errorBlock {
    NSPersistentStoreCoordinator* pscoord = [[NSPersistentStoreCoordinator alloc]
                                             initWithManagedObjectModel:model];
    
    NSError* error = nil;
    [pscoord addPersistentStoreWithType:type
                          configuration:configuration
                                    URL:url
                                options:options
                                  error:&error];
    
    if (errorBlock) errorBlock(error);
    
    return pscoord;
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

@implementation NSManagedObject (GJManagedObject)

+ (instancetype)createWithAttributes:(NSDictionary*)attributes
                           inContext:(NSManagedObjectContext*)context
                      withErrorBlock:(void (^)(NSError* error))errorBlock {
    NSString* className = NSStringFromClass([self class]);
    NSManagedObject* toCreate = [NSEntityDescription insertNewObjectForEntityForName:className
                                                              inManagedObjectContext:context];
    for (NSString* key in attributes) {
        [toCreate setValue:attributes[key] forKey:key];
    }
    
    [context saveWithErrorBlock:errorBlock];
    return toCreate;
}

@end
