//
//  NJOPParentViewController.m
//  Tailwind
//
//  Created by Amos Elmaliah on 10/20/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPParentViewController.h"
#import "NJOPNavigationTitleView.h"
#import "NJOPActionsViewController.h"
#import "NJOPReservationCollectionViewController.h"
#import "NJOPCollectionViewFlowLayout.h"

@interface NJOPParentViewController ()
-(NJOPReservationCollectionViewController*)reservationController;
-(NJOPActionsViewController*)actionsViewController;
@end

@interface NSObject (FindBy)
+(instancetype)njop_first:(NSArray*)array;
@end

@implementation NSObject (FindBy)

id findByClass(NSArray*array,Class class) {
	__block typeof(Class) objectOfThisClass;
	[array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		if ([obj isKindOfClass:class]) {
			objectOfThisClass = obj;
		}
	}];
	return objectOfThisClass;

}

+(instancetype)njop_first:(NSArray *)array {
	return findByClass(array, self);
}

@end

@implementation NJOPParentViewController

-(NJOPReservationCollectionViewController *)reservationController {
	return [NJOPReservationCollectionViewController njop_first:self.childViewControllers];
}

-(NJOPActionsViewController *)actionsViewController {
	return [NJOPActionsViewController njop_first:self.childViewControllers];
}

- (void)viewDidLoad {
	[super viewDidLoad];

	NJOPReservationCollectionViewController* reservationController = [self reservationController];
	if (reservationController) {
		NJOPCollectionViewFlowLayout*layout = (NJOPCollectionViewFlowLayout*)reservationController.collectionView.collectionViewLayout;
		NSAssert([layout isKindOfClass:[NJOPCollectionViewFlowLayout class]], @"");
		layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
	}
	NJOPActionsViewController* actionController = [self actionsViewController];
	if (actionController) {
		NJOPCollectionViewFlowLayout*layout = (NJOPCollectionViewFlowLayout*)actionController.collectionView.collectionViewLayout;
		NSAssert([layout isKindOfClass:[NJOPCollectionViewFlowLayout class]], @"");
		layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
	}



	self.view.backgroundColor = SCROLLVIEW_BACKGORUND_COLOR;
	UINib* nib = [UINib nibWithNibName:@"NJOPNavigationTitleView"
															bundle:nil];

	NJOPNavigationTitleView* titleView = (NJOPNavigationTitleView*)[nib instantiateWithOwner:nil
																																									 options:nil][0];
	titleView.fittedSizeForSize = ^(CGSize size, CGSize fittedSize) {
		fittedSize.width = size.width;
		return fittedSize;
	};

	
	[titleView setAutoresizingMask:UIViewAutoresizingFlexibleWidth| UIViewAutoresizingFlexibleHeight];

	NSAssert([titleView isKindOfClass:[NJOPNavigationTitleView class]], @"expected a view");
	[self.navigationItem setTitleView:titleView];
}

@end
