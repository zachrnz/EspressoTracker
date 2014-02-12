//
//  FirstViewController.m
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 10/17/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//
//NEXT TASK: WORK ON THE SLIDE OUT SELECTORS, MAKE THEM DISPLAY

#import "FirstViewController.h"
#import "ItemCell.h"
#import "SliderTableViewCell.h"
#import "DecimalPickerCell.h"

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

//Used to associate keys with ItemCells.
static NSDictionary *keyToItemCellAttributes;

#pragma mark -

@interface FirstViewController ()

@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSMutableArray *userRoutineDataArray;

// keep track which indexPath points to the slide-out selector
@property (nonatomic, strong) NSIndexPath *slideOutIndexPath;

@property (assign) NSInteger sliderCellRowHeight;
@property (assign) NSInteger decimalPickerCellRowHeight;

@property (weak, nonatomic) IBOutlet UILabel *sliderTitle;
@property (weak, nonatomic) IBOutlet UILabel *sliderValueLable;

@end

#pragma mark -

@implementation FirstViewController

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
    
    
    // test the DecimalPicker logic
     
    DecimalPickerCell *decimalPicker = [[DecimalPickerCell alloc] init];
    
    NSLog(@"Set 12.3 in value");
    decimalPicker.value = [NSDecimalNumber decimalNumberWithString:@"12.3"];
    NSLog(@"value: %@", decimalPicker.value.stringValue);
    NSLog(@"ones place: %i", decimalPicker.onesPlace);
    NSLog(@"tenths place: %i", decimalPicker.tenthsPlace);
    
    NSLog(@"Set 32 in ones place");
    decimalPicker.onesPlace = 32;
    NSLog(@"value: %@", decimalPicker.value.stringValue);
    NSLog(@"ones place: %i", decimalPicker.onesPlace);
    NSLog(@"tenths place: %i", decimalPicker.tenthsPlace);
    
    NSLog(@"set 4 in tenths place");
    decimalPicker.tenthsPlace = 4;
    NSLog(@"value: %@", decimalPicker.value.stringValue);
    NSLog(@"ones place: %i", decimalPicker.onesPlace);
    NSLog(@"tenths place: %i", decimalPicker.tenthsPlace);
    
    NSLog(@"Set 12.55 in value");
    decimalPicker.value = [NSDecimalNumber decimalNumberWithString:@"12.55"];
    NSLog(@"value: %@", decimalPicker.value.stringValue);
    NSLog(@"ones place: %i", decimalPicker.onesPlace);
    NSLog(@"tenths place: %i", decimalPicker.tenthsPlace);
    
   
    
    
    
    /*
     
     1. Look at preferences array and determine what cells are necessary
        a. preferences array is an array of keys
     2. Create ordered array of ItemCell objects containing all information required to create the appropriate cell
        a. Use a switch statment to create an appropriate ItemCell for each possible key from the preferances array
        b. Alternatively, would it be better to directly store an array of ItemCells in preferences?
     3. As cellForRowAtIndexPath is called, return an actual UITableViewCell created from the appropriate ItemCell object
        a. Need to know from whatever cells array I use what type of prototype cell to dequeue. This will require either a switch statment in the cellForRowAtIndexPath method, or using an array of ItemCells.
     
     
     Referring to (2) above: Yes, I think...this would eliminate all of the dictionaries and allow itemCell to contain everything needed.
     */
    

    
    //Define required cell type for each variable.
    //TO-DO: Create a persistency class. This class should create and store a list of all default ItemCells, as well as an array of containing only those in the custom user routine.
    ItemCell *beansName = [ItemCell itemCellWithTitle:kBeansNameKey cellID:kRightDetailDisclosureCellID detail:@"Black Cat Espresso" selectorCellID:nil hasDisclosure:YES];
    ItemCell *groundsWeightInGrams = [ItemCell itemCellWithTitle:kGroundsWeightInGramsKey cellID:kRightDetailCellID detail:@"20.0" selectorCellID:kDecimalPickerID hasDisclosure:NO];
    ItemCell *overallRating = [ItemCell itemCellWithTitle:kOverallKey cellID:kSliderCellID detail:@"1" selectorCellID:nil hasDisclosure:NO];
    
    //Array containing the ordered list of variables seleceted by the user for recording. This should eventually be loaded from the preferences file. This is an array of keys, each key corresponding to the ItemCellAttributes stored in the keyToItemCellAttributes dictionary
    self.userRoutineDataArray = [@[beansName, groundsWeightInGrams, overallRating] mutableCopy];
    
    // obtain view cell's height for each type of cell, works because the cell was pre-defined in our storyboard
    UITableViewCell *cellToCheck = [self.tableView dequeueReusableCellWithIdentifier:kSliderCellID];
    self.sliderCellRowHeight = cellToCheck.frame.size.height;
    cellToCheck = [self.tableView dequeueReusableCellWithIdentifier:kDecimalPickerID];
    self.decimalPickerCellRowHeight = cellToCheck.frame.size.height;
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString: @"value"]) {
//        NSLog(@"TRIGGERED");
//    } else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"value"]) {
        //The value of the pickerCell has changed. Update the cell above to reflect the chosen value.
        if (self.slideOutIndexPath != nil)
        {
            NSIndexPath *pathForCellAbovePicker = [NSIndexPath indexPathForRow:self.slideOutIndexPath.row - 1 inSection:0];
            UITableViewCell *cellAbovePicker = [self.tableView cellForRowAtIndexPath:pathForCellAbovePicker];
            DecimalPickerCell *decimalPicker = (DecimalPickerCell *)object;
            cellAbovePicker.detailTextLabel.text = [NSString stringWithFormat:@"%@", decimalPicker.value.stringValue];
        }
    }
}

