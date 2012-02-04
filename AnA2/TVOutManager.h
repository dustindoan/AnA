//
//  TVOutManager.h
//  TVOutOS4Test
//
//  Created by Rob Terrell (rob@touchcentric.com) on 8/16/10.
//  Copyright 2010 TouchCentric LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlacedUnit.h"

@interface TVOutManager : NSObject {

	UIWindow* deviceWindow;
	UIWindow* tvoutWindow;
	NSTimer *updateTimer;
    UIImage *mapImage;
    UIImage* countryImage;
    CGFloat infantryCount;
	UIImageView *mirrorView;
    UIImageView *countryView;
    
    UIImageView *unitView[10];
    NSMutableArray* placedUnits;
    
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
- (void) setPlacedUnits:(Unit) placedUnit: (int) count;
- (UIImage *)changeColor;
- (CGImageRef)createMask:(UIImage*)temp;
- (UIImage*) drawNumberOnImage:(CGSize) scaledSize:(UIImage*) image:(CGFloat) count;
- (void) setUnitViewsVisible:(BOOL) visible;
- (UIImage*) getImageWithCount: (NSString*) fileName :(int) count;

@end
