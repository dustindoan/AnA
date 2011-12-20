//
//  FactionViewController.h
//  AnA2
//
//  Created by Chruszcz, Brad on 11-12-19.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FactionViewController : UIViewController {
    UILabel *factionNameLabel;
    UIImageView *factionBackgroundImageView;
    
    NSString *mFactionName;
}

@property (nonatomic, retain) IBOutlet UILabel *factionNameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *factionBackgroundImageView;

- (id)initWithFaction:(NSString *)factionName;

@end
