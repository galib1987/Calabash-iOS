//
//  NJOPBookingReviewTableViewController.m
//  Tailwind
//
//  Created by Angus.Lo on 1/16/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPBookingReviewTableViewController.h"
#import "NJOPPastFlightTableCell.h"
#import "UIColor+NJOP.h"

@interface NJOPBookingReviewTableViewController ()

@end

@implementation NJOPBookingReviewTableViewController

NSString *cellIdentifier = @"NJOPPastFlightTableCell";
NSString *actionButtonText = @"EDIT FLIGHT DETAILS";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    NSArray* sections = @[
                          @{
                              kSimpleDataSourceSectionCellsKey : @[
                                      @{
                                          kSimpleDataSourceCellIdentifierKey		: @"NJOPPastFlightTableCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"actionButtonLabel" : actionButtonText,
                                                  @"accountNameLabel.text" : self.formInputs[@"accountName"],
                                                  @"hoursUsedLabel.text" : self.formInputs[@"hoursUsed"],
                                                  @"hoursLeftLabel.text" : self.formInputs[@"hoursLeft"],
                                                  @"departureTimeLabel.text" : self.formInputs[@"departureTime"],
                                                  @"departureAirportCodeLabel.text" : [self.formInputs[@"departureAirportCode"] substringToIndex:3],
                                                  @"departureLocationLabel.text" : [self.formInputs[@"departureLocation"] substringFromIndex:4],
                                                  @"flightDurationLabel.text" : self.formInputs[@"flightDuration"],
                                                  @"arrivalTimeLabel.text" : self.formInputs[@"arrivalTime"],
                                                  @"arrivalAirportCodeLabel.text" : [self.formInputs[@"arrivalAirportCode"] substringToIndex:3],
                                                  @"arrivalLocationLabel.text" : [self.formInputs[@"arrivalLocation"] substringFromIndex:4],
                                                  @"passengerNumberLabel.text" : self.formInputs[@"passengerNumber"],
                                                  @"aircraftNameLabel.text" : self.formInputs[@"aircraftName"],
                                                  @"upgradedLabel.hidden" : @false,
                                                  @"specialInstructionsLabel.text" : self.formInputs[@"specialInstructions"],
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey		: @"NJOPPastFlightTableCell",
                                          kSimpleDataSourceCellKeypaths					: @{
                                                  @"actionButtonLabel" : actionButtonText,
                                                  @"accountNameLabel.text" : @"Alan",
                                                  @"hoursUsedLabel.text" : @"24 Hours",
                                                  @"hoursLeftLabel.text" : @"15 Hours",
                                                  
                                                  @"departureTimeLabel.text" : @"1:00 AM",
                                                  @"departureAirportCodeLabel.text" : @"ABC",
                                                  @"departureLocationLabel.text" : @"Reykjavik",
                                                  
                                                  @"flightDurationLabel.text" : @"36h 54m,\nNon Stop",
                                                  
                                                  @"arrivalTimeLabel.text" : @"2:45PM",
                                                  @"arrivalAirportCodeLabel.text" : @"WWW",
                                                  @"arrivalLocationLabel.text" : @"Zurich",
                                                  
                                                  @"passengerNumberLabel.text" : @"3 People",
                                                  
                                                  @"aircraftNameLabel.text" : @"Gerty",
                                                  @"upgradedLabel.hidden" : @true,
                                                  
                                                  @"specialInstructionsLabel.text" : @"Lorem."
                                                  }
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"addReturnCell"
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"addOnwardCell"
                                          },
                                      @{
                                          kSimpleDataSourceCellIdentifierKey			: @"formActionsCell"
                                          }
                                      ],
                              },
                          ];
    
    self.dataSource = [SimpleDataSource dataSourceWithSections:sections];
    self.dataSource.title = @"REVIEW & SUBMIT";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // STUB need to determine which cells get height = 60.
    if (indexPath.row < 2) {
        
        NJOPPastFlightTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if(!cell){
            cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        }
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        
        return size.height;
    } else return 80;
}

-(void)registerReusableViews {
    UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
