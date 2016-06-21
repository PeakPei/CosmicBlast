//
//  CBWorld.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/23/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBWorld.h"
#import <CosmicBlast-Swift.h>


@implementation CBWorld

+ (id)worldWithImageNamed:(NSString *)name {

     CBWorld * world = [CBWorld spriteNodeWithImageNamed:name];
    

    
    
    
    world.position = CGPointZero;
    
    
    //int ox = world.frame.origin.x;
    //int oy = world.frame.origin.y;
    //int sh = world.size.height;
    //int sw = world.size.width;
    
    
    
    //NSLog(@" World frame and size:    ox = %i; oy = %i; sh = %i; sw = %i;", ox, oy, sh, sw);
    
    return world;
}

+(id)world {
    GameValues * gameValues = [[GameValues alloc] init];
    
    
    UIImage * baseImage = [UIImage imageNamed:[gameValues worldImageName]];
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    CGSize worldSize = [gameValues worldSize];
    UIGraphicsBeginImageContextWithOptions(worldSize, NO, 0.0);
    [baseImage drawInRect:CGRectMake(0, 0, worldSize.width, worldSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    SKTexture * texture = [SKTexture textureWithImage:(newImage)];
    
    CBWorld * world = [CBWorld spriteNodeWithTexture:texture];
    
    
    return world;
    
    
    
    
    
    

    CBWorld * myWorld = [CBWorld worldWithImageNamed:@"checker.png"];
    myWorld.position = CGPointZero;

    return myWorld;
    
}




@end
