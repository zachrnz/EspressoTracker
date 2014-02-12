//
//  DataStore.h
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 11/28/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CoreData/CoreData.h"
#import "ShotData.h"

#define USER_DB @"espressoTracker.sqlite"

@interface DataStore : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong, readonly) ShotData *data; //Used to store a reference to the single top-level database element (ShotData).

+(DataStore *) sharedDataStore;
- (NSURL *)applicationDocumentsDirectory;
- (void)resetManagedObjectContext;
- (void)saveData;

@end

