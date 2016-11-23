//
//  CBTiltVisualizer.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 11/23/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@import CoreMotion;
@interface CBTiltVisualizer : SKNode

+(instancetype)tiltVisualizerWithMotionManager:(CMMotionManager *)manager;

-(void)update;

@end
