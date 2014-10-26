//
//  InfoCell.h
//  NetJets
//
//  Created by Amos Elmaliah on 10/5/14.
//  Copyright (c) 2014 Amos Elmaliah. All rights reserved.
//

#import "NJOPTableViewCell.h"

@interface InfoCell : NJOPTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *topLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imgaeView;

@end
