//
//  ViewController.h
//  AnA2
//
//  Created by Dustin Doan on 11-12-19.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    UILabel *factionLabel;
    
    UISwitch* tvButton;
    UIPageControl* pageControl;
    
    IBOutlet UIScrollView *scrollView;
}

@property (nonatomic, retain) IBOutlet UILabel *factionLabel;

@property (nonatomic, retain) IBOutlet UISwitch *tvButton;

@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;

-(IBAction) tvSwitched;
-(IBAction) doNext;
-(IBAction) doPrevious;
-(IBAction) changePage;

-(void) tvOut;
@end
