//
//  Shot+Custom.h
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 10/25/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import "Shot.h"
#import "Variable.h"

@interface Shot (Custom)

- (NSInteger)beanAgeInDays;
- (Variable *) variableForIndex: (NSInteger) index;



@end