#pragma mark - Utilities

///*! Returns the major version of iOS, (i.e. for iOS 6.1.3 it returns 6)
// */
//NSUInteger DeviceSystemMajorVersion()
//{
//    static NSUInteger _deviceSystemMajorVersion = -1;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
//    });
//    
//    return _deviceSystemMajorVersion;
//}

//#define EMBEDDED_DATE_PICKER (DeviceSystemMajorVersion() >= 7)

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
        NSInteger modelRow = [self modelRowForIndexPath:indexPath];
        ItemCell *cellToCheck = self.userRoutineDataArray[modelRow];
        if ([cellToCheck.cellID isEqualToString:kSliderCellID]) {
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
    
    //Determine if this is the cell with a slide-out control
    if ([self indexPathHasSelector:indexPath])
    {
        //The data for the cell which contains the value the selector is used to set.
        ItemCell *selectorOwner = self.userRoutineDataArray[indexPath.row-1];
        
        //The cellID for the prototype cell
        NSString *newCellID = selectorOwner.selectorCellID;
        
        //Create the new cell
        newCell = [tableView dequeueReusableCellWithIdentifier:newCellID];
        
        //Add observer, so that we can update the cell above whenever the value changes. This is necessary since we decided to put the delegate methods inside DecimalPickerCell instead of here in the view controller. 
        DecimalPickerCell *newDecimalPickerCell = (DecimalPickerCell *)newCell;
        //NSLog(@"address for newPicker: %@", newDecimalPickerCell);
        
        //Because we are always using the same instance of the DecimalPickerCell, we only want to add the observer once.
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            [newDecimalPickerCell addObserver:self forKeyPath:@"value" options:(NSKeyValueObservingOptionNew) context:NULL];
        });

        
        
        
        //We ONLY need to return the correct prototype cell (with the right cellID) at this point. Initializing the fields happens elsewhere. In this case, the DecimalPicker's value is set in "UpdateDecimalPicker"
        /*
        //Set the initial value displayed in the selector
        if ([newCellID isEqualToString:kDecimalPickerID])
        {
            //Setup decimal picker cell
            DecimalPickerCell *newDecimalPickerCell = (DecimalPickerCell *)newCell;
            //Get the value from the cell above
            UITableViewCell *tableViewCellAbove = [self.tableView cellForRowAtIndexPath:<#(NSIndexPath *)#>
            ItemCell *cellData = self.userRoutineDataArray[indexPath.row - 1];
            
            
            
            if (newDecimalPickerCell.value == nil) {
                            newDecimalPickerCell.value = [NSNumber numberWithFloat:cellData.detail. floatValue];
                
//                //These are the two individual pickers that make up the two sides (integer, and tenths parts) of the decimal picker.
//                //They are extracted from the DecimalPickerCell using their tags.
//                UIPickerView *integerPartPicker = (UIPickerView *) [newDecimalPickerCell viewWithTag: kIntegerPartPickerTag];
//                UIPickerView *tenthsPartPicker = (UIPickerView *) [newDecimalPickerCell viewWithTag: kTenthsPartPickerTag];
//                
//                //Now set the selected rows in the pickers to match the value in the cell above
//                [integerPartPicker selectRow:newDecimalPickerCell.onesPlace inComponent:0 animated:NO];
//                [tenthsPartPicker selectRow:newDecimalPickerCell.tenthsPlace inComponent:0 animated:NO];
            }
            
            NSLog(@"value: %@", newDecimalPickerCell.value.stringValue);
            NSLog(@"integer part %i", newDecimalPickerCell.onesPlace);
            NSLog(@"tenths part %i", newDecimalPickerCell.tenthsPlace);
            
            
            
         
        }
        */
    }
    else //This is a regular cell, not a selector.
    {
        // if we have a date picker open whose cell is above the cell we want to update,
        // then we have one more cell than the model allows
        NSInteger modelRow = indexPath.row;
        if (self.slideOutIndexPath != nil && self.slideOutIndexPath.row < indexPath.row)
        {
            modelRow--; //Now modelRow will match the appropriate index in the userRoutineDataArray
        }
        
        ItemCell *itemCell = self.userRoutineDataArray[modelRow];
    
        //Create the cell
        newCell = [tableView dequeueReusableCellWithIdentifier:itemCell.cellID];
    
        if ([itemCell.cellID isEqualToString:kRightDetailCellID]) {
            newCell.textLabel.text = itemCell.title;
            newCell.detailTextLabel.text = itemCell.detail;
        }
    
        if ([itemCell.cellID isEqualToString:kRightDetailDisclosureCellID])
        {
            // This cell has a disclosure button
            // TO-DO: point the disclosure button to the proper screen
            newCell.textLabel.text = itemCell.title;
            newCell.detailTextLabel.text = itemCell.detail;
        }
        
        if ([itemCell.cellID isEqualToString:kSliderCellID])
        {
            //Set the slider to the default value
            SliderTableViewCell *sliderCell = (SliderTableViewCell *)newCell;
            sliderCell.value.text = itemCell.detail;
            sliderCell.title.text = itemCell.title;
            sliderCell.slider.value = itemCell.detail.floatValue;
        }
    }
    return newCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numRows = self.userRoutineDataArray.count;
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


