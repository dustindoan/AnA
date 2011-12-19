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
    
    UIButton *nextButton;
    UIButton *previousButton;
    
    UIButton* tvButton;
    UIPageControl* pageControl;
    
    IBOutlet UIScrollView *scrollView;
}

@property (nonatomic, retain) IBOutlet UILabel *factionLabel;

@property (nonatomic, retain) IBOutlet UIButton *tvButton;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;
@property (nonatomic, retain) IBOutlet UIButton *previousButton;

@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;

-(IBAction) stuff;
-(IBAction) doNext;
-(IBAction) doPrevious;
-(IBAction) changePage;

@end
