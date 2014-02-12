//
//  DataEntryCell.h
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 11/3/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

/*
 
 The DataEntryCell is a placeholder containing all information needed to create a UITableViewCell when required. 
 
 QUESTION: WHY AM I USING THIS AT ALL? WOULDN'T IT BE BETTER TO JUST CREATE UITABLEVIEWCELLS DIRECTLY?
 
 */

#import <Foundation/Foundation.h>

@interface DataEntryCell : NSObject

@property (nonatomic, copy) NSString *cellID;   //Identifier of the appropriate cell prototype
@property (nonatomic, copy) NSString *title;    //title of the cell
@property (nonatomic, copy) NSString *detail;   //detail of the cell
@property (nonatomic) BOOL hasSlideDownSelector;
@property (nonatomic) BOOL hasDisclosure;

//Designated factory method
+ (DataEntryCell *) dataEntryCellWithTitle: (NSString *) title cellID: (NSString *) cellID detail: (NSString *) detail hasSlideDownSelector: (BOOL) hasSlider hasDisclosure: (BOOL) hasDisclosure;

@end
