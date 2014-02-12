//
//  Beans.m
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 10/17/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import "BeansOLD.h"

@implementation BeansOLD

//- (NSInteger) daysSinceRoast
//{
//    NSTimeInterval intervalSinceRoast = [self.roastDate timeIntervalSinceNow];
//    
//    
//    
//}

- (NSInteger)daysSinceRoast
{
    NSDate *roastDate = self.roastDate;
    NSDate *today = [NSDate date];
    NSUInteger unitFlags = NSCalendarUnitDay;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:roastDate toDate:today options:0];
    return [components day];
}

- (NSInteger)ageInDaysOnDate:(NSDate *) date
{
    NSDate *roastDate = self.roastDate;
    NSUInteger unitFlags = NSCalendarUnitDay;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:roastDate toDate:date options:0];
    return [components day];
}

@end
