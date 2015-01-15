//
//  NJOPBookingViewController.h
//  Tailwind
//
//  Created by netjets on 12/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJOPTextField.h"
#import "NJOPCalendarViewController.h"

@interface NJOPBookingViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet NJOPTextField *departureAirport;
@property (strong, nonatomic) IBOutlet NJOPTextField *destinationAirport;
@property (strong, nonatomic) IBOutlet NJOPTextField *flightDate;
@property (strong, nonatomic) IBOutlet NJOPTextField *departTime;
@property (strong, nonatomic) IBOutlet NJOPTextField *arrivalTime;

@property (weak, nonatomic) IBOutlet NJOPTextField *aircraftInput;

@property (strong, nonatomic) IBOutlet NJOPTextField *numberOfPassengers;
- (IBAction)subtractPassenger:(UIButton *)sender;
- (IBAction)addPassenger:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITextView *bookingComment;
@property (strong, nonatomic) IBOutlet UIButton *resetBooking;
@property (strong, nonatomic) IBOutlet UIButton *nextStep;

@property (strong, nonatomic) UIPickerView *aircraftPicker;
- (UIPickerView*) getAircraftPicker;
- (void) selectedAircraft;

@property (strong, nonatomic) UIDatePicker *timePicker;
- (UIDatePicker*) getTimePicker;

- (UIView*)NJOPCalendarViewController: getCalendar;

@end