/*! Adds or removes a UIDatePicker cell below the given indexPath.
 
 @param indexPath The indexPath to reveal the UIDatePicker.
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
        
        //These are the two individual pickers that make up the two sides (integer, and tenths parts) of the decimal picker.
        //They are extracted from the DecimalPickerCell using their tags.
        //UIPickerView *integerPartPicker = (UIPickerView *) [decimalPickerCell viewWithTag: kIntegerPartPickerTag];
        //UIPickerView *tenthsPartPicker = (UIPickerView *) [decimalPickerCell viewWithTag: kTenthsPartPickerTag];
        
        //Get the data from the Cell above the Picker (the picker's "owner")
        NSInteger rowAbove = self.slideOutIndexPath.row - 1;
        NSIndexPath *indexPathForCellAbovePicker = [NSIndexPath indexPathForRow:rowAbove inSection:0];
        UITableViewCell *cellAbovePicker = [self.tableView cellForRowAtIndexPath:indexPathForCellAbovePicker];
        
        //This sets the value property in the custom class we made for DecimalPickers
        decimalPickerCell.value = [NSDecimalNumber decimalNumberWithString: cellAbovePicker.detailTextLabel.text];
        //NSLog(@"DecimalPickerValue: %@", decimalPickerCell.value.stringValue);
        //But we need to manually update the pickers?? (Or do we need to do this in the accessor methods?
        
        //These are the two individual pickers that make up the two sides (integer, and tenths parts) of the decimal picker.
        //They are extracted from the DecimalPickerCell using their tags.
        UIPickerView *integerPartPicker = (UIPickerView *) [decimalPickerCell viewWithTag: kIntegerPartPickerTag];
        UIPickerView *tenthsPartPicker = (UIPickerView *) [decimalPickerCell viewWithTag: kTenthsPartPickerTag];
        
//#error where I left off
        
        //THESE LINES DON'T ACTUALLY WORK FOR SETTING THE PICKERS, BUT WHEN THEY ARE COMMENTED OUT, THE VALUE IN THE CELL ABOVE DOESN'T UPDATE...WHAT THE $*&^#??? UPDATE: ACTUALLY, THIS ERROR SEEMS TO GO AWAY IF YOU JUST BUILD-RUN ONE MORE TIME...DOESN'T REALLY MAKE SENCE EITHER...
        //Now set the selected rows in the pickers to match the value in the cell above
       
        NSLog(@"decimalPicker.value: %@", decimalPickerCell.value.stringValue);
        NSLog(@"decimalPicker.integer: %i", decimalPickerCell.onesPlace);
        NSLog(@"decimalPicker.tenths: %i", decimalPickerCell.tenthsPlace);

        
        [integerPartPicker selectRow:decimalPickerCell.onesPlace inComponent:0 animated:NO];
        [tenthsPartPicker selectRow:decimalPickerCell.tenthsPlace inComponent:0 animated:NO];
        
        //We are definitely sending the right numbers, but it still doesn't change the setting:
        //[integerPartPicker selectRow:20 inComponent:0 animated:NO];
        //[tenthsPartPicker selectRow:0 inComponent:0 animated:NO];
        
        NSLog(@"Selcted row in integerPicker: %i", [integerPartPicker selectedRowInComponent:0]);
        NSLog(@"Selcted row in tenthsPicker: %i", [tenthsPartPicker selectedRowInComponent:0]);
        
        
        [integerPartPicker reloadAllComponents];
        [tenthsPartPicker reloadAllComponents];
        
    }
}



/*! Reveals the date picker inline for the given indexPath, called by "didSelectRowAtIndexPath".
 
 @param indexPath The indexPath to reveal the UIDatePicker.
 */


