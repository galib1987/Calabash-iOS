//
//  NJOPBookingViewController.m
//  Tailwind
//
//  Created by netjets on 12/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPBookingViewController.h"
#import "NJOPKeyboardControls.h"
#import "UIColor+NJOP.h"
#import "NJOPConfig.h"

@interface NJOPBookingViewController () <PDTSimpleCalendarViewDelegate>
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NJOPKeyboardControls *keyboardControls;
@property (nonatomic, strong) NSArray *customBlackoutDates;
@property (nonatomic, strong) NSArray *customPeakDates;
@property (nonatomic, strong) NSArray *customDates;
@property (strong, nonatomic) PDTSimpleCalendarViewController *calendarViewController;
@end

int passengerCount = 1;
int passengerMax = 15;
int passengerMin = 1;

NSArray* inputChain;
NSInteger currentTextField;
NSDateFormatter *timeFormatter;

UIView *calendarLegend;

@implementation NJOPBookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.allowsSelection = NO;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self initialiseTextFields];
    self.title = [@"Book a Flight" uppercaseString];
    
    
    // tap gesture to dismiss keyboard
    // we put this on any UIView that we want to be able to dismiss keyboard from
    // also copy the tapGesture method from below
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:[NJOPConfig sharedInstance] action:@selector(hideKeyboard)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialiseTextFields {
    
    inputChain = @[self.aircraftInput, self.departureAirport, self.destinationAirport, self.flightDate, self.departTime, self.numberOfPassengers, self.bookingComment];
    self.keyboardControls = [[NJOPKeyboardControls alloc] initWithInputFields:[inputChain subarrayWithRange:NSMakeRange(0, 1)]];
    self.keyboardControls.hasPreviousNext = YES;
    self.keyboardControls.inputAccessoryView.backgroundColor = [UIColor whiteColor];
    self.keyboardControls.inputAccessoryView.barTintColor = [UIColor whiteColor];
    self.keyboardControls.doneButton.tintColor = [UIColor blackColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputSwitched:) name:@"UITextFieldTextDidBeginEditingNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputSwitched:) name:@"UITextViewTextDidBeginEditingNotification" object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self.keyboardControls selector:@selector(inputSwitched) name:@"APLKeyboardControlsInputDidBeginEditingNotification" object:nil];
    
    for (int i=0; i<[inputChain count]; i++) {
        //((UIView*)inputChain[i]).tag = (NSInteger)i; // Tag fields to identify them
        if ([inputChain[i] isKindOfClass:[UITextField class]]) {
            ((UITextField*)inputChain[i]).delegate = self; // listen to textFieldDidBeginEditing
            [(UITextField*)inputChain[i] addTarget:self action:@selector(textFieldUpdated:) forControlEvents:UIControlEventEditingChanged]; // listen to changes
        }
    }
    
    self.aircraftInput.inputView = [self getAircraftPicker];
    //self.aircraftInput.inputView = [self getCalendar];
    
    self.departTime.inputView = [self getTimePicker];
    self.numberOfPassengers.inputView = [[UIView alloc] init];
    self.flightDate.inputView = [self getCalendar];
    
    self.bookingComment.placeholderTextColor = [UIColor blackColor];
    [self.bookingComment setTextContainerInset:UIEdgeInsetsMake(20, 15, 20, 15)];
    
    self.resetBooking.layer.borderWidth = 1;
    self.resetBooking.layer.borderColor = [[UIColor colorFromHexString:@"#c1f7af"] CGColor];
    
    [self.nextStep setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
    [self resetForm:self];
    
}

- (void)textFieldUpdated:(UITextField *)textField {
    if (![textField.text isEmptyOrWhitespace] && [inputChain containsObject:textField]) {
        NSUInteger textFieldIndex = [inputChain indexOfObject:textField];
        self.keyboardControls.inputFields = [inputChain subarrayWithRange:NSMakeRange(0, textFieldIndex+2)];
        UITextField *nextField = (UITextField *)inputChain[textFieldIndex+1];
        nextField.enabled = true;
        
        if (textField == self.departTime) { // if either DEPART AT or ARRIVAL BY has been entered
            self.numberOfPassengers.enabled = true;
            self.keyboardControls.inputFields = inputChain;
            // enable submit
            self.nextStep.enabled = true;
            self.nextStep.backgroundColor = [UIColor colorFromHexString:@"#b2f49e"];
        }
        
        if (nextField == self.numberOfPassengers) {
            self.addButton.enabled = self.minusButton.enabled = true;
            self.addButton.alpha = self.minusButton.alpha = 1;
        }/* else if (nextField == self.departTime) {
            // also enable arrival time selection
            self.keyboardControls.inputFields = [inputChain subarrayWithRange:NSMakeRange(0, textFieldIndex+3)];
        }*/
        
        [self.keyboardControls updateButtonsAt:textFieldIndex];
    }
}

- (IBAction)resetForm:(id)sender {
    
    self.keyboardControls.inputFields = [inputChain subarrayWithRange:NSMakeRange(0, 1)];
    
    for (int i=0; i<[inputChain count]; i++) {
        if ([inputChain[i] conformsToProtocol:@protocol(NJOPTextFieldElement)]) {
            UIView <NJOPTextFieldElement> *item = inputChain[i];
            item.text = @"";
            if (i > 0) {
                item.enabled = false;
            }
        }
    }
    self.addButton.enabled = self.minusButton.enabled = self.nextStep.enabled = false;
    self.addButton.alpha = self.minusButton.alpha = 0.75;
    self.nextStep.backgroundColor = [UIColor colorFromHexString:@"#3a3838"];
    
}

-(UIView*)getCalendar{
    if (self.calendarViewController == nil) {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
        self.customBlackoutDates = @[[dateFormatter dateFromString:@"22/01/2015"], [dateFormatter dateFromString:@"23/01/2015"], [dateFormatter dateFromString:@"24/01/2015"]];
        self.customPeakDates =  @[[dateFormatter dateFromString:@"27/01/2015"], [dateFormatter dateFromString:@"26/01/2015"], [dateFormatter dateFromString:@"25/01/2015"]];
        [[PDTSimpleCalendarViewHeader appearance] setSeparatorColor:[UIColor blackColor]];
        [[PDTSimpleCalendarViewHeader appearance] setSeparatorHeight:[NSNumber numberWithFloat:6]];
        self.calendarViewController = [[PDTSimpleCalendarViewController alloc] init];
        
        self.calendarViewController.weekHeaderEnabled = true;
        //This is the default behavior, will display a full year starting the first of the current month
        self.calendarViewController.firstDate = [NSDate date];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        offsetComponents.month = 20;
        NSDate *lastDate =[self.calendarViewController.calendar dateByAddingComponents:offsetComponents toDate:[NSDate date] options:0];
        self.calendarViewController.lastDate = lastDate;
        [[PDTSimpleCalendarViewCell appearance] setCircleSelectedColor: [UIColor colorWithRed:71/255.0f green:227/255.0f blue:92/255.0f alpha:1.0f]];
        [[PDTSimpleCalendarViewCell appearance] setTextSelectedColor: [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f]];
        [[PDTSimpleCalendarViewCell appearance] setTextTodayColor:[UIColor blackColor]];
        [self.calendarViewController setDelegate:self];
        
        self.calendarViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-20-self.keyboardControls.inputAccessoryView.frame.size.height);
        self.calendarViewController.view.autoresizingMask = UIViewAutoresizingNone;
    }
    return self.calendarViewController.view;
}
#pragma mark - PDTSimpleCalendarViewDelegate
- (void)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller didSelectDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM d, yyyy"];
    NSString *newDate = [dateFormatter stringFromDate:date];
    NSLog(@"%@ %@", [date description],newDate);
    self.flightDate.text = newDate;
    [self.keyboardControls focusNext:self];
    [self updatePassengerCount];
}
/*  Dates Color  */

