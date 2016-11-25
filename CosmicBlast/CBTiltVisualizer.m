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
    NSMutableArray * pastXData;
    NSMutableArray * pastYData;
    int accelerometerDataMemoryLength;
}


+(instancetype)tiltVisualizerWithMotionManager:(CMMotionManager *)manager{
    CBTiltVisualizer * visualizer = [CBTiltVisualizer node];
    visualizer -> motionManager = manager;
    visualizer -> pastXData = [[NSMutableArray alloc] init];
    visualizer -> pastYData = [[NSMutableArray alloc] init];
    visualizer -> accelerometerDataMemoryLength = 9;
//    SKSpriteNode * line = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(10, 40)];
//    [visualizer addChild:line];
    return visualizer;
    
}

-(void)update{
    CMAccelerometerData* data = motionManager.accelerometerData;
//    NSLog(@"menu data.acceleration.x = %f, menu data.acceleration.y = %f, menu data.acceleration.z = %f",data.acceleration.x, data.acceleration.y, data.acceleration.z);
    
    //X data first
    NSNumber * lineXData = [NSNumber numberWithFloat:roundf( data.acceleration.x*200.0)];
    [self->pastXData addObject:lineXData];
    if([pastXData count] > self->accelerometerDataMemoryLength) {
        [pastXData removeObjectAtIndex:0];
    }
    float xTotal = 0.0;
    for (NSNumber * x in pastXData) {
        xTotal += [x floatValue];
    }
    float lineX = xTotal/[pastXData count];
    
    
    //Then Y Data
    NSNumber * lineYData = [NSNumber numberWithFloat:roundf( data.acceleration.y*200.0)];
    [self->pastYData addObject:lineYData];
    if([pastYData count] > self->accelerometerDataMemoryLength) {
        [pastYData removeObjectAtIndex:0];
    }
    float yTotal = 0.0;
    for (NSNumber * y in pastYData) {
        yTotal += [y floatValue];
    }
    float lineY = yTotal/[pastYData count];

    SKShapeNode *yourline = [SKShapeNode node];
    
    CGMutablePathRef pathToDraw = CGPathCreateMutable();
    CGPathMoveToPoint(pathToDraw, NULL, 0.0, 0.0);
    CGPathAddLineToPoint(pathToDraw, NULL, lineX, lineY);
    yourline.path = pathToDraw;
    [yourline setStrokeColor:[SKColor blueColor]];
    [yourline setLineWidth:5];
    //[yourline setGlowWidth:2];
    [yourline setLineCap:kCGLineCapRound];
    [self->indicatorLine removeFromParent];
    self->indicatorLine = yourline;
    [self addChild:yourline];



}




@end
