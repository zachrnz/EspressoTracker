//
//  DecimalPickerCell.h
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 11/21/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kIntegerPartPickerTag 1 //View tag identifing the integer part picker (left side of the decimal picker)
#define kTenthsPartPickerTag 2 //View tag identifing the tenths part picker (right side of the decimal picker)

@interface DecimalPickerCell : UITableViewCell <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *integerPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *fractionPicker;
@property (nonatomic, copy) NSDecimalNumber *value; //This needs to be an object so that KVC will work
@property (nonatomic) NSInteger onesPlace;
@property (nonatomic) NSInteger tenthsPlace;

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end
