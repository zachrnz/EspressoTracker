//
//  DataController.m
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 10/17/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import "DataController.h"


@implementation DataController

- (NSUInteger)countOfShotList {
    return self.masterShotList.count;
}

- (NSUInteger)countOfBeansList {
    return self.masterBeansList.count;
}

- (ShotOLD *)objectInShotListAtIndex:(NSUInteger)theIndex {
    return [self.masterShotList objectAtIndex:theIndex];
}

- (BeansOLD *)objectInBeansListAtIndex:(NSUInteger)theIndex {
    return [self.masterBeansList objectAtIndex:theIndex];
}

- (void)addShot:(ShotOLD *)shot {
    [self.masterShotList addObject:shot];
}

- (void)addBeans:(BeansOLD *)beans {
    [self.masterBeansList addObject:beans];
}

@end
