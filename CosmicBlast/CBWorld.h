//
//  CBWorld.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/23/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CBWorld : SKSpriteNode

@property CGPoint playerLocation;


+ (id)worldWithImageNamed:(NSString *)name position:(CGPoint)drawPoint;


-(void)moveCameraWithAccelerationXValue:(double)x yValue:(double)y speed:(int)speed;

@end
