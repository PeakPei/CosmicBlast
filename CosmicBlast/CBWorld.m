//
//  CBWorld.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/23/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBWorld.h"

@implementation CBWorld

+ (id)worldWithImageNamed:(NSString *)name position:(CGPoint)drawPoint{
    
     CBWorld * world = [CBWorld spriteNodeWithImageNamed:name];
    world.position = drawPoint;
    
    return world;
}


-(void)moveCameraWithAccelerationXValue:(double)x yValue:(double)y{
    
    if (x > .2){
        CGPoint oldPoint = CGPointMake(self.position.x, self.position.y);
        self.position = CGPointMake(oldPoint.x - 1, oldPoint.y);
    }
    if (x < -.2){
        
        CGPoint oldPoint = CGPointMake(self.position.x, self.position.y);
        self.position = CGPointMake(oldPoint.x + 1, oldPoint.y);
        
    }
    if (y > .2){
        
        CGPoint oldPoint = CGPointMake(self.position.x, self.position.y);
        self.position = CGPointMake(oldPoint.x, oldPoint.y+1);
        
    }
    if (y < -.2){
        CGPoint oldPoint = CGPointMake(self.position.x, self.position.y);
        self.position = CGPointMake(oldPoint.x, oldPoint.y-1);
    }
        
    
}





@end
