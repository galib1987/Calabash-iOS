//
//  NJOPBookingViewController.h
//  Tailwind
//
//  Created by netjets on 12/26/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJOPBookingViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *aircraftInput;

@property (strong, nonatomic) UIPickerView *aircraftPicker;

@end
