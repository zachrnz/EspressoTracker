//
//  Beans.h
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 12/16/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Shot;

@interface Beans : NSManagedObject

@property (nonatomic, retain) NSString * cultivar;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSDate * roastDate;
@property (nonatomic, retain) NSString * roaster;
@property (nonatomic, retain) NSSet *shot;
@end

@interface Beans (CoreDataGeneratedAccessors)

- (void)addShotObject:(Shot *)value;
- (void)removeShotObject:(Shot *)value;
- (void)addShot:(NSSet *)values;
- (void)removeShot:(NSSet *)values;

@end
