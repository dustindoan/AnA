//
//  PurchaseView.m
//  AnA2
//
//  Created by Chruszcz, Brad on 12-01-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PurchaseView.h"

@implementation PurchaseView

@synthesize infantryStepper;
@synthesize artilleryStepper;
@synthesize tankStepper;
@synthesize fighterStepper;
@synthesize bomberStepper;
@synthesize submarineStepper;
@synthesize transportStepper;
@synthesize destroyerStepper;
@synthesize cruiserStepper;
@synthesize carrierStepper;
@synthesize battleshipStepper;

@synthesize infantryField;
@synthesize artilleryField;
@synthesize tankField;
@synthesize fighterField;
@synthesize bomberField;
@synthesize submarineField;
@synthesize transportField;
@synthesize destroyerField;
@synthesize cruiserField;
@synthesize carrierField;
@synthesize battleshipField;


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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

@end
