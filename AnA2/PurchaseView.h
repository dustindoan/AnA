//
//  PurchaseView.h
//  AnA2
//
//  Created by Chruszcz, Brad on 12-01-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseView : UIViewController




@property (nonatomic, retain) IBOutlet UIStepper* infantryStepper;
@property (nonatomic, retain) IBOutlet UIStepper* artilleryStepper;
@property (nonatomic, retain) IBOutlet UIStepper* tankStepper;
@property (nonatomic, retain) IBOutlet UIStepper* fighterStepper;
@property (nonatomic, retain) IBOutlet UIStepper* bomberStepper;
@property (nonatomic, retain) IBOutlet UIStepper* submarineStepper;
@property (nonatomic, retain) IBOutlet UIStepper* transportStepper;
@property (nonatomic, retain) IBOutlet UIStepper* destroyerStepper;
@property (nonatomic, retain) IBOutlet UIStepper* cruiserStepper;
@property (nonatomic, retain) IBOutlet UIStepper* carrierStepper;
@property (nonatomic, retain) IBOutlet UIStepper* battleshipStepper;

@property (nonatomic, retain) IBOutlet UITextField* infantryField;
@property (nonatomic, retain) IBOutlet UITextField* artilleryField;
@property (nonatomic, retain) IBOutlet UITextField* tankField;
@property (nonatomic, retain) IBOutlet UITextField* fighterField;
@property (nonatomic, retain) IBOutlet UITextField* bomberField;
@property (nonatomic, retain) IBOutlet UITextField* submarineField;
@property (nonatomic, retain) IBOutlet UITextField* transportField;
@property (nonatomic, retain) IBOutlet UITextField* destroyerField;
@property (nonatomic, retain) IBOutlet UITextField* cruiserField;
@property (nonatomic, retain) IBOutlet UITextField* carrierField;
@property (nonatomic, retain) IBOutlet UITextField* battleshipField;

@end
