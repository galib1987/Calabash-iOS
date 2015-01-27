//
//  NJOPSendFeedbackViewController.m
//  Tailwind
//
//  Created by Amin Heidari on 1/27/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPSendFeedbackViewController.h"

typedef NS_ENUM(NSInteger, NJOPFeedbackType) {
	NJOPFeedbackTypeApp,
	NJOPFeedbackTypeFlight,
	NJOPFeedbackType_count
};

NSString * const NJOPFeedbackTypePlaceHolder = @"Select a Topic";

@interface NJOPSendFeedbackViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView *feedbackTypeTextView;
@property (nonatomic, weak) IBOutlet UITextView *feedbackTextView;
@property (nonatomic, weak) IBOutlet UIImageView *dropDownImView;

@property (nonatomic, strong) NSArray *feedbackTypeStrings;
@property (nonatomic, assign) NJOPFeedbackType feedbackType;
@property (nonatomic, strong) UIPickerView *feedbackTypePicker;

@end

@implementation NJOPSendFeedbackViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	
	self.feedbackTypeStrings = @[@"Feedback about this App",
								 @"Feedback about a Flight"];
	
	
	{
		self.feedbackTypePicker = [[UIPickerView alloc] init];
		self.feedbackTypePicker.delegate = self;
		self.feedbackTypePicker.dataSource = self;
		self.feedbackTypePicker.backgroundColor = [UIColor whiteColor];
		self.feedbackTypeTextView.inputView = self.feedbackTypePicker;
	}
	
	UIToolbar *accessoryView;
	{
		accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
		accessoryView.backgroundColor = [UIColor whiteColor];
		
		UIButton *prevBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 24.0, 18.0)];
		[prevBtn setImage:[UIImage imageNamed:@"input-prev"] forState:UIControlStateNormal];
		UIBarButtonItem *prevBarBtn = [[UIBarButtonItem alloc] initWithCustomView:prevBtn];
									   
		UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 24.0, 18.0)];
		[nextBtn setImage:[UIImage imageNamed:@"input-next"] forState:UIControlStateNormal];
		UIBarButtonItem *nextBarBtn = [[UIBarButtonItem alloc] initWithCustomView:nextBtn];
		
		UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done"
																	style:UIBarButtonItemStylePlain
																   target:self
																   action:@selector(doneEditingField)];
		[doneBtn setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor darkTextColor],
										  NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0]} forState:UIControlStateNormal];
		
		// must style the buttons properly and then add them here
		[accessoryView setItems:@[prevBarBtn,
								  nextBarBtn,
								  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																				target:nil
																				action:nil],
								  doneBtn]];
	}
	
	self.feedbackTypeTextView.inputAccessoryView = accessoryView;
	self.feedbackTextView.inputAccessoryView = accessoryView;
	
	UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginEditingFeedbackType)];
	[self.feedbackTypeTextView addGestureRecognizer:tapGR];
	
	self.feedbackTypeTextView.text = NJOPFeedbackTypePlaceHolder;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.feedbackTypeTextView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[self.feedbackTypeTextView removeObserver:self forKeyPath:@"contentSize"];
	
	[super viewDidDisappear:animated];
}

- (void)setFeedbackType:(NJOPFeedbackType)feedbackType {
	_feedbackType = feedbackType;
	
	self.feedbackTypeTextView.text = self.feedbackTypeStrings[_feedbackType];
}

#pragma mark - private

- (void)beginEditingFeedbackType
{
	if (self.feedbackTypeTextView.isFirstResponder) {
		return;
	}
	
	if ([self.feedbackTypeTextView.text isEqualToString:NJOPFeedbackTypePlaceHolder]) {
		self.feedbackType = NJOPFeedbackTypeApp;
	}
	
	[self.feedbackTypeTextView becomeFirstResponder];
	self.dropDownImView.hidden = YES;
}

- (void)doneEditingField
{
	if (self.feedbackTypeTextView.isFirstResponder) {
		[self.feedbackTypeTextView resignFirstResponder];
		self.dropDownImView.hidden = NO;
	} else if (self.feedbackTextView.isFirstResponder) {
		
		[self.view endEditing:YES];
		
		if ([self.feedbackTypeTextView.text isEqualToString:NJOPFeedbackTypePlaceHolder]) {
			
			__weak NJOPSendFeedbackViewController *weakSelf = self;
			
			UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
																					 message:@"Your feedback message has no subject. What would you like to do?"
																			  preferredStyle:UIAlertControllerStyleAlert];
			[alertController addAction:[UIAlertAction actionWithTitle:@"GO BACK"
																style:UIAlertActionStyleDefault
															  handler:^(UIAlertAction *action) {
																  [weakSelf beginEditingFeedbackType];
															  }]];
			[alertController addAction:[UIAlertAction actionWithTitle:@"SEND ANYWAY"
																style:UIAlertActionStyleDefault
															  handler:^(UIAlertAction *action) {
																  [weakSelf performSegueWithIdentifier:@"submitFeedback" sender:nil];
															  }]];
			[self presentViewController:alertController animated:YES completion:^{
				//
			}];
		} else {
			[self performSegueWithIdentifier:@"submitFeedback" sender:nil];
		}
	}
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	UITextView *tv = object;
	CGFloat topCorrect = ([tv bounds].size.height - [tv contentSize].height * [tv zoomScale])/2.0;
	tv.contentOffset = CGPointMake(0.0, -( topCorrect < 0.0 ? 0.0 : topCorrect ));
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
	return NJOPFeedbackType_count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView
			 titleForRow:(NSInteger)row
			forComponent:(NSInteger)component {
	return self.feedbackTypeStrings[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	self.feedbackType = (NJOPFeedbackType)row;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	self.dropDownImView.hidden = NO;
	
	return YES;
}

@end
