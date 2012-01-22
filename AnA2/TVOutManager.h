//
//  TVOutManager.h
//  TVOutOS4Test
//
//  Created by Rob Terrell (rob@touchcentric.com) on 8/16/10.
//  Copyright 2010 TouchCentric LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TVOutManager : NSObject {

	UIWindow* deviceWindow;
	UIWindow* tvoutWindow;
	NSTimer *updateTimer;
    UIImage *mapImage;
    UIImage* countryImage;
    UIImage* unitImage;
	UIImageView *mirrorView;
    UIImageView *countryView;
    UIImageView *unitView;
	BOOL done;
	BOOL tvSafeMode;
	CGAffineTransform startingTransform;
}

typedef enum { Russia, Germany, Britain, Japan, USA} PlayableCountry;

//@property(assign) BOOL tvSafeMode;


+ (TVOutManager *)sharedInstance;

- (void) startTVOut;
- (void) stopTVOut;
- (void) updateTVOut;
- (void) updateLoop;
- (void) screenDidConnectNotification: (NSNotification*) notification;
- (void) screenDidDisconnectNotification: (NSNotification*) notification;
- (void) screenModeDidChangeNotification: (NSNotification*) notification;
- (void) deviceOrientationDidChange: (NSNotification*) notification;
- (UIImage *)imageByDrawingCircleOnImage:(UIImage *)image;
- (UIImage *) scaleImage: (UIImage *) image: (CGSize) size;
- (void) setCountry: (PlayableCountry) country;
- (void) addUnit;
- (UIImage *)changeColor;
- (CGImageRef)createMask:(UIImage*)temp;


@end
