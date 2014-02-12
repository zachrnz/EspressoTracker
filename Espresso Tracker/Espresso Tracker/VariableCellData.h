//
//  VariableCellData.h
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

@interface VariableCellData : NSObject

@property (nonatomic, copy) NSString *cellID;   //Identifier of the appropriate cell prototype
@property (nonatomic, copy) NSString *dataModelKey; //maps to the matching data base attribute. 
@property (nonatomic, copy) NSString *title;    //title of the cell
@property (nonatomic, copy) NSString *detail;   //detail of the cell. Used to store the last used value. 
@property (nonatomic) NSString *selectorCellID; //CellID for the selector cell displayed inline when this cell is tapped.
@property (nonatomic) BOOL hasDisclosure;       //If the cell has a disclosure indicator or not


//Designated factory method
+ (VariableCellData *) itemCellWithTitle: (NSString *) title cellID: (NSString *) cellID detail: (NSString *) detail selectorCellID: (NSString *) selectorCellID hasDisclosure: (BOOL) hasDisclosure;

@end
