//
//  ViewController.m
//  AnA2
//
//  Created by Dustin Doan on 11-12-19.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "FactionViewController.h"
#import "TVOutManager.h"

@implementation ViewController

@synthesize tvButton;
@synthesize factionLabel;
@synthesize scrollView;
@synthesize pageControl;

bool pageControlBeingUsed = NO;     // Necessary to control scrolling/page displayer feedback loop

-(IBAction) tvSwitched {
    [self tvOut];
}

-(IBAction) doNext {
    factionLabel.text = @"Next";
}

-(IBAction) doPrevious {
    factionLabel.text = @"Prev";
}

-(void) tvOut {
    if (tvButton.on) [[TVOutManager sharedInstance] startTVOut];
	else [[TVOutManager sharedInstance] stopTVOut];
}

- (IBAction)changePage {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    pageControlBeingUsed = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    pageControlBeingUsed = NO;
    
    NSArray *factions = [NSArray arrayWithObjects:@"Russia", @"Deutchland", @"Great Britain", @"Japan", @"USA", nil];
    NSArray *images = [NSArray arrayWithObjects:@"russia_icon.png", @"germany_icon.png", @"england_icon.png", @"japan_icon.png", @"usa_icon.png", nil];

    for (int i = 0; i < factions.count; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        FactionViewController *viewController = [[FactionViewController alloc] initWithFaction:[factions objectAtIndex: i] imageName:[images objectAtIndex:i]];
        viewController.view.frame = frame;
        [self.scrollView addSubview:viewController.view];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * factions.count, self.scrollView.frame.size.height);
    self.pageControl.numberOfPages = factions.count;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

/*
 * ScrollDelegate Stuffs
 */

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int x = self.scrollView.contentOffset.x;
    int page = floor((x - pageWidth / 2) / pageWidth);
    page = page + 1;
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

@end


