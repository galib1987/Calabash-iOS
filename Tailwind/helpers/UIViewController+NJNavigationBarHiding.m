//
//  UIViewController+NJNavigationBarHiding.m
//  NetJets
//
//  Created by Amos Elmaliah on 10/9/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "UIViewController+NJNavigationBarHiding.h"
#import <objc/runtime.h>
#import "SimpleDataSourceTableViewController.h"

@implementation UITableViewController (UIScrollViewControllerNavigationBarHidingAdapter)
-(UIScrollView*)njop_scrollView {
	return self.tableView;
}
@end

@implementation UICollectionViewController (NJOPHidingAdapterScrollViewContorller)
-(UIScrollView*)njop_scrollView {
	return self.collectionView;
}
@end

@interface UIScrollViewControllerNavigationBarHidingAdapter : NSObject
@property (nonatomic, weak) UIScrollView* scrollView;
@property (nonatomic, weak) UIViewController<NJOPHidingAdapterScrollViewContorller>* viewController;
@property (nonatomic, assign) CGFloat beginDragOffset;
@property (nonatomic, readonly) CGFloat directionDelta;
@property (nonatomic, assign) BOOL controlsNavigationBar;
@property (nonatomic, assign) BOOL controlsToolbar;
@property (nonatomic, assign) BOOL controlsStatusBar;
@end

@implementation UIScrollViewControllerNavigationBarHidingAdapter

-initWithViewController:(UIViewController<NJOPHidingAdapterScrollViewContorller>*)viewContorller {
	self = [super init];
	if (self) {
		self.viewController = viewContorller;
	}
	return self;
}

-(void)updateDraggingDirectionWithScrollView:(UIScrollView*)scrollView {
	switch ([[scrollView valueForKeyPath:@"pan.state"] integerValue]) {
  case 1: {
		self.beginDragOffset = scrollView.contentOffset.y;
	}
			break;
  case 3: {
		self.beginDragOffset = 0;
	}
			break;
  default:
			break;
	}
}

-(void)updateContentOffsetWithScrollView:(UIScrollView*)scrollView {

	UINavigationController* nav = self.viewController.navigationController;
#define buffer_in_with_navigation_bar_size 1
	CGFloat navigationBarHeight = /*[nav isNavigationBarHidden] ? 0 :*/ buffer_in_with_navigation_bar_size ? nav.navigationBar.frame.size.height : 0 ;

	CGFloat directionDelta = self.beginDragOffset == 0 ? 0 : self.beginDragOffset - scrollView.contentOffset.y + navigationBarHeight;
	
	if (nav && _controlsNavigationBar) {
		if (directionDelta > 0 && [nav isNavigationBarHidden]) {
			[nav setNavigationBarHidden:NO animated:YES];
		} else if(directionDelta < 0 && ![nav isNavigationBarHidden]) {
			[nav setNavigationBarHidden:YES animated:YES];
		}
	}
	if (nav && _controlsToolbar) {
		if (directionDelta > 0 && [nav isToolbarHidden]) {
			[nav setToolbarHidden:NO animated:YES];
		} else if(directionDelta < 0 && ![nav isToolbarHidden]) {
			[nav setToolbarHidden:YES animated:YES];
		}
	}
	if (nav && _controlsStatusBar && [self.viewController respondsToSelector:@selector(setPrefersStatusBarHidden:)]) {
		UIViewController<NJOPStatusBarVisibilitySettableViewController>* vc = (UIViewController<NJOPStatusBarVisibilitySettableViewController>*)self.viewController;
		if (directionDelta > 0 && [vc prefersStatusBarHidden]) {
			[vc setPrefersStatusBarHidden:NO];
		} else if(directionDelta < 0 && ![vc prefersStatusBarHidden]) {
			[vc setPrefersStatusBarHidden:YES];
		}
	}
}

