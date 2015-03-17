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
    
    
    //int ox = world.frame.origin.x;
    //int oy = world.frame.origin.y;
    //int sh = world.size.height;
    //int sw = world.size.width;
    
    
    
    //NSLog(@" World frame and size:    ox = %i; oy = %i; sh = %i; sw = %i;", ox, oy, sh, sw);
    
    
    
    
    
    return world;
}










@end
