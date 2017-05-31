//
//  CBTiltManager.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 5/30/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

#import "CBTiltManager.h"
@import CoreMotion;

@implementation CBTiltManager

CMMotionManager * _motionManager;

+(id)tiltManager{
    CBTiltManager * manager = [[CBTiltManager alloc] init];
    _motionManager = [[CMMotionManager alloc] init];
    [manager startMonitoringAcceleration];
    return manager;
}


+(float)getY{
    return 30.0;
}

-(void)startMonitoringAcceleration{
    
    if(_motionManager.accelerometerAvailable){
        [_motionManager startAccelerometerUpdates];
        NSLog(@"start montioring acceleration called");
    }
    else{
        NSLog(@"motionManager.accelerometerAvailable is false");
    }
}


-(CGVector)getXY{
    //Update this to reflect calculation for offset
    CMAccelerometerData* data = _motionManager.accelerometerData;
    CGVector xy = CGVectorMake(data.acceleration.x,data.acceleration.y);
    return xy;
}

-(float)getX{
    return 30.0;
}

@end
