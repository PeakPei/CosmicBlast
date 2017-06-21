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
    manager->tiltZero.z = -1.0;
    
    manager->realZero.x = 0.0;
    manager->realZero.y = 0.0;
    manager->realZero.z = -1.0;
    return manager;
}


-(void)setTiltZero{
    CMAccelerometerData* data = _motionManager.accelerometerData;
    struct Vector3D rawData;
    
    rawData.x = data.acceleration.x;
    rawData.y = data.acceleration.y;
    rawData.z = data.acceleration.z;
//    rawData.x = 0;
//    rawData.y = -1;
//    rawData.z = 0;
    tiltZero =[self normalizeVector3D:rawData];
    //self->tiltZero = rawData;

    
    NSLog(@"****START********");
    NSLog(@"tiltZero.x = %f, tiltZero.y = %f, tiltZero.z = %f ", tiltZero.x, tiltZero.y, tiltZero.z);
    NSLog(@"****STOP********");
    NSLog(@"Tilt Zero Set");
    
}

-(void)resetTiltZero{
    CMAccelerometerData* data = _motionManager.accelerometerData;
    struct Vector3D zero;
    
    zero.x = 0;
    zero.y = 0;
    zero.z = -1.0;
    
    //self->tiltZero =[self normalizeVector3D:rawData];
    self->tiltZero = zero;
    
    
    NSLog(@"****START********");
    NSLog(@"tiltZero.x = %f, tiltZero.y = %f, tiltZero.z = %f ", tiltZero.x, tiltZero.y, tiltZero.z);
    NSLog(@"****STOP********");
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
    struct Vector3D normalVector = [self normalizeVector3D:rawVector];
    
    
    struct Vector3D transformedVector = [self applyRotation:normalVector];
    CGVector xy = CGVectorMake(transformedVector.x, transformedVector.y);
    CGVector xyOrig = CGVectorMake(rawVector.x, rawVector.y);
//    NSLog(@"****START********");
//    NSLog(@"getXY = x %f, y:%f",xy.dx,xy.dy);
//    NSLog(@"xyOrig = x %f, y:%f",xyOrig.dx,xyOrig .dy);
//    NSLog(@"****STOP********");

    return xy;
}






//-(struct Vector3D)applyRotation:(struct Vector3D)v{
//    
//    struct Vector3D toReturn;
//    double thetaX = [CBVectorMath vectorAngleFirst:(CGVectorMake(realZero.y, realZero.z)) Second:CGVectorMake(tiltZero.y, tiltZero.z)];
//    
//    double thetaY = -1 * [CBVectorMath vectorAngleFirst:(CGVectorMake(realZero.x, realZero.z)) Second:CGVectorMake(tiltZero.x, tiltZero.z)];
//    
//    NSLog(@"thetaX = x %f, thetaY:%f", thetaX, thetaY);
//
//    
//    double newX = v.x * cos(thetaY) + (v.y * sin(thetaX) + v.z * cos(thetaX)) * sin(thetaY);
//    double newY = (v.y * cos(thetaX)) - (v.z * sin(thetaX));
//    double newZ = (v.y * sin(thetaX) + v.z * cos(thetaX)) * cos(thetaY) - v.x * sin(thetaY);
//    
//    toReturn.x = newX;
//    toReturn.y = newY;
//    toReturn.z = newZ;
//    
//    NSLog(@"\ntransformed = (%f, %f, %f) len = %f",newX,newY,newZ,[self getVectorLength:toReturn]);
//    NSLog(@"\noriginal = (%f, %f, %f) len = %f", v.x,v.y,v.z, [self getVectorLength:v]);
//    //NSLog(@"xyOrig = x %f, y:%f",xyOrig.dx,xyOrig .dy);
//    return toReturn;
//}

-(struct Vector3D)applyRotation:(struct Vector3D)v{
    struct Vector3D toReturn;
    double theta = -1 * [self vectorAngleFirst:tiltZero Second:realZero];
    struct Vector3D axis = [self normalizeVector3D:[self getCrossProductFirst:realZero Second:tiltZero]];
    
    double cosT = cos(theta);
    double sinT = sin(theta);
    
    double newX = v.x * (cosT + pow(axis.x, 2.0) * (1 - cosT)) + v.y * (axis.x * axis.y *(1 - cosT) - axis.z * sinT) + v.z * (axis.x * axis.z * (1 - cosT) + axis.y * sinT);
    
    double newY = v.x * (axis.y * axis.x * (1 - cosT) + axis.z * sinT) + v.y * (cosT + pow(axis.y, 2.0) * (1 - cosT)) + v.z * (axis.y * axis.z * (1 - cosT) - axis.x * sinT);
    
    
    double newZ = v.x * (axis.z * axis.x * (1 - cosT) - axis.y * sinT) + v.y * (axis.z * axis.y * (1 - cosT) + axis.x * sinT) + v.z * (cosT + pow(axis.z ,2.0) * (1 - cosT));
    
    toReturn.x = newX;
    toReturn.y = newY;
    toReturn.z = newZ;

    
    return toReturn;
}



-(double)getVectorLength:(struct Vector3D)vector{
    return sqrt((vector.x * vector.x ) + (vector.y * vector.y)  + (vector.z * vector.z));
}

-(struct Vector3D)normalizeVector3D:(struct Vector3D)vector{
    //length = sqrt((ax * ax) + (ay * ay) + (az * az))
    struct Vector3D toReturn;
    double length = [self getVectorLength:vector];
    if(length == 0){
        toReturn.x = 0;
        toReturn.y = 0;
        toReturn.z = 1;
        return toReturn;
    }

    toReturn.x = vector.x/length;
    toReturn.y = vector.y/length;
    toReturn.z = vector.z/length;
    
    return toReturn;
}

-(struct Vector3D)getCrossProductFirst:(struct Vector3D)v1 Second:(struct Vector3D)v2{
    struct Vector3D toReturn;
    toReturn.x = (v1.y * v2.z) - (v1.z * v2.y);
    toReturn.y = (v1.z * v2.x) - (v1.x * v2.z);
    toReturn.z = (v1.x * v2.y) - (v1.y * v2.x);
    return toReturn;
}


-(double)vectorAngleFirst:(struct Vector3D)v1 Second:(struct Vector3D)v2{
    double dotProduct = [self dotProductFirst:v1 Second:v2];
    double denominator = [self getVectorLength:v1] * [self getVectorLength:v2];
    return acos(dotProduct/denominator);
}


-(double)dotProductFirst:(struct Vector3D)v1 Second:(struct Vector3D)v2{
    return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
}
@end
