//
//  SliderTableViewCell.h
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 11/21/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *value;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UISlider *slider;
- (IBAction)valueChanged:(id)sender;

@end
