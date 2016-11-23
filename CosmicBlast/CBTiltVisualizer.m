//
//  CBTiltVisualizer.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 11/23/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

#import "CBTiltVisualizer.h"

@implementation CBTiltVisualizer{
    CMMotionManager * motionManager;
    SKShapeNode * indicatorLine;
}

+(instancetype)tiltVisualizerWithMotionManager:(CMMotionManager *)manager{
    CBTiltVisualizer * visualizer = [CBTiltVisualizer node];
    visualizer->motionManager = manager;
//    SKSpriteNode * line = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(10, 40)];
//    [visualizer addChild:line];
    return visualizer;
    
}

-(void)update{
    CMAccelerometerData* data = motionManager.accelerometerData;
    
    
    
    
    
    
    
    NSLog(@"menu data.acceleration.x = %f, menu data.acceleration.y = %f, menu data.acceleration.z = %f",data.acceleration.x, data.acceleration.y, data.acceleration.z);
    float lineX = roundf( data.acceleration.x*200.0);
    
    float lineY = roundf( data.acceleration.y*200.0);

    SKShapeNode *yourline = [SKShapeNode node];
    
    CGMutablePathRef pathToDraw = CGPathCreateMutable();
    CGPathMoveToPoint(pathToDraw, NULL, 0.0, 0.0);
    CGPathAddLineToPoint(pathToDraw, NULL, lineX, lineY);
    yourline.path = pathToDraw;
    [yourline setStrokeColor:[SKColor blackColor]];
    [yourline setLineWidth:5];
    [yourline setGlowWidth:2];
    [yourline setLineCap:kCGLineCapRound];
    [self->indicatorLine removeFromParent];
    self->indicatorLine = yourline;
    [self addChild:yourline];



}




@end
