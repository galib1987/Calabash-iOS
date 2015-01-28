//
//  NJOPChooseTableViewCell.m
//  Tailwind
//
//  Created by Amin Heidari on 1/27/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPChooseTableViewCell.h"

@interface NJOPChooseTableViewCell()

@property (nonatomic, weak) IBOutlet UILabel *choiceTitleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *checkedImView;

@end

@implementation NJOPChooseTableViewCell

- (void)awakeFromNib
{
	self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setChoiceTitle:(NSString *)choiceTitle
{
	_choiceTitle = choiceTitle;
	self.choiceTitleLabel.text = _choiceTitle;
}

- (void)setChecked:(BOOL)checked
{
	_checked = checked;
	self.checkedImView.hidden = !_checked;
}

@end
