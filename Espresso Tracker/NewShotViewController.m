//
//  FirstViewController.m
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 10/17/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.


#import "NewShotViewController.h"
#import "SliderTableViewCell.h"
#import "DecimalPickerCell.h"
#import "DataStore.h"
#import "Beans.h"
#import "Beans+Custom.h"
#import "Variable.h"
#import "Shot.h"
#import "Shot+Custom.h"
#import "ShotData.h"

#define kSliderTag 1 //View tag identifing the slider view
#define kDecimalPickerTag 2 //View tag identifing the decimal picker view


//Labels and keys for obtaining shot attributes
#define kBeansNameKey                   @"Beans Name"
#define kBeansRoasterKey                @"Roaster"
#define kBeansRegionKey                 @"Region"
#define kBeansRoastDateKey              @"Roast Date"
#define kBeanAgeInDaysKey               @"Bean Age In Days"
#define kDatePulledKey                  @"Date Pulled"
#define kEspressoVolumeInFluidOuncesKey @"Espresso Volume in Fluid Ounces"
#define kEspressoVolumeInMLKey          @"Espresso Volume In ML"
#define kEspressoWeightInGramsKey       @"Espresso Weight In Grams"
#define kEspressoWeightInOuncesKey      @"Espresso Weight In Ounces"
#define kGroundsWeightInGramsKey        @"Grounds Weight In Grams"
#define kGroundsWeightInOuncesKey       @"Grounds Weight In Ounces"
#define kPullTimeInSecondsKey           @"Pull Time In Seconds"

//Labels and keys for obtaining shot profile attributes
#define kAcidicKey      @"Acidity"
#define kAftertasteKey  @"Aftertaste"
#define kBitterKey      @"Bitterness"
#define kBodyKey        @"Body"
#define kBrightKey      @"Brightness"
#define kCremaKey       @"Creama"
#define kMouthfeelKey   @"Mouthfeel"
#define kOverallKey     @"Overall"
#define kRoundKey       @"Roundness"
#define kSmoothKey      @"Smoothness"
#define kSweetKey       @"Sweetness"


static NSString *kRightDetailCellID = @"rightDetailCell";     // basic right detail cell
static NSString *kRightDetailDisclosureCellID = @"rightDetailDisclosureCell";     // basic right detail cell with discolsure
static NSString *kSliderCellID = @"sliderCell"; //Right detail cell with a slider, used for ratings
static NSString *kDecimalPickerID = @"decimalPicker"; //Cell with a decimal picker
static NSString *kSaveButtonID = @"saveButton"; //Cell with the save button

static int decimalPickerObserverContext; //To be passed for observer context

static NSInteger numberOfCellsBeforeVariables = 1; //The number of static rows (such as the coffee used) that come before the set of variables to be displayed.

#pragma mark -

@interface NewShotViewController ()

@property (nonatomic) DataStore *sharedDataStore;
@property (nonatomic) ShotData *data;
@property (nonatomic) NSManagedObjectContext *context;

//@property (nonatomic, strong) NSMutableArray *userRoutineDataArray;

// keep track which indexPath points to the slide-out selector
@property (nonatomic, strong) NSIndexPath *slideOutIndexPath;

@property (assign) NSInteger sliderCellRowHeight;
@property (assign) NSInteger decimalPickerCellRowHeight;

@property (weak, nonatomic) IBOutlet UILabel *sliderTitle;
@property (weak, nonatomic) IBOutlet UILabel *sliderValueLable;

//Used to keep track of the current decimal picker cell. There should only be one at a time.
@property (nonatomic) DecimalPickerCell *currentDecimalPickerCell;




@end

#pragma mark -

