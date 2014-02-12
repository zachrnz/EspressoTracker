//
//  DecimalPickerCell.m
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 11/21/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import "DecimalPickerCell.h"

#define kMaxIntegerOption 100 //0-100

static NSMutableArray *integerRowValues = nil; //Holds the values for the "ones" place, before the decimal
static NSMutableArray *tenthsRowValues = nil; //Holds the value for the "tenths" picker, after the decimal
static NSDecimalNumberHandler *oneDecimalPlace; //round to one decimal place
static NSDecimalNumberHandler *truncateDecimal; //truncate decimal

@implementation DecimalPickerCell

- (id)initWithCoder:(NSCoder*)coder
{
    self = [super initWithCoder:coder];
    [self initialize];
    return self;
}

- (id)init
{
    self = [super init];
    [self initialize];
    return self;
}

- (void) initialize {
    if (self) {
        if (!integerRowValues) //Arrays only needs to be setup once
        {
            integerRowValues = [[NSMutableArray alloc] init];
            tenthsRowValues = [[NSMutableArray alloc] init];
            NSString *stringValue;
            for (int row = 0; row <= kMaxIntegerOption; row++) {
                stringValue = [NSString stringWithFormat:@"%i", row];
                integerRowValues[row] = stringValue;
                if (row <= 9)
                {
                    tenthsRowValues[row] = stringValue;
                }
            }
        }
        oneDecimalPlace = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:1 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        truncateDecimal = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        _value = nil;
    }
}

/*
 Accessor methods were a bit tricky for this one. Because they are all interdependant, it is easy to creat an infinite loop by calling other accessors from inside them. It is necessary to set dependant properties, without creating looping calls to setters, but to maintain KVC compliance, we have to mannually call the "willChange" methods. 
 
 This is the method I used:
 
 Set value directly, don't bother to set parts, because they will be calculated on demand
 Get value directly
 
 Set parts, change value, don't bother to store part
 Get parts, calculate from value

 I like this method because it didn't require changing IVARs outside of their setters, which would also have required adding all of the KVC methods.
 */


- (void)setValue:(NSDecimalNumber *)value {
    _value = value;
    [self setPickersToMatchCurrentValue];
}

- (void)setTenthsPlace:(NSInteger)tenths
{
    NSAssert((tenths >= 0) && (tenths <= 9), @"Tenths place must be a single digit (0-9)");
    
    //Calculate new decimal part
    NSString *tenthsString = [NSString stringWithFormat:@"%i", tenths];
    NSDecimalNumber *tenthsDecimalNumber = [NSDecimalNumber decimalNumberWithString:tenthsString];
    NSDecimalNumber *fractionalPartOfValue = [tenthsDecimalNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10.0"] withBehavior:oneDecimalPlace];
    
    //Remove decimal part from old value
    NSDecimalNumber *integerPartOfValue = [self.value decimalNumberByRoundingAccordingToBehavior:truncateDecimal];
    
    //Add new decimal part to old integer part to create new value
    self.value = [integerPartOfValue decimalNumberByAdding:fractionalPartOfValue];
    
    [self setPickersToMatchCurrentValue];
}

- (void)setOnesPlace:(NSInteger)integer
{
    NSAssert((integer >= 0) && (integer <= 100), @"must be between 0 and 100, since there are only 101 rows in the selector wheel");
    //Convert all required pieces of the number to decimal numbers, to keep exact values.

    NSDecimalNumber *oldIntegerPart = [self.value decimalNumberByRoundingAccordingToBehavior:truncateDecimal];
    
    NSString *newIntegerPartString = [NSString stringWithFormat:@"%i", integer];
    NSDecimalNumber *newIntegerPart = [NSDecimalNumber decimalNumberWithString:newIntegerPartString];
    
    //Remove old integer part to get the decimal part
    NSDecimalNumber *decimalPart = [self.value decimalNumberBySubtracting:oldIntegerPart];
    
    //Add new integer part to old decimal part, to get the new value
    NSDecimalNumber *newValue = [decimalPart decimalNumberByAdding:newIntegerPart];
    
    self.value = newValue;
    
    [self setPickersToMatchCurrentValue];
}


- (NSInteger)tenthsPlace {
    NSDecimalNumber *integerPart = [self.value decimalNumberByRoundingAccordingToBehavior:truncateDecimal];
    NSDecimalNumber *decimalPart = [self.value decimalNumberBySubtracting:integerPart];
    NSDecimalNumber *tenths = [decimalPart decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"10"]];
    return tenths.integerValue;
}

- (NSInteger)onesPlace {
    return [self.value decimalNumberByRoundingAccordingToBehavior:truncateDecimal].integerValue;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//Helper method
- (void)setPickersToMatchCurrentValue {
    [self.integerPicker selectRow:self.onesPlace inComponent:0 animated:NO];
    [self.fractionPicker selectRow:self.tenthsPlace inComponent:0 animated:NO];
}

//DataSource Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger rows = 0;
    if (pickerView.tag == kIntegerPartPickerTag) {
        rows = kMaxIntegerOption + 1; //+1 to include room for 0
    } else if (pickerView.tag == kTenthsPartPickerTag) {
        rows = 10; //0-9
    }
    return rows;
}


//Delegate methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title;
    if (pickerView.tag == kIntegerPartPickerTag) {
        title = integerRowValues[row];
    } else if (pickerView.tag == kTenthsPartPickerTag) {
        title = tenthsRowValues[row];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == kIntegerPartPickerTag) {
        self.onesPlace = row;
    } else if (pickerView.tag == kTenthsPartPickerTag) {
        self.tenthsPlace = row;
    }
}



@end
