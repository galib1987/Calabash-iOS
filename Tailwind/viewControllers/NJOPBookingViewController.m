//
//  NJOPBookingViewController.m
//  Tailwind
//
//  Created by netjets on 12/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPBookingViewController.h"
#import "NJOPKeyboardControls.h"

@interface NJOPBookingViewController () <PDTSimpleCalendarViewDelegate>
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) APLKeyboardControls *keyboardControls;
@property (nonatomic, strong) NSArray *customDates;
@property (strong, nonatomic) NJOPCalendarViewController *calendarViewController;
@end

int passengerCount = 0;
int passengerMax = 15;
int passengerMin = 1;

NSInteger currentTextField;
NSDateFormatter *timeFormatter;

@implementation NJOPBookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.allowsSelection = NO;
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"valley"]]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self initialiseTextFields];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialiseTextFields {
    
    inputChain = @[self.aircraftInput, self.departureAirport, self.destinationAirport, self.flightDate, self.departTime, self.arrivalTime, self.numberOfPassengers, self.bookingComment];
    self.keyboardControls = [[NJOPKeyboardControls alloc] initWithInputFields:[inputChain subarrayWithRange:NSMakeRange(0, 1)]];
    self.keyboardControls.hasPreviousNext = YES;
    
    for (int i=0; i<[inputChain count]; i++) {
        ((UIView*)inputChain[i]).tag = (NSInteger)i; // Tag fields to identify them
        if ([inputChain[i] isKindOfClass:[UITextField class]]) {
            ((UITextField*)inputChain[i]).delegate = self; // listen to textFieldDidBeginEditing
            [(UITextField*)inputChain[i] addTarget:self action:@selector(textFieldUpdated:) forControlEvents:UIControlEventEditingChanged]; // listen to changes
        }
        if (i > 0) {
            ((UITextField*)inputChain[i]).enabled = false;
        }
    }
    
    self.aircraftInput.inputView = [self getAircraftPicker];
    
    self.departureAirport.delegate = self;
    self.destinationAirport.delegate = self;
    self.departTime.delegate = self;
    self.arrivalTime.delegate = self;
    
    self.departTime.inputView = [self getTimePicker];
    self.arrivalTime.inputView = [self getTimePicker];
    self.flightDate.inputView = [self getCalendar];
    
    
    self.bookingComment.placeholderTextColor = [UIColor blackColor];
    [self.bookingComment setTextContainerInset:UIEdgeInsetsMake(20, 15, 20, 15)];
    
    self.bookingComment.placeholderTextColor = [UIColor blackColor];
    [self.bookingComment setTextContainerInset:UIEdgeInsetsMake(20, 15, 20, 15)];
    
}

-(UIView*)getCalendar{
    if (self.calendarViewController == nil) {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
        _customDates = @[[dateFormatter dateFromString:@"01/05/2014"], [dateFormatter dateFromString:@"01/06/2014"], [dateFormatter dateFromString:@"01/07/2014"]];
        
       self.calendarViewController = [[NJOPCalendarViewController alloc] init];
        //This is the default behavior, will display a full year starting the first of the current month
        self.calendarViewController.delegate = self;
        self.calendarViewController.firstDate = [NSDate date];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        offsetComponents.month = 20;
        NSDate *lastDate =[self.calendarViewController.calendar dateByAddingComponents:offsetComponents toDate:[NSDate date] options:0];
        self.calendarViewController.lastDate = lastDate;
    }
    return self.calendarViewController.view;
}
#pragma mark - PDTSimpleCalendarViewDelegate
- (void)simpleCalendarViewController:(NJOPCalendarViewController *)controller didSelectDate:(NSDate *)date
{
    NSLog(@"Date Selected : %@",date);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM d, yyyy"];
        NSString *newDate = [dateFormatter stringFromDate:date];
        NSLog(@"%@ %@", [date description],newDate);
        self.flightDate.text = newDate;
        [self.view endEditing:YES];
        [self updatePassengerCount];
    
    
}

- (BOOL)calendarViewController:(NJOPCalendarViewController *)controller shouldUseCustomColorsForDate:(NSDate *)date
{
    if ([self.customDates containsObject:date]) {
        return YES;
    }
    
    return NO;
}

- (UIColor *)calendarViewController:(NJOPCalendarViewController *)controller circleColorForDate:(NSDate *)date
{
    return [UIColor blueColor];
}

- (UIColor *)calendarViewController:(NJOPCalendarViewController *)controller textColorForDate:(NSDate *)date
{
    
    return [UIColor colorWithRed:71/255.0f green:227/255.0f blue:92/255.0f alpha:1.0f];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [self.navigationController pushViewController:vc animated:YES];
    }
    currentTextField = textField.tag;
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
    if(passengerCount<passengerMin)passengerCount = passengerMin;
    if(passengerCount>passengerMax)passengerCount = passengerMax;
    if(passengerCount==1){
        self.numberOfPassengers.text =  [NSString stringWithFormat:@"%i Passenger",passengerCount];
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
//}/Development/netJets/bitbucket/Tailwind/Booking.storyboard
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
    // STUB
    return 5;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    // STUB
    return [NSString stringWithFormat:@"Aircraft%lu", (long)row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
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
    UITextField *textField = (UITextField *)[self.view viewWithTag:currentTextField];
    [self.dateFormatter stringFromDate:sender.date];
    textField.text = [timeFormatter stringFromDate:[sender date]];
}

@end
