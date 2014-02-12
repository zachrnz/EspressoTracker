//
//  Shot.m
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 10/17/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import "ShotOLD.h"
#import "BeansOLD.h"

@implementation ShotOLD

//These are class variables:
static const CGFloat gramsPerOunce = 28.3495;
static const CGFloat mlPerFluidOunce = 29.5735;

- (void)setDatePulled:(NSDate *)datePulled
{
    _datePulled = datePulled;
    if (self.beans) {
        _beanAgeInDays = [self.beans ageInDaysOnDate:datePulled];
    }
}

- (void)setGroundsWeightInGrams:(CGFloat)weightInGrams
{
    _groundsWeightInGrams = weightInGrams;
    _groundsWeightInOunces = weightInGrams / gramsPerOunce;
}

- (void)setGroundsWeightInOunces:(CGFloat)groundsWeightInOunces
{
    _groundsWeightInOunces = groundsWeightInOunces;
    _groundsWeightInGrams = groundsWeightInOunces * gramsPerOunce;
}

- (void)setEspressoWeightInGrams:(CGFloat)espressoWeightInGrams
{
    _espressoWeightInGrams = espressoWeightInGrams;
    _espressoWeightInOunces = espressoWeightInGrams / gramsPerOunce;
}

- (void)setEspressoWeightInOunces:(CGFloat)espressoWeightInOunces
{
    _espressoWeightInOunces = espressoWeightInOunces;
    _espressoWeightInGrams = espressoWeightInOunces * gramsPerOunce;
}

- (void)setEspressoVolumeInML:(CGFloat)espressoVolumeInML
{
    _espressoVolumeInML = espressoVolumeInML;
    _espressoVolumeInOunces = espressoVolumeInML / mlPerFluidOunce;
}

- (void)setEspressoVolumeInOunces:(CGFloat)espressoVolumeInOunces
{
    _espressoVolumeInOunces = espressoVolumeInOunces;
    _espressoVolumeInML = espressoVolumeInOunces * mlPerFluidOunce;
}


@end
