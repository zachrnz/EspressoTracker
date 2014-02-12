//
//  Variable.h
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 12/16/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Shot;

@interface Variable : NSManagedObject

@property (nonatomic, retain) NSString * ownCellID;
@property (nonatomic, retain) NSDecimalNumber * highestValue;
@property (nonatomic, retain) NSDecimalNumber * increment;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSDecimalNumber * lowestValue;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSString * slideOutControlCellID;
@property (nonatomic, retain) Shot *shots;

@end