- (void)displayDecimalPickerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // display the date picker inline with the table content
    [self.tableView beginUpdates];
    
    BOOL before = NO;   // indicates if the date picker is below "indexPath", help us determine which row to reveal
    if ([self hasSlideOutSelector])
    {
        before = self.slideOutIndexPath.row < indexPath.row;
    }
    
    BOOL sameCellClicked = (self.slideOutIndexPath.row - 1 == indexPath.row);
    
    // remove any date picker cell if it exists
    if ([self hasSlideOutSelector])
    {
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.slideOutIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.slideOutIndexPath = nil;
    }
    
    //If sameCellClicked, we have already closed the selector
    if (!sameCellClicked)
    {
        // Display the new one
        NSInteger rowToReveal = (before ? indexPath.row - 1 : indexPath.row);
        NSIndexPath *indexPathToReveal = [NSIndexPath indexPathForRow:rowToReveal inSection:0];
        
        [self toggleDecimalPickerForSelectedIndexPath:indexPathToReveal];
        self.slideOutIndexPath = [NSIndexPath indexPathForRow:indexPathToReveal.row + 1 inSection:0];
    }
    
    // always deselect the row containing the start or end date
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //ending updates causes cellForIndexPath to be called to populate the cell we just inserted.
    [self.tableView endUpdates];
    
    // inform our date picker of the current date to match the current cell
    [self updateDecimalPicker];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 //   UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSInteger modelIndex = [self modelRowForIndexPath:indexPath];
    ItemCell *cellData = self.userRoutineDataArray[modelIndex];
    
    if ([cellData.selectorCellID isEqualToString:kDecimalPickerID])
    {
            [self displayDecimalPickerForRowAtIndexPath:indexPath];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}


- (NSInteger) modelRowForIndexPath:(NSIndexPath *) indexPath
{
    NSInteger modelRow = indexPath.row;
    if (self.slideOutIndexPath != nil && self.slideOutIndexPath.row < indexPath.row)
    {
        modelRow--; //Now modelRow will match the appropriate index in the userRoutineDataArray
    }
    return modelRow;
}




@end
