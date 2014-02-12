//
//  Beans.h
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 10/17/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeansOLD : NSObject

@property (nonatomic, copy) NSString *roaster;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *region;
@property (nonatomic) NSDate *roastDate;

- (NSInteger)daysSinceRoast;
- (NSInteger)ageInDaysOnDate:(NSDate *) date;

@end
