//
//  NJOPBookingViewController.m
//  Tailwind
//
//  Created by netjets on 12/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPBookingViewController.h"

@interface NJOPBookingViewController () <RSDFDatePickerViewDelegate, RSDFDatePickerViewDataSource>
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) RSDFDatePickerView *datePickerView;
@end

int passengerCount = 0;
int passengerMax = 15;
int passengerMin = 1;

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
    
    
    self.flightDate.delegate = self;
    self.aircraftPicker = [[UIPickerView alloc] init];
    [self.aircraftPicker setDataSource: self];
    [self.aircraftPicker setDelegate: self];
    self.aircraftInput.inputView = [self getAircraftPicker];
    
    
    
    
    self.datePickerView = [[RSDFDatePickerView alloc] initWithFrame:self.view.bounds];
    self.datePickerView.delegate = self;
    //  datePickerView.dataSource = self;
    self.datePickerView.hidden = YES;
    [self.tableView addSubview:self.datePickerView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textFieldDidBeginEditing:(UITextField *)FlightDate{
    [self loadCalendar];
}
-(void)loadCalendar{
    self.datePickerView.hidden = NO;
}

// Returns YES if the date should be highlighted or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldHighlightDate:(NSDate *)date
{
    return YES;
}

// Returns YES if the date should be selected or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldSelectDate:(NSDate *)date
{
    return YES;
}

// Prints out the selected date.
- (void)datePickerView:(RSDFDatePickerView *)view didSelectDate:(NSDate *)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM d, yyyy"];
    NSString *newDate = [dateFormatter stringFromDate:date];
    
    
    NSLog(@"%@ %@", [date description],newDate);
    self.flightDate.text = newDate;
    self.datePickerView.hidden = YES;
    [self.view endEditing:YES];
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
    self.numberOfPassengers.text =  [NSString stringWithFormat:@"%i",passengerCount];
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

#pragma mark - Aircraft UIPicker

- (UIPickerView*) getAircraftPicker {
    if (self.aircraftPicker == nil) {
        self.aircraftPicker = [[UIPickerView alloc] init];
        [self.aircraftPicker setDataSource: self];
        [self.aircraftPicker setDelegate: self];
        //self.aircraftPicker.showsSelectionIndicator = YES;
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
    //NSLog(@"selected %d", row);
}

@end
