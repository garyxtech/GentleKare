//
//  GKAppDelegate.h
//  GeneralKare
//
//  Created by 薛洪 on 13-12-1.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
