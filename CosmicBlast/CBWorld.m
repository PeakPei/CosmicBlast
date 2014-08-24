//
//  CBWorld.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/23/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBWorld.h"

@implementation CBWorld

+ (id)worldWithImageNamed:(NSString *)name drawingPosition:(CGPoint)drawPoint{
    
     CBWorld * world = [CBWorld spriteNodeWithImageNamed:name];
    world.drawingPoint = drawPoint;
    
    return world;
}


-(void)moveCameraWithAccelerationXValue:(double)x yValue:(double)y{
    
    if (x > .2){
        CGPoint oldPoint = CGPointMake(self.drawingPoint.x, self.drawingPoint.y);
        
        self.drawingPoint = CGPointMake(oldPoint.x + 5, oldPoint.y + 5);
    }
        
    
}





@end
