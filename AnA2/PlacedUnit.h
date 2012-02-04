//
//  PlacedUnit.h
//  AnA2
//
//  Created by Dustin Doan on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

typedef enum Unit { Infantry, Artillery, Tank, Fighter, Bomber, Transport, Submarine, Destroyer, Cruiser, Battleship, Carrier} Unit;

@interface PlacedUnit : NSObject {
    UIImage* image;
}

@property (readwrite) Unit unitType;
@property (readwrite) int count;

- (id)initWithUnit:(int) placedUnit;
-(void) setImage: (UIImage*) unitImage;
-(UIImage*) getImage;
-(NSString*) getImageFileName;

@end
