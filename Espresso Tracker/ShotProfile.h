//
//  ShotProfile.h
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 10/25/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Shot;

@interface ShotProfile : NSManagedObject

@property (nonatomic, retain) NSNumber * overall;
@property (nonatomic, retain) NSNumber * acidic;
@property (nonatomic, retain) NSNumber * sweet;
@property (nonatomic, retain) NSNumber * bitter;
@property (nonatomic, retain) NSNumber * body;
@property (nonatomic, retain) NSNumber * round;
@property (nonatomic, retain) NSNumber * smooth;
@property (nonatomic, retain) NSNumber * crema;
@property (nonatomic, retain) Shot *shot;

@end
