//
//  CBMenuScene.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 12/26/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBMenuScene.h"
#import "CBLogger.h"
@import CoreMotion;


@implementation CBMenuScene

CMMotionManager * _motionManager;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
    //TODO make Background Color game values
        [self setBackgroundColor: [UIColor redColor]];
        
        _motionManager = [[CMMotionManager alloc] init];
        [self startMonitoringAcceleration];
        NSLog(@"started monitoring");
        
    }
    return self;
};

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.gameDelegate launchGameScreen];
}



-(void)startMonitoringAcceleration{
    
    NSLog(@"Starting to monitor in method");
    if(_motionManager.accelerometerAvailable){
        [_motionManager startAccelerometerUpdates];
        NSLog(@"accelerometer updates on...");
    }
    else{
        NSLog(@"motionManager.accelerometerAvailable is false");
    }
}

-(void)update:(NSTimeInterval)currentTime{
    CMAccelerometerData* data = _motionManager.accelerometerData;
    NSLog(@"menu data.acceleration.x = %f, menu data.acceleration.y = %f",data.acceleration.x, data.acceleration.y);
}


        
        
@end
