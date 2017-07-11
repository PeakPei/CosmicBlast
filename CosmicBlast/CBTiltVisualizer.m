//
//  CBTiltVisualizer.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 11/23/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

#import "CBTiltVisualizer.h"

#import <CosmicBlast-Swift.h>

@implementation CBTiltVisualizer{
    SKShapeNode * indicatorLine;
    NSMutableArray * pastXData;
    NSMutableArray * pastYData;
    int accelerometerDataMemoryLength;
}


+(instancetype)tiltVisualizerWithTiltManager:(CBTiltManager *)manager{
    CBTiltVisualizer * visualizer = [CBTiltVisualizer node];
    [visualizer setTiltManager:manager];
    visualizer -> pastXData = [[NSMutableArray alloc] init];
    visualizer -> pastYData = [[NSMutableArray alloc] init];
    visualizer -> accelerometerDataMemoryLength = (int)[[[GameValues alloc] init] accelerometerDataMemoryLength];
    return visualizer;
    
}

-(void)update{

    CGVector data = [self.tiltManager getXY];
    NSNumber * lineXData = [NSNumber numberWithFloat:roundf( data.dx*200.0)];
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
    NSNumber * lineYData = [NSNumber numberWithFloat:roundf( data.dy*200.0)];
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
    UIColor * lineColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4];
    [yourline setStrokeColor:lineColor];
    
    [yourline setLineWidth:5];
    [yourline setLineCap:kCGLineCapRound];

    [self->indicatorLine removeFromParent];
    self->indicatorLine = yourline;
    [self addChild:yourline];



}




@end
