//
//  ShotData.h
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 12/16/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Shot;

@interface ShotData : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Shot *completeRoutine;
@property (nonatomic, retain) Shot *defaultRoutine;
@property (nonatomic, retain) NSSet *shotHistory;
@property (nonatomic, retain) Shot *userRoutine;
@end

@interface ShotData (CoreDataGeneratedAccessors)

- (void)addShotHistoryObject:(Shot *)value;
- (void)removeShotHistoryObject:(Shot *)value;
- (void)addShotHistory:(NSSet *)values;
- (void)removeShotHistory:(NSSet *)values;

@end
