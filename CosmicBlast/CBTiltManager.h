//
//  CBTiltManager.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 5/30/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBVectorMath.h"

@interface CBTiltManager : NSObject
@property BOOL customTilt;

+(id)tiltManager;

-(CGVector)getXY;

-(void)setTiltZero;
-(void)resetTiltZero;



@end
