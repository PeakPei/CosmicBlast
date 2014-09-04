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


-(void)moveCameraWithAccelerationXValue:(double)x yValue:(double)y speed:(int)speed{
    
    
    
    if (x > .2){
        CGPoint oldPoint = CGPointMake(self.position.x, self.position.y);
        self.position = CGPointMake(oldPoint.x - speed, oldPoint.y);
    }
    if (x < -.2){
        
        CGPoint oldPoint = CGPointMake(self.position.x, self.position.y);
        self.position = CGPointMake(oldPoint.x + speed, oldPoint.y);
        
    }
    if (y < -.5){
        
        CGPoint oldPoint = CGPointMake(self.position.x, self.position.y);
        self.position = CGPointMake(oldPoint.x, oldPoint.y + speed);
        
    }
    if (y > -.2){
        CGPoint oldPoint = CGPointMake(self.position.x, self.position.y);
        self.position = CGPointMake(oldPoint.x, oldPoint.y - speed);
    }
    //just log out some data
    
    //NSLog(@"worldPosition x = %f worldPosition y = %f", self.position.x, self.position.y);
    
}







@end
