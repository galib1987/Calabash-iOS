//
//  NJOPSettingsBaseChooseTableViewController.h
//  Tailwind
//
//  Created by Amin Heidari on 1/27/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPSettingsBaseViewController.h"

@interface NJOPSettingsBaseChooseTableViewController : NJOPSettingsBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *choiceOption;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *cellTitles;
@property (nonatomic, assign) NSInteger checkedInd;

@end
