//
//  Shot.h
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 10/17/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BeansOLD;

@interface ShotOLD : NSObject
{
    
}

typedef struct
{
    CGFloat overall;
    CGFloat sweet;
    CGFloat acidic;
    CGFloat bitter;
    CGFloat body;
    CGFloat round;
    CGFloat smooth;
    CGFloat crema;
} ShotProfile;

@property (nonatomic, copy) BeansOLD           *beans;//
@property (nonatomic) NSDate                *datePulled;//
@property (nonatomic, readonly) NSInteger   beanAgeInDays;//
@property (nonatomic, assign) CGFloat       grindSetting;//
@property (nonatomic, assign) CGFloat       pullTimeInSeconds;//
@property (nonatomic) ShotProfile           profile;//

@property (nonatomic, assign) NSInteger     lowestGrindSetting;//
@property (nonatomic, assign) NSInteger     highestGrindSetting;//

@property (nonatomic, assign) CGFloat       groundsWeightInGrams;//
@property (nonatomic, assign) CGFloat       groundsWeightInOunces;//

@property (nonatomic, assign) CGFloat       espressoWeightInGrams;//
@property (nonatomic, assign) CGFloat       espressoWeightInOunces;//

@property (nonatomic, assign) CGFloat       espressoVolumeInOunces;//
@property (nonatomic, assign) CGFloat       espressoVolumeInML;//




@end
