//
//  FactionViewController.m
//  AnA2
//
//  Created by Chruszcz, Brad on 11-12-19.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FactionViewController.h"
#import "TVOutManager.h"

@implementation FactionViewController

@synthesize tvButton;
@synthesize factionNameLabel;
@synthesize factionBackgroundImageView;
@synthesize factionIcon;

-(IBAction) tvSwitched {
    [self tvOut];
}

-(void) tvOut {
    if (tvButton.on) [[TVOutManager sharedInstance] startTVOut];
	else [[TVOutManager sharedInstance] stopTVOut];
}

- (id)initWithFaction: (NSString *)factionName imageName:(NSString *)imageName{
    self = [super initWithNibName:@"FactionViewController" bundle:nil];
    if (self) {
        mFactionName = factionName;
        mImageName = imageName;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setFaction: (NSString *) factionName: (NSString *) imageName
{
    mFactionName = factionName;
    mImageName = imageName;
    factionNameLabel.text = mFactionName;
    factionIcon.image = [UIImage imageNamed:mImageName];
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
    
    factionNameLabel.text = mFactionName;
    factionIcon.image = [UIImage imageNamed:mImageName]; 
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