@implementation NewShotViewController
    

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
#warning need to test wether or not variables of the same name belonging to two different shots are actually the same object. We need to make sure that changing the value for a new shot doesn't change the value for every other shot as well.
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];

    
    if (!self.sharedDataStore) {
        self.sharedDataStore = [DataStore sharedDataStore];
        self.data = self.sharedDataStore.data;
        self.context = self.sharedDataStore.managedObjectContext;
    }
    
    /*
     
     Steps to setup the default shot routine:
     1) Create the beans
     2) Create the variables and put them together in a set
     3) Create the shot
     4) Add the beans and variables to the shot
     5) Add the completed default shot to the shotData in the DataStore
     
     
     */
    
    //1
    Beans *beans1 = [NSEntityDescription insertNewObjectForEntityForName:@"Beans" inManagedObjectContext: self.context];
    beans1.name = @"Black Cat Espresso";
    beans1.roaster = @"Intelligentsia";
    beans1.region = @"Blend";
    beans1.roastDate = [formatter dateFromString:@"Oct 16, 2013"];
    
    //2
    Variable *doseWeight = [NSEntityDescription insertNewObjectForEntityForName:@"Variable" inManagedObjectContext: self.context];
    doseWeight.name = @"Dose Weight";
    doseWeight.value = @"18";
    doseWeight.highestValue = [NSDecimalNumber decimalNumberWithString:@"100"];
    doseWeight.lowestValue = [NSDecimalNumber decimalNumberWithString:@"0"];
    doseWeight.increment = [NSDecimalNumber decimalNumberWithString:@"0.1"];
    doseWeight.ownCellID = kRightDetailCellID;
    doseWeight.slideOutControlCellID = kDecimalPickerID;
    doseWeight.index = [NSNumber numberWithInt:0];
    
    Variable *espressoWeight = [NSEntityDescription insertNewObjectForEntityForName:@"Variable" inManagedObjectContext: self.context];
    espressoWeight.name = @"Espresso Weight";
    espressoWeight.value = @"30";
    espressoWeight.highestValue = [NSDecimalNumber decimalNumberWithString:@"100"];
    espressoWeight.lowestValue = [NSDecimalNumber decimalNumberWithString:@"0"];
    espressoWeight.increment =  [NSDecimalNumber decimalNumberWithString:@"0.1"];
    espressoWeight.ownCellID = kRightDetailCellID;
    espressoWeight.slideOutControlCellID = kDecimalPickerID;
    espressoWeight.index = [NSNumber numberWithInt:1];
    
    Variable *overallTaste = [NSEntityDescription insertNewObjectForEntityForName:@"Variable" inManagedObjectContext: self.context];
    overallTaste.name = @"Overall Taste";
    overallTaste.value = @"0";
    overallTaste.highestValue = [NSDecimalNumber decimalNumberWithString:@"5"];
    overallTaste.lowestValue = [NSDecimalNumber decimalNumberWithString:@"0"];
    overallTaste.increment =  [NSDecimalNumber decimalNumberWithString:@"1"];
    overallTaste.ownCellID = kSliderCellID;
    overallTaste.slideOutControlCellID = nil;
    overallTaste.index = [NSNumber numberWithInt:2];
    
    Variable *sourness = [NSEntityDescription insertNewObjectForEntityForName:@"Variable" inManagedObjectContext: self.context];
    sourness.name = @"Sourness";
    sourness.value = @"0";
    sourness.highestValue = [NSDecimalNumber decimalNumberWithString:@"5"];
    sourness.lowestValue = [NSDecimalNumber decimalNumberWithString:@"0"];
    sourness.increment =  [NSDecimalNumber decimalNumberWithString:@"1"];
    sourness.ownCellID = kSliderCellID;
    sourness.slideOutControlCellID = nil;
    sourness.index = [NSNumber numberWithInt:3];
    
    //3
    NSSet *variables = [NSSet setWithObjects:doseWeight, espressoWeight, overallTaste, sourness, nil];
    
    //4
    Shot *defaultRoutine = [NSEntityDescription insertNewObjectForEntityForName:@"Shot" inManagedObjectContext:self.context];
    defaultRoutine.datePulled = [NSDate date];
    defaultRoutine.beans = beans1;
    defaultRoutine.variables = variables;
    
    //(5)
    self.sharedDataStore.data.defaultRoutine = defaultRoutine;
    
