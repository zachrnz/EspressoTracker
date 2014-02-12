//
//  Shot+Custom.m
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 10/25/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import "Shot+Custom.h"
#import "Beans+Custom.h"

@implementation Shot (Custom)

/* TO DO LIST:
 
 Add exceptions:
    No beans associated? beanAgeInDays should throw something
 Decide how to handle the case where associated beans are deleted. This needs to be done through the CoreData editor. Should "shot" keep its own copy?
 */


//These are class variables:
static const CGFloat gramsPerOunce = 28.3495;
static const CGFloat mlPerFluidOunce = 29.5735;

- (void)setGroundsWeightInGrams:(NSNumber *)groundsWeightInGrams
{
    [self willChangeValueForKey: @"groundsWeightInGrams"];
    [self setPrimitiveValue:groundsWeightInGrams forKey:@"groundsWeightInGrams"];
    [self didChangeValueForKey:@"groundsWeightInGrams"];
    
    NSNumber *weightInOunces = [NSNumber numberWithFloat:(groundsWeightInGrams.floatValue / gramsPerOunce)];
    [self willChangeValueForKey: @"groundsWeightInOunces"];
    [self setPrimitiveValue: weightInOunces forKey:@"groundsWeightInOunces"];
    [self didChangeValueForKey:@"groundsWeightInOunces"];
}

- (void)setGroundsWeightInOunces:(NSNumber *)groundsWeightInOunces
{
    [self willChangeValueForKey: @"groundsWeightInOunces"];
    [self setPrimitiveValue: groundsWeightInOunces forKey:@"groundsWeightInOunces"];
    [self didChangeValueForKey:@"groundsWeightInOunces"];
    
    NSNumber *weightInGrams = [NSNumber numberWithFloat:(groundsWeightInOunces.floatValue * gramsPerOunce)];
    [self willChangeValueForKey: @"groundsWeightInGrams"];
    [self setPrimitiveValue:weightInGrams forKey:@"groundsWeightInGrams"];
    [self didChangeValueForKey:@"groundsWeightInGrams"];
}

- (void)setEspressoWeightInOunces:(NSNumber *)espressoWeightInOunces
{
    [self willChangeValueForKey: @"espressoWeightInOunces"];
    [self setPrimitiveValue: espressoWeightInOunces forKey:@"espressoWeightInOunces"];
    [self didChangeValueForKey:@"espressoWeightInOunces"];
    
    NSNumber *weightInGrams = [NSNumber numberWithFloat:(espressoWeightInOunces.floatValue * gramsPerOunce)];
    [self willChangeValueForKey: @"espressoWeightInGrams"];
    [self setPrimitiveValue:weightInGrams forKey:@"espressoWeightInGrams"];
    [self didChangeValueForKey:@"espressoWeightInGrams"];
}

- (void)setEspressoWeightInGrams:(NSNumber *)espressoWeightInGrams
{
    [self willChangeValueForKey: @"espressoWeightInGrams"];
    [self setPrimitiveValue:espressoWeightInGrams forKey:@"espressoWeightInGrams"];
    [self didChangeValueForKey:@"espressoWeightInGrams"];
    
    NSNumber *weightInOunces = [NSNumber numberWithFloat:(espressoWeightInGrams.floatValue / gramsPerOunce)];
    [self willChangeValueForKey: @"espressoWeightInOunces"];
    [self setPrimitiveValue: weightInOunces forKey:@"espressoWeightInOunces"];
    [self didChangeValueForKey:@"espressoWeightInOunces"];
}

- (void)setEspressoVolumeInFluidOunces:(NSNumber *)volumeInOunces
{
    [self willChangeValueForKey: @"espressoVolumeInFluidOunces"];
    [self setPrimitiveValue: volumeInOunces forKey:@"espressoVolumeInFluidOunces"];
    [self didChangeValueForKey:@"espressoVolumeInFluidOunces"];
    
    NSNumber *volumeInML = [NSNumber numberWithFloat:(volumeInOunces.floatValue * mlPerFluidOunce)];
    [self willChangeValueForKey: @"espressoVolumeInML"];
    [self setPrimitiveValue:volumeInML forKey:@"espressoVolumeInML"];
    [self didChangeValueForKey:@"espressoVolumeInML"];
}

- (void)setEspressoVolumeInML:(NSNumber *)volumeInML
{
    [self willChangeValueForKey: @"espressoVolumeInML"];
    [self setPrimitiveValue: volumeInML forKey:@"espressoVolumeInML"];
    [self didChangeValueForKey:@"espressoVolumeInML"];
    
    NSNumber *volumeInOunces = [NSNumber numberWithFloat:(volumeInML.floatValue / mlPerFluidOunce)];
    [self willChangeValueForKey: @"espressoVolumeInFluidOunces"];
    [self setPrimitiveValue:volumeInOunces forKey:@"espressoVolumeInFluidOunces"];
    [self didChangeValueForKey:@"espressoVolumeInFluidOunces"];
}

- (NSNumber *)beanAgeInDays
{
    //Properties don't seem to be initiated to nil, but rather 0. So we need to test for 0 instead of nil to see if the field has already been set. Of course, this means we will recalculate everytime if the age is in fact 0, but that's ok.
    if (((NSNumber *)[self primitiveValueForKey:@"beanAgeInDays"]).intValue == 0) {
        NSInteger age;
        if (self.beans) {
            age = [self.beans ageInDaysOnDate:[self datePulled]];
        } else {
            //NO BEANS: RAISE EXCEPTION
            age = -1;
        }
        NSNumber *ageNum = [NSNumber numberWithInt:age];
        [self willChangeValueForKey: @"beanAgeInDays"];
        [self setPrimitiveValue: ageNum forKey:@"beanAgeInDays"];
        [self didChangeValueForKey:@"groundsWeightInOunces"];
    }
    return [self primitiveValueForKey:@"beanAgeInDays"];
}

@end
