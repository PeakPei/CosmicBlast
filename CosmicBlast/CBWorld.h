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
@property CGPoint drawingPoint;

+ (id)worldWithImageNamed:(NSString *)name drawingPosition:(CGPoint)drawPoint;


-(void)moveCameraWithAccelerationXValue:(double)x yValue:(double)y;

@end
