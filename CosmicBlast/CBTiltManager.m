//
//  CBTiltManager.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 5/30/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

#import "CBTiltManager.h"
@import CoreMotion;

@implementation CBTiltManager{
    struct Vector3D tiltZero;
    struct Vector3D realZero;
}

CMMotionManager * _motionManager;






+(id)tiltManager{
    
    CBTiltManager * manager = [[CBTiltManager alloc] init];
    _motionManager = [[CMMotionManager alloc] init];
    [manager startMonitoringAcceleration];
    manager->tiltZero.x = 0.0;
    manager->tiltZero.y = 0.0;
    manager->tiltZero.z = 1.0;
    
    manager->realZero.x = 0.0;
    manager->realZero.y = 0.0;
    manager->realZero.z = 1.0;
    return manager;
}


-(void)setTiltZero{
    CMAccelerometerData* data = _motionManager.accelerometerData;
    self->tiltZero.x = data.acceleration.x;
    self->tiltZero.y = data.acceleration.y;
    self->tiltZero.z = data.acceleration.z;
    NSLog(@"Tilt Zero Set");
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
    CGVector xyOrig = CGVectorMake(rawVector.x, rawVector.y);
    NSLog(@"****START********");
    NSLog(@"getXY = x %f, y:%f",xy.dx,xy.dy);
    NSLog(@"xyOrig = x %f, y:%f",xyOrig.dx,xyOrig .dy);
    NSLog(@"****STOP********");

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
    
    struct Vector3D vn = v;
    //[self normalizeVector3D:v];
    struct Vector3D toReturn;
    
    float thetaX = [CBVectorMath vectorAngleFirst:(CGVectorMake(self->realZero.y, self->realZero.z)) Second:CGVectorMake(vn.y, vn.z)];
    
    float thetaY = [CBVectorMath vectorAngleFirst:(CGVectorMake(self->realZero.x, self->realZero.z)) Second:CGVectorMake(vn.x, vn.z)];
 
    
    float newX = v.x * cos(thetaY) + (v.y * sin(thetaX) + v.z * cos(thetaX)) * sin(thetaY);
    float newY = (v.y * cos(thetaX))- (v.z * sin(thetaX));
    float newZ = (v.y * sin(thetaX) + v.z * cos(thetaX)) * cos(thetaY) - v.x * sin(thetaY);
    
    toReturn.x = newX;
    toReturn.y = newY;
    toReturn.z = newZ;
    return toReturn;
}



@end
