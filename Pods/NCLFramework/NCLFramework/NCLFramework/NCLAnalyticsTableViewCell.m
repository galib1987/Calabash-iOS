//
//  NCLAnalyticsTableViewCell.m
//  NCLFramework
//
//  Created by Chad Long on 11/11/13.
//  Copyright (c) 2013 NetJets, Inc. All rights reserved.
//

#import "NCLAnalyticsTableViewCell.h"

@interface NCLAnalyticsTableViewCell()

@property (nonatomic, strong) NSMutableArray *viewConstraints;

@end

@implementation NCLAnalyticsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.viewConstraints = [NSMutableArray new];
        
        self.createdLabel = [[UILabel alloc] init];
        self.createdLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.createdLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        [self.contentView addSubview:self.createdLabel];
        
        self.actionLabel = [[UILabel alloc] init];
        self.actionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.actionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        self.actionLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.actionLabel];

        self.elapsedTimeLabel = [[UILabel alloc] init];
        self.elapsedTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.elapsedTimeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        self.elapsedTimeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.elapsedTimeLabel];
        
        self.errorLabel = [[UILabel alloc] init];
        self.errorLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.errorLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        self.errorLabel.textColor = [UIColor redColor];
        self.errorLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.errorLabel];

        self.valueLabel = [[UILabel alloc] init];
        self.valueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.valueLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        self.valueLabel.textColor = [UIColor darkGrayColor];
        self.valueLabel.numberOfLines = 1;
        self.valueLabel.adjustsFontSizeToFitWidth = YES;
        self.valueLabel.minimumScaleFactor = 12.0 / self.valueLabel.font.pointSize;
        [self.contentView addSubview:self.valueLabel];
    }
    
    return self;
}

#pragma mark - autolayout constraint management

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)updateConstraints
{
    [super updateConstraints];

    // reset constraints
    [self.contentView removeConstraints:self.viewConstraints];
    [self.viewConstraints removeAllObjects];

    // build constraints
    NSDictionary *variableBindings = NSDictionaryOfVariableBindings(_createdLabel, _actionLabel, _elapsedTimeLabel, _errorLabel, _valueLabel);

    [self.createdLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.actionLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.elapsedTimeLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.errorLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    [self.viewConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_createdLabel]-5-[_valueLabel]"
                                                                                      options:0
                                                                                      metrics:nil
                                                                                        views:variableBindings]];

    [self.viewConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_createdLabel]-8-[_actionLabel]-(>=8)-[_elapsedTimeLabel]-8-[_errorLabel]-8-|"
                                                                                      options:NSLayoutFormatAlignAllCenterY
                                                                                      metrics:nil
                                                                                        views:variableBindings]];

    [self.viewConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_valueLabel]-8-|"
                                                                                      options:0
                                                                                      metrics:nil
                                                                                        views:variableBindings]];

    [self.contentView addConstraints:self.viewConstraints];
}

@end