#warning TODO: hard-coded userRoutine. Eventually userRoutine needs to be the user's customized routine.
    self.sharedDataStore.data.userRoutine = defaultRoutine;
    
    
    /*##############################################*/
    //                  SAVE THE USER ROUTINE
    
    
    
    /*##############################################*/
    
    
    
    
    
    // obtain view cell's height for each type of cell, works because the cell was pre-defined in our storyboard
    UITableViewCell *cellToCheck = [self.tableView dequeueReusableCellWithIdentifier:kSliderCellID];
    self.sliderCellRowHeight = cellToCheck.frame.size.height;
    cellToCheck = [self.tableView dequeueReusableCellWithIdentifier:kDecimalPickerID];
    self.decimalPickerCellRowHeight = cellToCheck.frame.size.height;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ((context == &decimalPickerObserverContext) && [keyPath isEqualToString:@"value"] && (self.slideOutIndexPath != nil)) {
        //The value of the pickerCell has changed. Update the cell above to reflect the chosen value.
        NSIndexPath *pathForCellAbovePicker = [NSIndexPath indexPathForRow:self.slideOutIndexPath.row - 1 inSection:0];
        UITableViewCell *cellAbovePicker = [self.tableView cellForRowAtIndexPath:pathForCellAbovePicker];
        DecimalPickerCell *decimalPicker = (DecimalPickerCell *)object;
        cellAbovePicker.detailTextLabel.text = [NSString stringWithFormat:@"%@", decimalPicker.value.stringValue];
    }
}

/*! Determines if the UITableViewController has a UIDatePicker in any of its cells.
 */
- (BOOL)hasSlideOutSelector //Helper method
{
    return (self.slideOutIndexPath != nil);
}

/*! Determines if the given indexPath points to a cell that contains the DecimalPicker.
 
 @param indexPath The indexPath to check if it represents a cell with the DecimalPicker.
 */
