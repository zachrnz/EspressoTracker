//
//  Shot.h
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 10/25/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Beans, ShotProfile;

@interface Shot : NSManagedObject

@property (nonatomic, retain) NSDate * datePulled;
@property (nonatomic, retain) NSNumber * pullTimeInSeconds;
@property (nonatomic, retain) NSNumber * groundsWeightInGrams;
@property (nonatomic, retain) NSNumber * groundsWeightInOunces;
@property (nonatomic, retain) NSNumber * beanAgeInDays;
@property (nonatomic, retain) NSNumber * grindSetting;
@property (nonatomic, retain) NSNumber * espressoWeightInOunces;
@property (nonatomic, retain) NSNumber * espressoWeightInGrams;
@property (nonatomic, retain) NSNumber * espressoVolumeInFluidOunces;
@property (nonatomic, retain) NSNumber * espressoVolumeInML;
@property (nonatomic, retain) Beans *beans;
@property (nonatomic, retain) ShotProfile *profile;

@end
