//
//  ViewController.h
//  AnA2
//
//  Created by Dustin Doan on 11-12-19.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    UISwitch* tvButton;
    UIPageControl* pageControl;
    
    UINavigationBar *navBar;
    
    IBOutlet UIScrollView *scrollView;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;

@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;

-(IBAction) changePage;

-(void) setPage: (int) page;
-(int) getPage;

@end
