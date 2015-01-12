//
//  NJOPBookingViewController.h
//  Tailwind
//
//  Created by netjets on 12/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJOPBookingViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *AircraftSelector;
@property (strong, nonatomic) IBOutlet UITextField *DepartureAirport;
@property (strong, nonatomic) IBOutlet UITextField *DestinationAirport;
@property (strong, nonatomic) IBOutlet UITextField *FlightDate;
@property (strong, nonatomic) IBOutlet UITextField *DepartTime;
@property (strong, nonatomic) IBOutlet UITextField *ArrivalTime;

@property (weak, nonatomic) IBOutlet UITextField *aircraftInput;

@property (strong, nonatomic) IBOutlet UITextField *NumberOfPassengers;
- (IBAction)SubtractPassenger:(UIButton *)sender;
- (IBAction)AddPassenger:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITextView *BookingComment;
@property (strong, nonatomic) IBOutlet UIButton *ResetBooking;
@property (strong, nonatomic) IBOutlet UIButton *NextStep;

@property (strong, nonatomic) UIPickerView *aircraftPicker;

@end
