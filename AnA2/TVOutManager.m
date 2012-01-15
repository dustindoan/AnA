//
//  TVOutManager.m
//  TVOutOS4Test
//
//  Created by Rob Terrell (rob@touchcentric.com) on 8/16/10.
//  Copyright 2010 TouchCentric LLC. All rights reserved.
//
// http://www.touchcentric.com/blog/


#import <QuartzCore/QuartzCore.h>
#import "TVOutManager.h"

#define kFPS 15
#define kUseBackgroundThread	NO

//
// Warning: once again, we can't use UIGetScreenImage for shipping apps (as of late July 2010)
// however, it gives a better result (shows the status bar, UIKit transitions, better fps) so 
// you may want to use it for non-app-store builds (i.e. private demo, trade show build, etc.)
// Just uncomment both lines below.
//
// #define USE_UIGETSCREENIMAGE 
// CGImageRef UIGetScreenImage();
//

@implementation TVOutManager

//@synthesize tvSafeMode;

+ (TVOutManager *)sharedInstance
{
	static TVOutManager *sharedInstance;
	
	@synchronized(self)
	{
		if (!sharedInstance)
			sharedInstance = [[TVOutManager alloc] init];
		return sharedInstance;
	}
}


- (id) init
{
    self = [super init];
    if (self) {
		// can't imagine why, but just in case
		[[NSNotificationCenter defaultCenter] removeObserver: self];
		
		// catch screen-related notifications
		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(screenDidConnectNotification:) name: UIScreenDidConnectNotification object: nil];
		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(screenDidDisconnectNotification:) name: UIScreenDidDisconnectNotification object: nil];
		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(screenModeDidChangeNotification:) name: UIScreenModeDidChangeNotification object: nil];
		
		// catch orientation notifications
		[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];		
    }
    return self;
}

-(void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver: self];
//	DELETED [super dealloc];
}

//-(void) setTvSafeMode:(BOOL) val
//{
//	if (tvoutWindow) {
//		if (tvSafeMode == YES && val == NO) {
//			[UIView beginAnimations:@"zoomIn" context: nil];
//			tvoutWindow.transform = CGAffineTransformScale(tvoutWindow.transform, 1.25, 1.25);
//			[UIView commitAnimations];
//			[tvoutWindow setNeedsDisplay];
//		}
//		else if (tvSafeMode == NO && val == YES) {
//			[UIView beginAnimations:@"zoomOut" context: nil];
//			tvoutWindow.transform = CGAffineTransformScale(tvoutWindow.transform, .8, .8);
//			[UIView commitAnimations];			
//			[tvoutWindow setNeedsDisplay];
//		}
//	}
//	tvSafeMode = val;
//}

- (void) startTVOut
{
	// you need to have a main window already open when you call start
	if ([[UIApplication sharedApplication] keyWindow] == nil) return;
	
	NSArray* screens = [UIScreen screens];
	if ([screens count] <= 1) {
		NSLog(@"TVOutManager: startTVOut failed (no external screens detected)");
		return;	
	}
	
	if (tvoutWindow) {
		// tvoutWindow already exists, so this is a re-connected cable, or a mode chane
//		DELETED [tvoutWindow release], tvoutWindow = nil;
	}
	
	if (!tvoutWindow) {
		deviceWindow = [[UIApplication sharedApplication] keyWindow];
		
		CGSize max;
		max.width = 0;
		max.height = 0;
		UIScreenMode *maxScreenMode = nil;
		UIScreen *external = [[UIScreen screens] objectAtIndex: 1];
		for(int i = 0; i < [[external availableModes] count]; i++)
		{
			UIScreenMode *current = [[[[UIScreen screens] objectAtIndex:1] availableModes] objectAtIndex: i];
			if (current.size.width > max.width)
			{
				max = current.size;
				maxScreenMode = current;
			}
		}
		external.currentMode = maxScreenMode;
		
		tvoutWindow = [[UIWindow alloc] initWithFrame: CGRectMake(0,0, max.width, max.height)];
		tvoutWindow.userInteractionEnabled = NO;
		tvoutWindow.screen = external;
				
		// size the mirrorView to expand to fit the external screen
        mapImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"map.png" ofType:nil]];
        CGSize mapSize = [mapImage size];
		CGFloat horiz = max.width / mapSize.width;
		CGFloat vert = max.height / mapSize.height;
		CGFloat bigScale = horiz < vert ? horiz : vert;
//		mirrorRect = CGRectMake(mirrorRect.origin.x, mirrorRect.origin.y, mirrorRect.size.width * bigScale, mirrorRect.size.height * bigScale);
//        mapImage = [self imageByDrawingCircleOnImage:mapImage];
		
		mirrorView = [[UIImageView alloc] initWithImage:mapImage];//initWithFrame: mirrorRect];
		mirrorView.center = tvoutWindow.center;
        [mirrorView setCenter:CGPointMake(mirrorView.center.x, mirrorView.center.y)];
        
		//countryView.center = tvoutWindow.center;
        [self setCountry:Russia];
        countryView = [[UIImageView alloc] initWithImage:countryImage];//initWithFrame: mirrorRect];
        [countryView setCenter:CGPointMake(30, 30)];
		
        mirrorView.transform = CGAffineTransformScale(tvoutWindow.transform, bigScale, bigScale);
		// TV safe area -- scale the window by 20% -- for composite / component, not needed for VGA output
		if (tvSafeMode) {
            tvoutWindow.transform = CGAffineTransformScale(tvoutWindow.transform, .8, .8);
        }
		[tvoutWindow addSubview: mirrorView];
        [tvoutWindow addSubview: countryView];
        
