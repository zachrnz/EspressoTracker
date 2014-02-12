//
//  Shot+Custom.m
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 10/25/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import "Shot+Custom.h"
#import "Beans+Custom.h"
#import "Variable.h"

@implementation Shot (Custom)

/* TO DO LIST:
 
 Add exceptions:
    No beans associated? beanAgeInDays should throw something
 Decide how to handle the case where associated beans are deleted. This needs to be done through the CoreData editor. Should "shot" keep its own copy?
 */

- (NSInteger)beanAgeInDays
{
    NSInteger age;
    if (self.beans) {
        age = [self.beans ageInDaysOnDate:[self datePulled]];
    } else {
        //NO BEANS: RAISE EXCEPTION
        age = -1;
    }
    return age;
}

- (Variable *) variableForIndex: (NSInteger) index {
    for (Variable *var in self.variables) {
        if (var.index.integerValue == index) {
            return var;
        }
    }
    return nil; //Only reached if the index was not found
}

//- (Variable *) variableForIndex: (NSInteger) index inShot: (Shot *) shot {
//    for (Variable *var in shot.variables) {
//        if (var.index.integerValue == index) {
//            return var;
//        }
//    }
//    return nil; //Only reached if the index was not found
//}

@end
