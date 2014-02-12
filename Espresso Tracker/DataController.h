//
//  DataController.h
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 10/17/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShotOLD;
@class BeansOLD;

@interface DataController : NSObject

@property (nonatomic, copy) NSMutableArray *masterShotList;
@property (nonatomic, copy) NSMutableArray *masterBeansList;

- (NSUInteger)countOfShotList;
- (NSUInteger)countOfBeansList;
- (ShotOLD *)objectInShotListAtIndex:(NSUInteger)theIndex;
- (BeansOLD *)objectInBeansListAtIndex:(NSUInteger)theIndex;
- (void)addShot:(ShotOLD *)shot;
- (void)addBeans:(BeansOLD *)beans;

@end
