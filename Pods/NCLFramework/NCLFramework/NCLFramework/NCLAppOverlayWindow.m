//
//  NCLAppOverlayView.m
//  NCLFramework
//
//  Created by Chad Long on 8/29/13.
//  Copyright (c) 2013 NetJets, Inc. All rights reserved.
//

#import "NCLAppOverlayWindow.h"
#import "NCLMessageView.h"

#pragma mark - NCLRadialBackgroundView

@interface NCLRadialBackgroundView : UIView

@property (nonatomic) CGGradientRef gradientRef;
@property (nonatomic) CGColorRef overlayColor;

@end

@implementation NCLRadialBackgroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.0;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        // build/set overlay color
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGFloat r = 0/255.0;
        CGFloat g = 0/255.0;
        CGFloat b = 0/255.0;
        CGFloat a = 0/255.0;
        CGFloat components[4] = {r,g,b,a};
        
        self.overlayColor = CGColorCreate(colorSpace, components);
        CGColorSpaceRelease(colorSpace);
        
        self.opaque = NO;
        
        // build gradient
        if (_gradientRef) {
            CGGradientRelease(_gradientRef);
        }
        
        CGColorRef firstColor = CGColorCreateCopyWithAlpha(self.overlayColor, 0.f);
        CGColorRef secondColor = CGColorCreateCopyWithAlpha(self.overlayColor, 0.4f);
        CGColorRef thirdColor = CGColorCreateCopyWithAlpha(self.overlayColor, 0.5f);
        
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorsArray[] = {
            firstColor,
            secondColor,
            thirdColor
        };
        
        CFArrayRef colors = CFArrayCreate(NULL,
                                          (const void**)colorsArray,
                                          sizeof(colorsArray)/sizeof(CGColorRef),
                                          &kCFTypeArrayCallBacks);
        
        CGFloat locationList[] = {0.0,0.5,1.0};
        
        self.gradientRef = CGGradientCreateWithColors(rgb, colors, locationList);
        
        CGColorRelease(firstColor);
        CGColorRelease(secondColor);
        CGColorRelease(thirdColor);
        CFRelease(colors);
        CGColorSpaceRelease(rgb);
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    
    float startRadius = 50.0f;
    float endRadius = rect.size.height*0.66f;
    
    CGContextDrawRadialGradient(context,
                                self.gradientRef,
                                center,
                                startRadius,
                                center,
                                endRadius,
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    CGContextRestoreGState(context);
}

@end

@interface NCLAppOverlayWindow()

@property (nonatomic, strong) UIView *radialBackgroundView;

@end

@implementation NCLAppOverlayWindow

+ (NCLAppOverlayWindow*)sharedInstance
{
	static dispatch_once_t pred;
	static NCLAppOverlayWindow *sharedInstance = nil;
    
	dispatch_once(&pred, ^
                  {
                      sharedInstance = [[self alloc] init];
                  });
	
    return sharedInstance;
}

+ (UIView*)view
{
    return [self sharedInstance].rootViewController.view;
}

- (instancetype)init
{
    if ((self = [super initWithFrame:[[UIScreen mainScreen] bounds]]))
    {
        self.windowLevel = UIWindowLevelStatusBar;
        self.backgroundColor = [UIColor clearColor];
 
        // setup a root view controller so we get rotation logic
        UIViewController *rootController = [[UIViewController alloc] init];
        rootController.view.backgroundColor = [UIColor clearColor];
        [self setRootViewController:rootController];
        
        self.radialBackgroundView = [[NCLRadialBackgroundView alloc] initWithFrame:rootController.view.frame];
        [rootController.view addSubview:self.radialBackgroundView];
        
        self.hidden = NO;
    }
    
    return self;
}

- (void)setShouldBlockBackgroundTouches:(BOOL)shouldBlockBackgroundTouches
{
    _shouldBlockBackgroundTouches = shouldBlockBackgroundTouches;
    
    if (_shouldBlockBackgroundTouches)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.radialBackgroundView.alpha = 1;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.15 animations:^{
            self.radialBackgroundView.alpha = 0;
        }];
    }
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    // see if the hit is anywhere in our view hierarchy
    UIView *hitTestResult = [super hitTest:point withEvent:event];
    
    if (self.shouldBlockBackgroundTouches == YES)
        return hitTestResult;
    
    if (!hitTestResult ||
        ![hitTestResult isKindOfClass:[NCLMessageView class]])
    {
        // pass through all touches that are not for the touch sensitive info view
        return nil;
    }
    
    return hitTestResult;
}

@end

