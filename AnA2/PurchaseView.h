//
//  PurchaseView.h
//  AnA2
//
//  Created by Chruszcz, Brad on 12-01-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlacedUnit.h"

@interface PurchaseView : UIViewController



@property (nonatomic, retain) IBOutlet UILabel* landLabel;
@property (nonatomic, retain) IBOutlet UILabel* airLabel;
@property (nonatomic, retain) IBOutlet UILabel* seaLabel;

@property (nonatomic, retain) IBOutlet UIStepper* infantryStepper;
@property (nonatomic, retain) IBOutlet UIImageView* infantryImageView;

@property (nonatomic, retain) IBOutlet UIStepper* artilleryStepper;
@property (nonatomic, retain) IBOutlet UIImageView* artilleryImageView;

@property (nonatomic, retain) IBOutlet UIStepper* tankStepper;
@property (nonatomic, retain) IBOutlet UIImageView* tankImageView;

@property (nonatomic, retain) IBOutlet UIStepper* fighterStepper;
@property (nonatomic, retain) IBOutlet UIImageView* fighterImageView;

@property (nonatomic, retain) IBOutlet UIStepper* bomberStepper;
@property (nonatomic, retain) IBOutlet UIImageView* bomberImageView;

@property (nonatomic, retain) IBOutlet UIStepper* submarineStepper;
@property (nonatomic, retain) IBOutlet UIImageView* submarineImageView;

@property (nonatomic, retain) IBOutlet UIStepper* transportStepper;
@property (nonatomic, retain) IBOutlet UIImageView* transportImageView;

@property (nonatomic, retain) IBOutlet UIStepper* destroyerStepper;
@property (nonatomic, retain) IBOutlet UIImageView* destroyerImageView;

@property (nonatomic, retain) IBOutlet UIStepper* cruiserStepper;
@property (nonatomic, retain) IBOutlet UIImageView* cruiserImageView;

@property (nonatomic, retain) IBOutlet UIStepper* carrierStepper;
@property (nonatomic, retain) IBOutlet UIImageView* carrierImageView;

@property (nonatomic, retain) IBOutlet UIStepper* battleshipStepper;
@property (nonatomic, retain) IBOutlet UIImageView* battleshipImageView;

-(IBAction) infantryNumberChanged;
-(IBAction) artilleryNumberChanged;
-(IBAction) tankNumberChanged;
-(IBAction) fighterNumberChanged;
-(IBAction) bomberNumberChanged;
-(IBAction) transportNumberChanged;
-(IBAction) destroyerNumberChanged;
-(IBAction) cruiserNumberChanged;
-(IBAction) battleshipNumberChanged;
-(IBAction) submarineNumberChanged;
-(IBAction) carrierNumberChanged;

-(void) unitStepperChanged:(UIStepper*)stepper:(UIImageView*) view:(Unit) unit;
- (void) loadUnitImage:(UIImageView*) view;

@end
