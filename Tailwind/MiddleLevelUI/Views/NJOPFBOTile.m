//
//  NJOPFBOTile.m
//  Tailwind
//
//  Created by NetJets on 10/22/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPFBOTile.h"

@interface NJOPFBOTile ()
@property (nonatomic, strong) NSArray* constraints;
@end
@implementation NJOPFBOTile

#pragma mark - subviews

-(UILabel *)dateLabel {
	if(!_dateLabel) {
		_dateLabel = [UILabel new];
		[self addSubview:_dateLabel];
	}
	return _dateLabel;
}
-(UILabel *)fromLocationLabel {
	if(!_fromLocationLabel) {
		_fromLocationLabel = [UILabel new];
		[self addSubview:_fromLocationLabel];
	}
	return _fromLocationLabel;
}
-(UILabel *)fromAirportCodeLabel {
	if(!_fromAirportCodeLabel) {
		_fromAirportCodeLabel = [UILabel new];
		[self addSubview:_fromAirportCodeLabel];
	}
	return _fromAirportCodeLabel;
}
-(UIImageView* )tailImageView {
	if(!_tailImageView) {
		_tailImageView = [UIImageView new];
		[self addSubview:_tailImageView];
	}
	return _tailImageView;
}
-(UILabel* )tailNumberLabel {
	if(!_tailNumberLabel) {
		_tailNumberLabel = [UILabel new];
		[self addSubview:_tailNumberLabel];
	}
	return _tailNumberLabel;
}
-(UILabel* )estimatedTimeLabel {
	if(!_estimatedTimeLabel) {
		_estimatedTimeLabel = [UILabel new];
		_estimatedTimeLabel.font = [UIFont boldSystemFontOfSize:20];
		[self addSubview:_estimatedTimeLabel];
	}
	return _estimatedTimeLabel;
}

-(void)layoutSubviews {
	[super layoutSubviews];
	CGFloat y = 0;

	{
		self.dateLabel.layer.borderColor = [[UIColor greenColor] colorWithAlphaComponent:0.4].CGColor;
		self.dateLabel.layer.borderWidth = 1.0;
		self.dateLabel.text = @"Today, Oct 22, 2014";
		self.dateLabel.textColor = [UIColor lightGrayColor];
		[self.dateLabel setTextAlignment:NSTextAlignmentCenter];
		self.dateLabel.preferredMaxLayoutWidth = self.bounds.size.width;
		CGSize size = [self.dateLabel intrinsicContentSize];
		CGRect frame = CGRectMake(0, y, self.bounds.size.width, size.height);
		y = CGRectGetMaxY(frame);
		self.dateLabel.frame = frame;
	}

	{
		self.fromLocationLabel.layer.borderColor = [[UIColor greenColor] colorWithAlphaComponent:0.4].CGColor;
		self.fromLocationLabel.layer.borderWidth = 1.0;
		self.fromLocationLabel.text = @"Teterboro, NJ";
		self.fromLocationLabel.textColor = [UIColor blackColor];
		[self.fromLocationLabel setTextAlignment:NSTextAlignmentCenter];
		self.fromLocationLabel.preferredMaxLayoutWidth = self.bounds.size.width;
		self.fromLocationLabel.font = [UIFont fontWithDescriptor:[[UIFontDescriptor alloc] initWithFontAttributes:
																															@{
																																UIFontDescriptorFamilyAttribute : @"Helvetica Neue",
																																UIFontDescriptorNameAttribute : @"HelveticaNeue-Light",
																																UIFontDescriptorSizeAttribute : @"22",}]
																												size:22];
		CGSize size = [self.fromLocationLabel intrinsicContentSize];
		CGRect frame = CGRectMake((self.bounds.size.width- size.width)*0.5, y +8 , size.width, size.height);
		self.fromLocationLabel.frame = frame;


		self.tailImageView.layer.borderColor = [[UIColor greenColor] colorWithAlphaComponent:0.4].CGColor;
		self.tailImageView.layer.borderWidth = 1.0;
		self.tailImageView.contentMode = UIViewContentModeScaleAspectFit;
		UIImage* image = self.pinImage;
		self.tailImageView.image = image;
		CGSize imageSize = [self.tailImageView sizeThatFits:frame.size];
		self.tailImageView.frame = CGRectMake(frame.origin.x - imageSize.width, frame.origin.y, imageSize.width, frame.size.height);

		y = CGRectGetMaxY(frame);
	}

	if(YES)
	{
		self.fromAirportCodeLabel.layer.borderColor = [[UIColor greenColor] colorWithAlphaComponent:0.4].CGColor;
		self.fromAirportCodeLabel.layer.borderWidth = 1.0;
		self.fromAirportCodeLabel.text = @"NJOP12";
		self.fromAirportCodeLabel.textColor = [UIColor blackColor];
		[self.fromAirportCodeLabel setTextAlignment:NSTextAlignmentCenter];
		self.fromAirportCodeLabel.preferredMaxLayoutWidth = self.bounds.size.width;
		self.fromAirportCodeLabel.font = [UIFont fontWithDescriptor:[[UIFontDescriptor alloc] initWithFontAttributes:
																															@{
																																UIFontDescriptorFamilyAttribute : @"Helvetica Neue",
																																UIFontDescriptorNameAttribute : @"HelveticaNeue-Light",
																																UIFontDescriptorSizeAttribute : @"22",}]
																												size:22];
		CGSize size = [self.fromAirportCodeLabel intrinsicContentSize];
		CGRect frame = CGRectMake((self.bounds.size.width- size.width) * 0.5,
															y + 8 ,
															size.width,
															size.height);
		y = CGRectGetMaxY(frame);
	}

}

-(void)updateConstraintss {
	if (!_constraints) {
		NSMutableArray* mutable = [NSMutableArray new];

		NSDictionary *variableBindings = NSDictionaryOfVariableBindings(_dateLabel, _fromLocationLabel, _fromAirportCodeLabel, _tailImageView, _tailNumberLabel, _estimatedTimeLabel);

		[mutable addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_dateLabel]-[_fromLocationLabel]-[_fromAirportCodeLabel]-[_tailImageView]-[_tailNumberLabel]-[_estimatedTimeLabel]-|"
																																				 options:0
																																				 metrics:nil
																																					 views:variableBindings]];
		_constraints = [mutable copy];
		[self addConstraints:_constraints];
	}
	[super updateConstraints];
}

@end
