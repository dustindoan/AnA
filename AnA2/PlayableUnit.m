//
//  Unit.m
//  AnA2
//
//  Created by Dustin Doan on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayableUnit.h"

@implementation PlayableUnit

- (id)init {
    self = [super init];
    if (self) {
        variable = true;
    }
    return self;
}

- (void) methodology {
    PlayableUnit* unit = [PlayableUnit new];
    [unit doStuff];
}

- (void) doStuff {
    if (variable) {
        NSLog(@"yo");
    } else
        NSLog(@"no");
}
@end
