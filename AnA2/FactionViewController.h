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
    UIImageView *factionIcon;

    NSString *mFactionName;
    NSString *mImageName;
}

@property (nonatomic, retain) IBOutlet UISwitch *tvButton;

@property (nonatomic, retain) IBOutlet UILabel *factionNameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *factionBackgroundImageView;
@property (nonatomic, retain) IBOutlet UIImageView *factionIcon;

- (void) tvOut;
- (id)initWithFaction:(NSString *)factionName imageName:(NSString *)imageName;
- (void) setFaction: (NSString *) factionName: (NSString *) imageName;
- (IBAction) tvSwitched;
@end
