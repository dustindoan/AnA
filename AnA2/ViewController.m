//
//  ViewController.m
//  AnA2
//
//  Created by Dustin Doan on 11-12-19.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize tvButton, nextButton, previousButton;
@synthesize factionLabel;
@synthesize scrollView;
@synthesize pageControl;

bool pageControlBeingUsed = NO;

-(IBAction) stuff {
    [self.tvButton setTitle:@"Done!" forState:UIControlStateNormal];
    self.tvButton.enabled = false;
    //    [tvOut];
}

-(IBAction) doNext {
    factionLabel.text = @"Next";
}

-(IBAction) doPrevious {
    factionLabel.text = @"Prev";
}

//-(void) tvOut {change
//    NSLog(@"Number of screens: %d", [[UIScreen screens]count]);
//    
//    //Now, if there's an external screen, we need to find its modes, itereate through them and find the highest one. Once we have that mode, break out, and set the UIWindow.
//    
//    if([[UIScreen screens]count] > 1) //if there are more than 1 screens connected to the device
//    {
//        CGSize max;
//        UIScreenMode *maxScreenMode;
//        for(int i = 0; i < [[[[UIScreen screens] objectAtIndex:1] availableModes]count]; i++)
//        {
//            UIScreenMode *current = [[[[UIScreen screens]objectAtIndex:1]availableModes]objectAtIndex:i];
//            if(current.size.width > max.width);
//            {
//                max = current.size;
//                maxScreenMode = current;
//            }
//        }
//        //Now we have the highest mode. Turn the external display to use that mode.
//        UIScreen *external = [[UIScreen screens] objectAtIndex:1];
//        external.currentMode = maxScreenMode;
//        //Boom! Now the external display is set to the proper mode. We need to now set the screen of a new UIWindow to the external screen
//        external_disp = [externalDisplay alloc];
//        external_disp.drawImage = drawViewController.drawImage;
//        UIWindow *newwindow = [UIWindow alloc];
//        [newwindow addSubview:external_disp.view];
//        newwindow.screen = external;
//    }
//}

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
    
    NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    for (int i = 0; i < colors.count; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview.backgroundColor = [colors objectAtIndex:i];
        [self.scrollView addSubview:subview];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * colors.count, self.scrollView.frame.size.height);

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