- (BOOL)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller shouldUseCustomColorsForDate:(NSDate *)date
{
    if ([self.customBlackoutDates containsObject:date]||[self.customPeakDates containsObject:date]||[self.customDates containsObject:date]) {
        return YES;
    }
    return NO;
}
/*  Blackout Dates Color  */

- (BOOL)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller shouldUseCustomColorsForBlackoutDate:(NSDate *)date
{
    if ([self.customBlackoutDates containsObject:date]) {
        return YES;
    }
    return NO;
}

- (UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller circleColorForBlackoutDate:(NSDate *)date
{
    return [UIColor colorWithRed:225/255.0f green:225/255.0f blue:225/255.0f alpha:1.0f];
}

- (UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller textColorForBlackoutDate:(NSDate *)date
{
    return [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
}


/*  Peak Dates Color  */

- (BOOL)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller shouldUseCustomColorsForPeakDate:(NSDate *)date
{
    if ([self.customPeakDates containsObject:date]) {
        return YES;
    }
    return NO;
}

- (UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller circleColorForPeakDate:(NSDate *)date
{
    return [UIColor colorWithRed:236/255.0f green:66/255.0f blue:66/255.0f alpha:1.0f];
}

- (UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller textColorForPeakDate:(NSDate *)date
{
    return [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.departureAirport || textField == self.destinationAirport) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"BookingSelectAirport"];
        if (textField == self.departureAirport) {
            vc.title = @"Departing From";
            // "STUB" / test code to populate field
            textField.text = @"LAS: McCarran Intl";
        } else if (textField == self.destinationAirport) {
            vc.title = @"Arriving At";
            textField.text = @"JFK: John F Kennedy Intl";
        }
        CATransition* transition = [CATransition animation];
        transition.duration = 0.4f;
        transition.type = kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
        [self.navigationController.view.layer addAnimation:transition
                                                    forKey:kCATransition];
        [self.navigationController pushViewController:vc animated:NO];
        [textField resignFirstResponder];
    }
    currentTextField = [inputChain indexOfObject:textField];
}

- (void)inputSwitched:(NSNotification *)sender {
    if (sender.object == self.flightDate) {
        self.keyboardControls.customItem = [[UIBarButtonItem alloc] initWithCustomView:[self getCalendarLegend]];
    } else {
        self.keyboardControls.hasPreviousNext = true;
    }
    //[self.keyboardControls inputSwitched:sender.object];
}

- (UIView *)getCalendarLegend {
    if (calendarLegend == nil) {
        calendarLegend = [[UIView alloc] init];
        CGRect barFrame = self.keyboardControls.inputAccessoryView.frame;
        UIView *rectangle = [[UIView alloc] initWithFrame:CGRectMake(0, -6, 12, 8)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, -barFrame.size.height/2, self.view.frame.size.width, barFrame.size.height)];
        label.text = @"PEAK PERIOD";
        [label setFont:[UIFont fontWithName:@"NimbusSanD-Reg" size:11.0]];
        [label setTextColor:[UIColor redColor]];
        [rectangle setBackgroundColor:[UIColor redColor]];
        [calendarLegend addSubview:rectangle];
        [calendarLegend addSubview:label];
    }
    return calendarLegend;
}

- (IBAction)addPassenger:(UIButton *)sender {
    passengerCount++;
    [self updatePassengerCount];

}

- (IBAction)subtractPassenger:(UIButton *)sender {
    passengerCount--;
    [self updatePassengerCount];
}

-(void)updatePassengerCount{
    self.addButton.enabled = self.minusButton.enabled = true;
    if(passengerCount<passengerMin)passengerCount = passengerMin;
    if(passengerCount>=passengerMax) {
        passengerCount = passengerMax;
        self.addButton.enabled = false;
    }
    if(passengerCount==1){
        self.numberOfPassengers.text =  [NSString stringWithFormat:@"%i Passenger",passengerCount];
        self.minusButton.enabled = false;
    }else{
        self.numberOfPassengers.text =  [NSString stringWithFormat:@"%i Passengers",passengerCount];
    }
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Aircraft Picker

- (UIPickerView*) getAircraftPicker {
    if (self.aircraftPicker == nil) {
        self.aircraftPicker = [[UIPickerView alloc] init];
        [self.aircraftPicker setDataSource: self];
        [self.aircraftPicker setDelegate: self];
    }
    return self.aircraftPicker;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    // STUB to return number of aircrafts
    return 5;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    // STUB to return aircraft name of row
    return [NSString stringWithFormat:@"Aircraft%lu", (long)row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // STUB to set text field to selected aircraft
    self.aircraftInput.text = [NSString stringWithFormat:@"Aircraft%lu", (long)row];
}

#pragma mark - Time Picker

- (UIDatePicker*) getTimePicker {
    if (self.timePicker == nil) {
        self.timePicker = [[UIDatePicker alloc] init];
        self.timePicker.datePickerMode = UIDatePickerModeTime;
        //self.aircraftPicker.showsSelectionIndicator = YES;
        [self.timePicker addTarget:self action:@selector(updateTimeField:) forControlEvents:UIControlEventValueChanged];
        timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"hh:mm a"];
    }
    return self.timePicker;
}


- (void) updateTimeField:(UIDatePicker *)sender {
    NJOPTextField *textField = (NJOPTextField *)inputChain[currentTextField];
    [self.dateFormatter stringFromDate:sender.date];
    textField.text = [timeFormatter stringFromDate:[sender date]];
    
    [self timeUpdated:textField];
}

- (void) timeUpdated:(NJOPTextField *)sender {
    // STUB to update other time field using estimated flight time
    /*NSDate *dateFromString = [timeFormatter dateFromString:sender.text];
    if (sender == self.arrivalTime) {
        self.departTime.text = @"";//[timeFormatter stringFromDate:[dateFromString dateByAddingTimeInterval:-60*60*2]];
    } else if (sender == self.departTime) {
        self.arrivalTime.text = @"";//[timeFormatter stringFromDate:[dateFromString dateByAddingTimeInterval:60*60*2]];
    }*/
    
}

@end
