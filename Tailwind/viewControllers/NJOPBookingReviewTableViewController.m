//
//  NJOPBookingReviewTableViewController.m
//  Tailwind
//
//  Created by Angus.Lo on 1/16/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPBookingReviewTableViewController.h"
#import "NJOPPastFlightTableCell.h"

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
                                                  @"accountNameLabel.text" : @"Big Skies LLC",
                                                  @"hoursUsedLabel.text" : @"6 Hours",
                                                  @"hoursLeftLabel.text" : @"150 Hours",
                                                  
                                                  @"departureTimeLabel.text" : @"12:00 PM",
                                                  @"departureAirportCodeLabel.text" : @"KTEB",
                                                  @"departureLocationLabel.text" : @"Teterboro",
                                                  
                                                  @"flightDurationLabel.text" : @"2h 54m,\nNon Stop",
                                                  
                                                  @"arrivalTimeLabel.text" : @"2:45PM",
                                                  @"arrivalAirportCodeLabel.text" : @"KAPF",
                                                  @"arrivalLocationLabel.text" : @"Naples",
                                                  
                                                  @"passengerNumberLabel.text" : @"3 People",
                                                  
                                                  @"aircraftNameLabel.text" : @"Bombardier",
                                                  @"upgradedLabel.hidden" : @false,
                                                  
                                                  @"specialInstructionsLabel.text" : @"Lorem ipsum dolor ito. Lorem ipsum dolor ito. Lorem ipsum dolor ito. Ito lorem ipsum dolor ito lorem dolor ito."
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
    } else return 60;
}

-(void)registerReusableViews {
    UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 2;
}*/

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

@end
