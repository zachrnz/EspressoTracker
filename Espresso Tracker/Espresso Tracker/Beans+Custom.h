//
//  Beans+Custom.h
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 10/25/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import "Beans.h"

@interface Beans (Custom)

- (NSInteger)daysSinceRoast;
- (NSInteger)ageInDaysOnDate:(NSDate *) date;

@end
