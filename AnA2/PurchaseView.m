//
//  PurchaseView.m
//  AnA2
//
//  Created by Chruszcz, Brad on 12-01-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PurchaseView.h"
#import "TVOutManager.h"

@implementation PurchaseView

@synthesize landLabel;
@synthesize airLabel;
@synthesize seaLabel;

@synthesize infantryStepper;
@synthesize infantryImageView;
@synthesize artilleryStepper;
@synthesize artilleryImageView;
@synthesize tankStepper;
@synthesize tankImageView;
@synthesize fighterStepper;
@synthesize fighterImageView;
@synthesize bomberStepper;
@synthesize bomberImageView;
@synthesize submarineStepper;
@synthesize submarineImageView;
@synthesize transportStepper;
@synthesize transportImageView;
@synthesize destroyerStepper;
@synthesize destroyerImageView;
@synthesize cruiserStepper;
@synthesize cruiserImageView;
@synthesize carrierStepper;
@synthesize carrierImageView;
@synthesize battleshipStepper;
@synthesize battleshipImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

+ (void) drawStuff {
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.    
    landLabel.transform = CGAffineTransformMakeRotation( ( 270 * M_PI ) / 180 );
    airLabel.transform = CGAffineTransformMakeRotation( ( 270 * M_PI ) / 180 );
    seaLabel.transform = CGAffineTransformMakeRotation( ( 270 * M_PI ) / 180 );
    
    [self loadUnitImage:infantryImageView];
    [self loadUnitImage:artilleryImageView];
    [self loadUnitImage:tankImageView];
    [self loadUnitImage:battleshipImageView];
    [self loadUnitImage:fighterImageView];
    [self loadUnitImage:bomberImageView];
    [self loadUnitImage:submarineImageView];
    [self loadUnitImage:transportImageView];
    [self loadUnitImage:destroyerImageView];
    [self loadUnitImage:cruiserImageView];
    [self loadUnitImage:carrierImageView];
    [self loadUnitImage:battleshipImageView];

}

- (void) loadUnitImage:(UIImageView*) view {
    UIImage* image = [view image];
    CGSize imageSize = [image size];
    image = [[TVOutManager sharedInstance] drawNumberOnImage:imageSize :image :0];
    [view setImage:image];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(IBAction) infantryNumberChanged {
    [self unitStepperChanged:infantryStepper:infantryImageView :Infantry];
}

-(IBAction) tankNumberChanged {
    [self unitStepperChanged:tankStepper :tankImageView :Tank];
}

-(IBAction) artilleryNumberChanged {
    [self unitStepperChanged:artilleryStepper :artilleryImageView :Artillery];
}

-(IBAction) fighterNumberChanged {
    [self unitStepperChanged:fighterStepper :fighterImageView :Fighter];
}

-(IBAction) bomberNumberChanged {
    [self unitStepperChanged:bomberStepper :bomberImageView :Bomber];
}

-(IBAction) transportNumberChanged {
    [self unitStepperChanged:transportStepper :transportImageView :Transport];
}

-(IBAction) destroyerNumberChanged {
    [self unitStepperChanged:destroyerStepper :destroyerImageView :Destroyer];
}

-(IBAction) cruiserNumberChanged {
    [self unitStepperChanged:cruiserStepper :cruiserImageView :Cruiser];
}

-(IBAction) battleshipNumberChanged {
    [self unitStepperChanged:battleshipStepper :battleshipImageView :Battleship];
}

-(IBAction) submarineNumberChanged {
    [self unitStepperChanged:submarineStepper :submarineImageView :Submarine];
}

-(IBAction) carrierNumberChanged {
    [self unitStepperChanged:carrierStepper :carrierImageView :Carrier];
}

-(void) unitStepperChanged:(UIStepper*)stepper:(UIImageView*) view:(Unit) unit {
    double number = [stepper value];
    UIImage* image = [view image];
    CGSize imageSize = [image size];
    image = [[TVOutManager sharedInstance] drawNumberOnImage:imageSize :image :number];
    [view setImage:image];
    [[TVOutManager sharedInstance] setPlacedUnits:unit:number];
}

@end
