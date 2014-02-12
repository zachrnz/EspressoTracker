//
//  Shot.h
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 12/16/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Beans, ShotData, Variable;

@interface Shot : NSManagedObject

@property (nonatomic, retain) NSDate * datePulled;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * systemTag;
@property (nonatomic, retain) Beans *beans;
@property (nonatomic, retain) ShotData *completeRoutine;
@property (nonatomic, retain) ShotData *defaultRoutine;
@property (nonatomic, retain) ShotData *shotHistory;
@property (nonatomic, retain) ShotData *userRoutine;
@property (nonatomic, retain) NSSet *variables;
@end

@interface Shot (CoreDataGeneratedAccessors)

- (void)addVariablesObject:(Variable *)value;
- (void)removeVariablesObject:(Variable *)value;
- (void)addVariables:(NSSet *)values;
- (void)removeVariables:(NSSet *)values;

@end
