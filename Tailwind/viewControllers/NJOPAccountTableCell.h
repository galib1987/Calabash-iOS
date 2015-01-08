//
//  NJOPAccountTableCell.h
//  Tailwind
//
//  Created by netjets on 1/8/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPTableViewCell.h"

@interface NJOPAccountTableCell : NJOPTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *principalNameLabel;

@end