//		DELETED[mirrorView release];
        [tvoutWindow makeKeyAndVisible];
		tvoutWindow.hidden = NO;		
		tvoutWindow.backgroundColor = [UIColor blackColor];
		
		// orient the view properly
		if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
			mirrorView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI * 1.5);			
		} else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
			mirrorView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI * -1.5);
		}
		startingTransform = mirrorView.transform;

		[deviceWindow makeKeyAndVisible];

		[self updateTVOut];

		if (kUseBackgroundThread) [NSThread detachNewThreadSelector:@selector(updateLoop) toTarget:self withObject:nil];
		else {
			updateTimer = [NSTimer scheduledTimerWithTimeInterval: (1.0/kFPS) target: self selector: @selector(updateTVOut) userInfo: nil repeats: YES];
//			DELETED [updateTimer retain];
		}
				
	}
}

- (void) setCountry: (PlayableCountry) country {
    NSString* countryFile;
    switch (country) {
        case Russia: countryFile = @"russia_icon.png";break;
        case Germany: countryFile = @"germany_icon.png";break;
        case Britain: countryFile = @"england_icon.png";break;
        case Japan: countryFile = @"japan_icon.png";break;
        case USA: countryFile = @"usa_icon.png";break;
    }
    countryImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:countryFile ofType:nil]];
    CGSize scaledCountrySize;
    scaledCountrySize.width = 40;
    scaledCountrySize.height = 40;
    countryImage = [self scaleImage: countryImage: scaledCountrySize];
}

- (UIImage *) scaleImage: (UIImage *) image: (CGSize) newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageByDrawingCircleOnImage:(UIImage *)image
{
	// begin a graphics context of sufficient size
	UIGraphicsBeginImageContext(image.size);
    
	// draw original image into the context
	[image drawAtPoint:CGPointZero];
    
	// get the context for CoreGraphics
	CGContextRef ctx = UIGraphicsGetCurrentContext();
    
	// set stroking color and draw circle
	[[UIColor redColor] setStroke];
    
	// make circle rect 5 px from border
	CGRect circleRect = CGRectMake(0, 0,
                                   image.size.width,
                                   image.size.height);
	circleRect = CGRectInset(circleRect, 5, 5);
    
	// draw circle
	CGContextStrokeEllipseInRect(ctx, circleRect);
    
	// make image out of bitmap context
	UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    
	// free the context
	UIGraphicsEndImageContext();
    
	return retImage;
}

- (void) stopTVOut;
{
	done = YES;
	if (updateTimer) {
		[updateTimer invalidate];
//		DELETED [updateTimer release];
        updateTimer = nil;
	}
	if (tvoutWindow) {
//		DELETED [tvoutWindow release];
        tvoutWindow = nil;
		mirrorView = nil;
	}
}

- (void) updateTVOut;
{
#ifdef USE_UIGETSCREENIMAGE
	// UIGetScreenImage() is no longer allowed in shipping apps, see https://devforums.apple.com/thread/61338
	// however, it's better for demos, since it includes the status bar and captures animated transitions
	
	CGImageRef cgScreen = UIGetScreenImage();
	if (cgScreen) image = [UIImage imageWithCGImage:cgScreen];
	mirrorView.image = image;
	CGImageRelease(cgScreen);
	
#else
	
	// from http://developer.apple.com/iphone/library/qa/qa2010/qa1703.html	
	// bonus, this works in the simulator; sadly, it doesn't capture the status bar
	//
	// if you are making an OpenGL app, use UIGetScreenImage() above or switch the
	// following code to match Apple's sample at http://developer.apple.com/iphone/library/qa/qa2010/qa1704.html
	// note that you'll need to pass in a reference to your eaglview to get that to work.
	
	UIGraphicsBeginImageContext(deviceWindow.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
	
	// get every window's contents (i.e. so you can see alerts, ads, etc.)
	for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
		if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            CGContextConcatCTM(context, [window transform]);
            CGContextTranslateCTM(context, -[window bounds].size.width * window.layer.anchorPoint.x, -[window bounds].size.height * window.layer.anchorPoint.y);
            [[window layer] renderInContext:context];
            CGContextRestoreGState(context);
        }
    }	
	image = mapImage;//UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	mirrorView.image = image;
    countryView.image = countryImage;
//    [mirrorView setCenter:CGPointMake(mirrorView.center.x+1, mirrorView.center.y)];

#endif
}


- (void)updateLoop;
{
	//DELETE NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	done = NO;
	
	while ( ! done )
	{
		[self performSelectorOnMainThread:@selector(updateTVOut) withObject:nil waitUntilDone:NO];
		[NSThread sleepForTimeInterval: (1.0/kFPS) ];
	}
	//DELETE [pool release];
}

-(void) screenDidConnectNotification: (NSNotification*) notification
{
	NSLog(@"Screen connected: %@", [notification object]);
	[self startTVOut];
}

-(void) screenDidDisconnectNotification: (NSNotification*) notification
{
	NSLog(@"Screen disconnected: %@", [notification object]);
	[self stopTVOut];
}

-(void) screenModeDidChangeNotification: (NSNotification*) notification
{
	NSLog(@"Screen mode changed: %@", [notification object]);
	[self startTVOut];
}

-(void) deviceOrientationDidChange: (NSNotification*) notification
{
	if (mirrorView == nil || done == YES) return;
	if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
		[UIView beginAnimations:@"turnLeft" context:nil];
		mirrorView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI * 1.5);			
		[UIView commitAnimations];
	} else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
		[UIView beginAnimations:@"turnRight" context:nil];
		mirrorView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI * -1.5);
		[UIView commitAnimations];
	} else {
		[UIView beginAnimations:@"turnUp" context:nil];
		mirrorView.transform = CGAffineTransformIdentity;
		[UIView commitAnimations];
	}	
}

@end
