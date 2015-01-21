//
//  NJOPBookingViewController.h
//  Tailwind
//
//  Created by netjets on 12/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJOPTextField.h"
#import "NJOPMultilineTextField.h"
#import "PDTSimpleCalendar.h"

@interface NJOPBookingViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NJOPTextField *aircraftInput;
@property (weak, nonatomic) IBOutlet NJOPTextField *departureAirport;
@property (weak, nonatomic) IBOutlet NJOPTextField *destinationAirport;
@property (weak, nonatomic) IBOutlet NJOPTextField *flightDate;
@property (weak, nonatomic) IBOutlet NJOPTextField *departTime;
@property (weak, nonatomic) IBOutlet NJOPTextField *numberOfPassengers;
@property (weak, nonatomic) IBOutlet NJOPMultilineTextField *bookingComment;

@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;

- (IBAction)subtractPassenger:(UIButton *)sender;
- (IBAction)addPassenger:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIButton *resetBooking;
@property (strong, nonatomic) IBOutlet UIButton *nextStep;

- (IBAction)resetForm:(id)sender;

@property (strong, nonatomic) UIPickerView *aircraftPicker;
- (UIPickerView*) getAircraftPicker;

@property (strong, nonatomic) UIDatePicker *timePicker;
- (UIDatePicker*) getTimePicker;
- (void) updateTimeField:(UIDatePicker *)sender;

@end
