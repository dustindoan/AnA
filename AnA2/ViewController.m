//
//  ViewController.m
//  AnA2
//
//  Created by Dustin Doan on 11-12-19.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "PurchaseView.h"
#import "FactionViewController.h"
#import "TVOutManager.h"

#define NUM_PAGES 2
#define NUM_FACTIONS 5

@implementation ViewController

@synthesize navBar;

@synthesize scrollView;
@synthesize pageControl;

bool pageControlBeingUsed = NO;     // Necessary to control scrolling/page displayer feedback loop
int currentFaction = 0;

FactionViewController * viewFactionView;
PurchaseView * viewPurchaseView;

-(IBAction) doNext {
    [self setPage:([self getPage] + 1)];
}

-(IBAction) doPrevious {
    [self setPage:([self getPage] - 1)];
}

- (IBAction)changePage {
    // update the scroll view to the appropriate page
    int p = [self getPage];
    [self setPage:p];
}

-(int) nextFaction
{
    if(currentFaction == NUM_FACTIONS-1){
        return 0;
    }
    
    return currentFaction + 1;
}

-(int) prevFaction
{
    if(currentFaction == 0){
        return NUM_FACTIONS-1;
    }
    
    return currentFaction - 1;
}


-(int) getPage
{
    return self.pageControl.currentPage;
}

/*
 *  Should only be called as necessary.  Updates all views for use with the selected faction.
 */
- (void) updateFaction
{
    if(currentFaction >= NUM_FACTIONS){
        currentFaction = 0;
    } else if (currentFaction < 0){
        currentFaction = NUM_FACTIONS-1;
    }

    NSArray *factions = [NSArray arrayWithObjects:@"Russia", @"Germany", @"Great Britain", @"Japan", @"USA", nil];
    NSArray *images = [NSArray arrayWithObjects:@"russia_icon.png", @"germany_icon.png", @"england_icon.png", @"japan_icon.png", @"usa_icon.png", nil];

    NSLog(@"Setting faction: %d", currentFaction);
    
    [viewFactionView setFaction:[factions objectAtIndex:currentFaction]:[images objectAtIndex:currentFaction]];
    navBar.topItem.title = [factions objectAtIndex:currentFaction];
    
    [[TVOutManager sharedInstance] setCountry:currentFaction];
}

/* Set page is called after the user has stopped scrolling, or clicked a button */
-(void) setPage: (int) page
{
    NSArray *factions = [NSArray arrayWithObjects:@"Russia", @"Germany", @"Great Britain", @"Japan", @"USA", nil];
    NSArray *stages = [NSArray arrayWithObjects:@"Faction Summary", @"Purchase Units", nil];

    /*
     * Wrapping, for now
     */
    BOOL wrapped = NO;
    if(page >= NUM_PAGES){
        page = 0;
        currentFaction++;
        [self updateFaction];
        wrapped = YES;
    } else if (page < 0){
        page = NUM_PAGES-1;
        currentFaction--;
        [self updateFaction];
        wrapped = YES;
    }
    
    CGRect frame;
    self.pageControl.currentPage = page;
    frame.origin.x = self.scrollView.frame.size.width * page;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:!wrapped];
    pageControlBeingUsed = YES;
    
    if(page == NUM_PAGES-1){
        // Last page
        navBar.topItem.rightBarButtonItem.title = [factions objectAtIndex:[self nextFaction]];
    } else {
        navBar.topItem.rightBarButtonItem.title = [stages objectAtIndex:page+1];
    }
    
    if (page == 0){
        navBar.topItem.leftBarButtonItem.title = [factions objectAtIndex:[self prevFaction]];
    } else {
        // Normal
        navBar.topItem.leftBarButtonItem.title = [stages objectAtIndex:page-1];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void) addViewToScroll: (ViewController *) viewController: (int) page
{
    // Repeat for every page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * page;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    viewController.view.frame = frame;
    [self.scrollView addSubview:viewController.view];
}


// Add the initial pages to the buffer
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    pageControlBeingUsed = NO;

    int page = 0;
    viewFactionView = [[FactionViewController alloc] initWithFaction:@"Russia" imageName:@"russia_icon.png"];
    [self addViewToScroll:(ViewController *)viewFactionView:page++];
    
    viewPurchaseView = [PurchaseView alloc];
    [self addViewToScroll:(ViewController *)viewPurchaseView:page++];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * NUM_PAGES, self.scrollView.frame.size.height);
    self.pageControl.numberOfPages = NUM_PAGES;
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

/*
 *  scrollViewDidScroll is called continously while scrolling
 */
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int x = self.scrollView.contentOffset.x;
    int page = floor((x - pageWidth / 2) / pageWidth);
    page = page + 1;
    self.pageControl.currentPage = page;
    NSLog(@"SCroll View Did Scroll");
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
    int countryIndex = self.pageControl.currentPage;
    NSLog(@"%d", self.pageControl.currentPage);
}

@end


