//
//  DataEntryCell.m
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 11/3/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import "ItemCellAttributes.h"

@implementation ItemCellAttributes

- (id)init
{
    return [self initWithTitle:nil cellID:nil detail:nil hasSlideDownSelector:NO hasDisclosure:NO];
}

- (id)initWithTitle: (NSString *) title cellID: (NSString *) cellID detail: (NSString *) detail hasSlideDownSelector: (BOOL) hasSlider hasDisclosure: (BOOL) hasDisclosure
{
    self = [super init];
    if (self) {
        _title = title;
        _cellID = cellID;
        _detail = detail;
        _hasSlideDownSelector = hasSlider;
        _hasDisclosure = hasDisclosure;
    }
    return self;
}

+ (ItemCellAttributes *) dataEntryCellWithTitle: (NSString *) title cellID: (NSString *) cellID detail: (NSString *) detail hasSlideDownSelector: (BOOL) hasSlider hasDisclosure: (BOOL) hasDisclosure
{
    return [[ItemCellAttributes alloc] initWithTitle:title cellID:cellID detail:detail hasSlideDownSelector:hasSlider hasDisclosure:hasDisclosure];
}


@end
