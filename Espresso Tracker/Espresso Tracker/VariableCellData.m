//
//  VariableCellData.m
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 11/3/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import "VariableCellData.h"

@implementation VariableCellData

- (id)init
{
    return [self initWithTitle:nil cellID:nil detail:nil selectorCellID:nil hasDisclosure:NO];
}

- (id)initWithTitle: (NSString *) title cellID: (NSString *) cellID detail: (NSString *) detail selectorCellID: (NSString *) selectorCellID hasDisclosure: (BOOL) hasDisclosure
{
    self = [super init];
    if (self) {
        _title = title;
        _cellID = cellID;
        _detail = detail;
        _selectorCellID = selectorCellID;
        _hasDisclosure = hasDisclosure;
    }
    return self;
}

+ (VariableCellData *) itemCellWithTitle: (NSString *) title cellID: (NSString *) cellID detail: (NSString *) detail selectorCellID: (NSString *) selectorCellID hasDisclosure: (BOOL) hasDisclosure
{
    return [[VariableCellData alloc] initWithTitle:title cellID:cellID detail:detail selectorCellID:selectorCellID hasDisclosure:hasDisclosure];
}


@end
