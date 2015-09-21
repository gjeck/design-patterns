//
//  AppDelegate.m
//  todo
//
//  Created by Hyde on 9/16/15.
//  Copyright (c) 2015 Hyde. All rights reserved.
//

#import "AppDelegate.h"
#import "GJCoreData.h"


@interface AppDelegate ()
@property (nonatomic, strong, readonly) NSManagedObjectContext* context;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    GJCoreData* core = [GJCoreData buildDefaultStackWithErrorBlock:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    _context = [core buildManagedObjectContext];
        
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [_context saveWithErrorBlock:nil];
}

@end