-(void)setScrollView:(UIScrollView *)scrollView {
	if (_scrollView != scrollView || !scrollView) {
		if (_scrollView) {
			[_scrollView removeObserver:self forKeyPath:@"contentOffset"];
			[_scrollView removeObserver:self forKeyPath:@"pan.state"];
		}
		_scrollView = scrollView;
		if (_scrollView) {
			[_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
			[_scrollView addObserver:self forKeyPath:@"pan.state" options: NSKeyValueObservingOptionNew context: NULL];
		}
	}
}

-(void)setViewController:(UIViewController<NJOPHidingAdapterScrollViewContorller>*)viewController {
	
	if (_viewController != viewController || !viewController) {
		[self willChangeValueForKey:@"viewController"];

		if ([_viewController isViewLoaded]) {
			UIScrollView* viewContorllerScrollView = [_viewController njop_scrollView];
			if (self.scrollView == viewContorllerScrollView) {
				self.scrollView = nil;
			}
		} else {
			[_viewController removeObserver:self forKeyPath:@"view"];
		}

		if (_viewController && _viewController.navigationController && _viewController.navigationController.navigationBarHidden) {
			[self.viewController.navigationController setNavigationBarHidden:NO];
		}
		
		_viewController = viewController;

		if ([_viewController isViewLoaded]) {
			self.scrollView = [_viewController njop_scrollView];
		} else {
			[_viewController addObserver:self
												forKeyPath:@"view"
													 options:NSKeyValueObservingOptionNew
													 context:NULL];
		}

		[self didChangeValueForKey:@"viewController"];
	}
}


-(void)destroy {
	self.viewController = nil;
	self.scrollView = nil;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	
	if ([object isEqual:self.scrollView]) {
		if ([keyPath isEqualToString:@"contentOffset"]) {
			[self updateContentOffsetWithScrollView:object];
		} else if([keyPath isEqualToString:@"pan.state"]) {
			[self updateDraggingDirectionWithScrollView:object];
		}
	} else if(self.viewController && [object isEqual:self.viewController] && [keyPath isEqual:@"view"]) {
		[self.viewController removeObserver:self forKeyPath:@"view"];
		if ([self.viewController isViewLoaded]) {
			self.scrollView = [self.viewController njop_scrollView];
		} else {
			
		}
	}
}

-(void)dealloc {
	[self destroy];
}

@end

@implementation UIViewController (NJNavigationBarHiding)

static char UIScrollViewControllerNavigationBarHidingAdapterKey;

-(UIScrollViewControllerNavigationBarHidingAdapter*)nj_hidingAdapterAdapter {
	return objc_getAssociatedObject(self, &UIScrollViewControllerNavigationBarHidingAdapterKey);
}

-(void)nj_setHidingAdapterAdapter:(UIScrollViewControllerNavigationBarHidingAdapter*)adapter {
	UIScrollViewControllerNavigationBarHidingAdapter* old = [self nj_hidingAdapterAdapter];
	if (old) {
		[old destroy];
	}
	objc_setAssociatedObject(self, &UIScrollViewControllerNavigationBarHidingAdapterKey, adapter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setHidesNavigationOnScroll:(BOOL)hidesNavigationOnScroll {

	NSAssert1([self respondsToSelector:@selector(njop_scrollView)], @"controller %@ must conform to protocol NJOPHidingAdapterScrollViewContorller in order to be able to hide navigation bar", self);


	UIViewController<NJOPHidingAdapterScrollViewContorller>* conformingSlef = (UIViewController<NJOPHidingAdapterScrollViewContorller>*)self;

	if (self.hidesNavigationOnScroll != hidesNavigationOnScroll) {
		UIScrollViewControllerNavigationBarHidingAdapter* adapter = [self nj_hidingAdapterAdapter];
		if (!adapter && hidesNavigationOnScroll) {
			adapter = [[UIScrollViewControllerNavigationBarHidingAdapter alloc] initWithViewController:conformingSlef];
			[self nj_setHidingAdapterAdapter:adapter];
		}
		adapter.controlsNavigationBar = hidesNavigationOnScroll;
	}
}

-(void)setHidesToolbarOnScroll:(BOOL)hidesToolbarOnScroll {

	NSAssert1([self respondsToSelector:@selector(njop_scrollView)], @"controller %@ must conform to protocol NJOPHidingAdapterScrollViewContorller in order to be able to hide navigation bar", self);

	UIViewController<NJOPHidingAdapterScrollViewContorller>* conformingSlef = (UIViewController<NJOPHidingAdapterScrollViewContorller>*)self;

	if (self.hidesToolbarOnScroll != hidesToolbarOnScroll) {
		UIScrollViewControllerNavigationBarHidingAdapter* adapter = [self nj_hidingAdapterAdapter];
		if (!adapter && hidesToolbarOnScroll) {
			adapter = [[UIScrollViewControllerNavigationBarHidingAdapter alloc] initWithViewController:conformingSlef];
			[self nj_setHidingAdapterAdapter:adapter];
		}
		adapter.controlsToolbar = hidesToolbarOnScroll;
	}
}

-(void)setHidesStatusBarOnScroll:(BOOL)hidesStatusBarOnScroll {
	NSAssert1([self respondsToSelector:@selector(njop_scrollView)], @"controller %@ must conform to protocol NJOPHidingAdapterScrollViewContorller in order to be able to hide navigation bar", self);
	NSAssert1([self respondsToSelector:@selector(setPrefersStatusBarHidden:)], @"controller %@ must implement setPrefersStatusBarHidden: in order to be able to hide navigation bar", self);

	UIViewController<NJOPHidingAdapterScrollViewContorller>* conformingSlef = (UIViewController<NJOPHidingAdapterScrollViewContorller>*)self;

	if (self.hidesStatusBarOnScroll != hidesStatusBarOnScroll) {
		UIScrollViewControllerNavigationBarHidingAdapter* adapter = [self nj_hidingAdapterAdapter];
		if (!adapter && hidesStatusBarOnScroll) {
			adapter = [[UIScrollViewControllerNavigationBarHidingAdapter alloc] initWithViewController:conformingSlef];
			[self nj_setHidingAdapterAdapter:adapter];
		}
		adapter.controlsStatusBar = hidesStatusBarOnScroll;
	}
}

-(BOOL)hidesStatusBarOnScroll {
	UIScrollViewControllerNavigationBarHidingAdapter* adapter = [self nj_hidingAdapterAdapter];
	return !!adapter &&  adapter.controlsStatusBar;
}

-(BOOL)hidesNavigationOnScroll {
	UIScrollViewControllerNavigationBarHidingAdapter* adapter = [self nj_hidingAdapterAdapter];
	return !!adapter &&  adapter.controlsNavigationBar;
}

-(BOOL)hidesToolbarOnScroll {
	UIScrollViewControllerNavigationBarHidingAdapter* adapter = [self nj_hidingAdapterAdapter];
	return !!adapter &&  adapter.controlsToolbar;
}

@end
