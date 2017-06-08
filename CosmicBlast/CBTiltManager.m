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
    
    self->tiltZero =[self normalizeVector3D:rawData];
    self->tiltZero = rawData;

    
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
    zero.z = 0;
    
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
    
    struct Vector3D transformedVector = [self applyRotation:rawVector];
    CGVector xy = CGVectorMake(transformedVector.x, transformedVector.y);
    CGVector xyOrig = CGVectorMake(rawVector.x, rawVector.y);
//    NSLog(@"****START********");
//    NSLog(@"getXY = x %f, y:%f",xy.dx,xy.dy);
//    NSLog(@"xyOrig = x %f, y:%f",xyOrig.dx,xyOrig .dy);
//    NSLog(@"****STOP********");

    return xy;
}






-(struct Vector3D)applyRotation:(struct Vector3D)v{
    

    struct Vector3D toReturn;
    
    
    //Should be looking at tilt Zero and real zero
//    float thetaX =  0;//M_PI;//[CBVectorMath vectorAngleFirst:(CGVectorMake(self->realZero.y, self->realZero.z)) Second:CGVectorMake(tiltZero.y, tiltZero.z)];
    
//    float thetaY = M_PI/6;//[CBVectorMath vectorAngleFirst:(CGVectorMake(self->realZero.x, self->realZero.z)) Second:CGVectorMake(tiltZero.x, tiltZero.z)];

    double thetaX = [CBVectorMath vectorAngleFirst:(CGVectorMake(realZero.y, realZero.z)) Second:CGVectorMake(tiltZero.y, tiltZero.z)];
    
    
    //float thetaY = [CBVectorMath vectorAngleFirst:CGVectorMake(tiltZero.x, tiltZero.z) Second:CGVectorMake(realZero.x, realZero.z)];
                                                                                               
    double thetaY = -1 * [CBVectorMath vectorAngleFirst:(CGVectorMake(realZero.x, realZero.z)) Second:CGVectorMake(tiltZero.x, tiltZero.z)];
    
    //    float thetaX = [CBVectorMath vectorAngleFirst:(CGVectorMake(self->realZero.y, self->realZero.z)) Second:CGVectorMake(v.y, v.z)];
//    
//    float thetaY = [CBVectorMath vectorAngleFirst:(CGVectorMake(self->realZero.x, self->realZero.z)) Second:CGVectorMake(v.x, v.z)];
 
//    NSLog(@"****START********");
//    NSLog(@"thetaX = x %f, thetaY:%f",thetaX,thetaY);
//    NSLog(@"****STOP********");
    
    struct Vector3D vn = [self normalizeVector3D:v];
    
    double newX = vn.x * cos(thetaY) + (vn.y * sin(thetaX) + vn.z * cos(thetaX)) * sin(thetaY);
    double newY = (vn.y * cos(thetaX)) - (vn.z * sin(thetaX));
    double newZ = (vn.y * sin(thetaX) + vn.z * cos(thetaX)) * cos(thetaY) - vn.x * sin(thetaY);
    
    toReturn.x = newX;
    toReturn.y = newY;
    toReturn.z = newZ;
    
    toReturn = [self normalizeVector3D:toReturn];
    //NSLog(@"\ntransformed = x:%f, y:%f, z:%f",newX,newY,newZ);

    //NSLog(@"xyOrig = x %f, y:%f",xyOrig.dx,xyOrig .dy);



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
        toReturn.z = 0;
        return toReturn;
    }

    toReturn.x = vector.x/length;
    toReturn.y = vector.y/length;
    toReturn.z = vector.z/length;
    NSLog(@"\noriginal length = %f",length);
    NSLog(@"\nnormalized length = %f",[self getVectorLength:toReturn]);
    return toReturn;
}
@end
