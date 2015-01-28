//
//  NJOPChooseTableViewHeader.m
//  Tailwind
//
//  Created by Amin Heidari on 1/27/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPChooseTableViewHeader.h"

@interface NJOPChooseTableViewHeader()

@property (nonatomic, weak) IBOutlet UILabel *choosePromptLabel;

@end

@implementation NJOPChooseTableViewHeader

- (void)awakeFromNib
{
	self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)setChoiceOption:(NSString *)choiceOption
{
	_choiceOption = choiceOption;
	
	self.choosePromptLabel.text = [NSString stringWithFormat:@"Choose the %@ you prefer.", _choiceOption];
}

@end