- (BOOL)indexPathHasSelector:(NSIndexPath *)indexPath //Helper method
{
    return ([self hasSlideOutSelector] && self.slideOutIndexPath.row == indexPath.row);
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowHeight;
    if ([self indexPathHasSelector:indexPath]) {
        rowHeight = self.decimalPickerCellRowHeight;
    }
    else
    {
        Variable *cellToCheck = [self variableForTableRow:indexPath];
        if ([cellToCheck.ownCellID isEqualToString:kSliderCellID]) {
            rowHeight = self.sliderCellRowHeight;
        } else {
            rowHeight = self.tableView.rowHeight;
        }
    }
    return rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *newCell = nil;
    /*
     For the first static row (the one that displays the beans used), just create the cell and return it. Then iterate through the set of variables and return the cell just like we did before with the array of CellData objects
     */
    
    //Display coffee used for the first row:
    if (indexPath.row == 0) {
        newCell = [tableView dequeueReusableCellWithIdentifier:kRightDetailDisclosureCellID];
        
        Beans *beansUsed = self.sharedDataStore.data.userRoutine.beans;
        newCell.textLabel.text = beansUsed.name;
        
        NSInteger beanAge = [beansUsed daysSinceRoast];
        newCell.detailTextLabel.text = [NSString stringWithFormat:@"%i days old", beanAge];
        
#warning TODO: point the discolsure indicator to the coffee picking screen
    }
    
    //IMPORTANT: IF ADDING STATIC ROWS ABOVE THE VARIABLES BLOCK, BE SURE TO UPDATE THE numberOfCellsBeforeVariables VARIABLE ABOVE!!!
    
    //Determine if this is the cell containing the slide-out picker control
    else if ([self indexPathHasSelector:indexPath])
    {
        newCell = [tableView dequeueReusableCellWithIdentifier:kDecimalPickerID];
        
        //Add observer, so that we can update the cell above whenever the value changes. This is necessary since we decided to put the delegate methods inside DecimalPickerCell instead of here in the view controller.
        self.currentDecimalPickerCell = (DecimalPickerCell *)newCell;
        //NSLog(@"address for newPicker: %@", newDecimalPickerCell);
        [self.currentDecimalPickerCell addObserver:self forKeyPath:@"value" options:(NSKeyValueObservingOptionNew) context:&decimalPickerObserverContext];
    }
    //Determine if this is a variable cell:
    else if ([self variableForTableRow:indexPath])
    {
        //Find the variable corresponding to this tableView cell:
        Variable *var = [self variableForTableRow:indexPath];
    
        //Create the cell
        newCell = [tableView dequeueReusableCellWithIdentifier:var.ownCellID];
    
        if ([var.ownCellID isEqualToString:kRightDetailCellID]) {
            newCell.textLabel.text = var.name;
            newCell.detailTextLabel.text = var.value;
        }
    
        if ([var.ownCellID isEqualToString:kRightDetailDisclosureCellID])
        {
            // This cell has a disclosure button
            // TO-DO: point the disclosure button to the proper screen
            newCell.textLabel.text = var.name;
            newCell.detailTextLabel.text = var.value;
        }
        
        if ([var.ownCellID isEqualToString:kSliderCellID])
        {
            //Set the slider to the default value
            SliderTableViewCell *sliderCell = (SliderTableViewCell *)newCell;
            sliderCell.value.text = var.value;
            sliderCell.title.text = var.name;
            sliderCell.slider.value = [var.value floatValue];
        }
    }
    //After all other cells, display the save button
    else
    {
        newCell = [tableView dequeueReusableCellWithIdentifier:kSaveButtonID];
    }
    return newCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numRows = self.data.userRoutine.variables.count + numberOfCellsBeforeVariables;
    numRows++;//Add one more for the save button at the bottom
    if ([self hasSlideOutSelector]) {
        // we have a slide-out selection cell, so allow for it in the number of rows in this section
        numRows++;
    }
    return numRows;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*! Adds or removes a DecimalPicker cell below the given indexPath.
 
 @param indexPath The indexPath to reveal the DecimalPickerCell.
 */
- (void)toggleDecimalPickerForSelectedIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView beginUpdates];
    
    NSArray *indexPaths = @[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0]];
    
    // check if 'indexPath' has an attached date picker below it
    if ([self hasPickerForIndexPath:indexPath])
    {
        // found a picker below it, so remove it
        [self.tableView deleteRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        // didn't find a picker below it, so we should insert it
        [self.tableView insertRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [self.tableView endUpdates];
}

/*! Determines if the given indexPath has a cell below it with a UIPickerView.
 
 @param indexPath The indexPath to check if its cell has a UIPickerView below it.
 */
- (BOOL)hasPickerForIndexPath:(NSIndexPath *)indexPath
{
    BOOL hasDecimalPicker = NO;
    
    NSInteger targetedRow = indexPath.row;
    targetedRow++;
    
    UITableViewCell *checkDecimalPickerCell =
    [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:targetedRow inSection:0]];
    UIPickerView *checkDecimalPicker = (UIPickerView *)[checkDecimalPickerCell viewWithTag:kDecimalPickerTag];
    
    hasDecimalPicker = (checkDecimalPicker != nil);
    return hasDecimalPicker;
}



/*! Updates the UIDatePicker's value to match with the date of the cell above it.
 */
- (void)updateDecimalPicker
{
    if (self.slideOutIndexPath != nil)
    {
        //This is the DecimalPicker cell, typecast from the UITableViewCell.
        DecimalPickerCell *decimalPickerCell = (DecimalPickerCell *)[self.tableView cellForRowAtIndexPath:self.slideOutIndexPath];
        
        //Get the data from the Cell above the Picker (the picker's "owner")
        NSInteger rowAbove = self.slideOutIndexPath.row - 1;
        NSIndexPath *indexPathForCellAbovePicker = [NSIndexPath indexPathForRow:rowAbove inSection:0];
        UITableViewCell *cellAbovePicker = [self.tableView cellForRowAtIndexPath:indexPathForCellAbovePicker];
        
        //This sets the value property in the custom class we made for DecimalPickers
        decimalPickerCell.value = [NSDecimalNumber decimalNumberWithString: cellAbovePicker.detailTextLabel.text];
    }
}



/*! Toggles the picker on and off inline for the given indexPath, called by "didSelectRowAtIndexPath".
 
 @param indexPath The indexPath to reveal the UIDatePicker.
 */


- (void)toggleDecimalPickerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // display the date picker inline with the table content
    [self.tableView beginUpdates];
    
    BOOL existingPickerIsAbove = NO;   // indicates if any existing picker is below "indexPath", help us determine which row to reveal
    if ([self hasSlideOutSelector])
    {
        existingPickerIsAbove = self.slideOutIndexPath.row < indexPath.row;
    }
    
    BOOL sameCellClicked = (self.slideOutIndexPath.row - 1 == indexPath.row);
    
    //We always want to remove any existing picker cell, because there should be only one at a time.
    if ([self hasSlideOutSelector])
    {
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.slideOutIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        [self.currentDecimalPickerCell removeObserver:self forKeyPath:@"value" context:&decimalPickerObserverContext];
        self.slideOutIndexPath = nil;
    }
    
    //If sameCellClicked, we have already closed the selector
    if (!sameCellClicked)
    {
        // Display the new one
        NSInteger ownerIndex = (existingPickerIsAbove ? indexPath.row - 1 : indexPath.row);
        NSIndexPath *ownerIndexPath = [NSIndexPath indexPathForRow:ownerIndex inSection:0];
        
        //[self toggleDecimalPickerForSelectedIndexPath:indexPathToReveal];
        
        
        /*********
         
         //If sameCellClicked, we have already closed the selector
         if (!sameCellClicked)
         {
         // Display the new one
         NSInteger rowToReveal = (before ? indexPath.row - 1 : indexPath.row);
         NSIndexPath *indexPathToReveal = [NSIndexPath indexPathForRow:rowToReveal inSection:0];
         
         [self toggleDecimalPickerForSelectedIndexPath:indexPathToReveal];
         self.slideOutIndexPath = [NSIndexPath indexPathForRow:indexPathToReveal.row + 1 inSection:0];
         }

         
         */
        
        
        NSArray *selectorPath = @[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0]];
        [self.tableView insertRowsAtIndexPaths:selectorPath
                              withRowAnimation:UITableViewRowAnimationFade];
        
        self.slideOutIndexPath = [NSIndexPath indexPathForRow:ownerIndexPath.row + 1 inSection:0];
    }
    
    // always deselect the row that owns the selector
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //ending updates causes cellForIndexPath to be called to populate the cell we just inserted.
    [self.tableView endUpdates];
    
    // inform our picker of the current date to match the current cell
    [self updateDecimalPicker];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Variable *var = [self variableForTableRow:indexPath];

    //If this is the DecimalPicker Cell
    if ([var.slideOutControlCellID isEqualToString:kDecimalPickerID])
    {
            [self toggleDecimalPickerForRowAtIndexPath:indexPath];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

//Returns the index of the variable that should be loaded in a given indexPath of the TableView
- (NSInteger) variableIndexForTableRow:(NSIndexPath *) tableRow
{
    /*
     There are two things that offset the TableRow index from the Variable index:
     1) Any cells above the block of variable cells
     2) If a slide-out picker is open at any point above the particular table index, this pushes every variable below it down.
     */
    NSInteger varIndex = tableRow.row;
    
    // 1
    varIndex -= numberOfCellsBeforeVariables;
    
    // 2
    if (self.slideOutIndexPath != nil && self.slideOutIndexPath.row < tableRow.row)
    {
        varIndex--; //Now modelRow will match the appropriate index in the userRoutineDataArray
    }
    
    return varIndex;
}

//Returns the variable corresponding to the table row, from the user's custom routine
- (Variable *) variableForTableRow:(NSIndexPath *) tableRow
{
    NSInteger varIndex = [self variableIndexForTableRow:tableRow];
    return [self.data.userRoutine variableForIndex:varIndex];
}


@end
