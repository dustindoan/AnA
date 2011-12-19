//
//  ViewController.m
//  AnA2
//
//  Created by Dustin Doan on 11-12-19.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize tvButton;

-(IBAction) stuff {
    [self.tvButton setTitle:@"Done!" forState:UIControlStateNormal];
    self.tvButton.enabled = false;
    //    [tvOut];
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

@end
