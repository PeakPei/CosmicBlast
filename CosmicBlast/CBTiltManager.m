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


struct Vector3D{
    float x;
    float y;
    float z;
};


+(id)tiltManager{
    CBTiltManager * manager = [[CBTiltManager alloc] init];
    _motionManager = [[CMMotionManager alloc] init];
    [manager startMonitoringAcceleration];
    return manager;
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
    struct Vector3D rawVector;
    rawVector.x = data.acceleration.x;
    rawVector.y = data.acceleration.y;
    rawVector.z = data.acceleration.z;
    
    struct Vector3D transformedVector = [self applyRotation:rawVector];
    
    CGVector xy = CGVectorMake(transformedVector.x, transformedVector.y);
    return xy;
}



-(struct Vector3D)normalizeVector3D:(struct Vector3D)vector{
    //length = sqrt((ax * ax) + (ay * ay) + (az * az))
    float length = sqrtf(pow(vector.x, 2.0)) + (pow(vector.y, 2.0))  + (pow(vector.z, 2.0));
    struct Vector3D toReturn;
    toReturn.x = vector.x/length;
    toReturn.y = vector.y/length;
    toReturn.z = vector.z/length;
    
    return toReturn;
}



-(struct Vector3D)applyRotation:(struct Vector3D)v{
    struct Vector3D toReturn;
    float thetaX = M_PI/8;
    float thetaY = 0;
    
    float newX = v.x * cos(thetaY) + (v.y * sin(thetaX) + v.z * cos(thetaX)) * sin(thetaY);
    float newY = v.y * cos(thetaX)-v.z * sin(thetaX);
    float newZ = (v.y * sin(thetaX) + v.z * cos(thetaX)) * cos(thetaY) - v.x * sin(thetaY);
    
    toReturn.x = newX;
    toReturn.y = newY;
    toReturn.z = newZ;
    return toReturn;
}



@end
