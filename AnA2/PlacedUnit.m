//
//  PlacedUnit.m
//  AnA2
//
//  Created by Dustin Doan on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlacedUnit.h"

@implementation PlacedUnit 

@synthesize unitType;
@synthesize count;

- (id)initWithUnit:(Unit) placedUnit {
    self = [super init];
    if (self) {
        unitType = placedUnit;
        count = 0;
    }
    return self;
}

-(void)setCount:(int)countInt {
    count = countInt;
}

-(int) getCount {
    return count;
}

-(void)setImage:(UIImage *)unitImage {
    Unit something = Infantry;
    image = unitImage;
}

-(UIImage *)getImage {
    return image;
}

-(NSString*) getImageFileName {
    switch (unitType) {
        case Tank:
            return @"tank.png";
        case Infantry:
            return @"infantry.png";
        case Artillery:
            return @"artillery.png";
        case Bomber:
            return @"bomber.png";
        case Fighter:
            return @"fighter.png";
        case Transport:
            return @"transport.png";
        case Submarine:
            return @"submarine.png";
        case Destroyer:
            return @"destroyer.png";
        case Cruiser:
            return @"cruiser.png";
        case Battleship:
            return @"battleship.png";
        case Carrier:
            return @"carrier.png";
        default:
            return NULL;
    }
}

@end
