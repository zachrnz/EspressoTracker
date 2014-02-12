//
//  SliderTableViewCell.m
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 11/21/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import "SliderTableViewCell.h"

@implementation SliderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)valueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    int roundedValue = (int)slider.value;
    self.value.text = [NSString stringWithFormat:@"%i", roundedValue];
}
@end
