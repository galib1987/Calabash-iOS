//
//  NJOPBookingViewController.h
//  Tailwind
//
//  Created by netjets on 12/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSDFDatePickerView.h"

@interface NJOPBookingViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *departureAirport;
@property (strong, nonatomic) IBOutlet UITextField *destinationAirport;
@property (strong, nonatomic) IBOutlet UITextField *flightDate;
@property (strong, nonatomic) IBOutlet UITextField *departTime;
@property (strong, nonatomic) IBOutlet UITextField *arrivalTime;

@property (weak, nonatomic) IBOutlet UITextField *aircraftInput;

@property (strong, nonatomic) IBOutlet UITextField *numberOfPassengers;
- (IBAction)subtractPassenger:(UIButton *)sender;
- (IBAction)addPassenger:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITextView *bookingComment;
@property (strong, nonatomic) IBOutlet UIButton *resetBooking;
@property (strong, nonatomic) IBOutlet UIButton *nextStep;

@property (strong, nonatomic) UIPickerView *aircraftPicker;

- (UIPickerView*) getAircraftPicker;
- (void) selectedAircraft;

@end
