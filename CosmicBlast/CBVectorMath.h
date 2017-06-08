//
//  CBVectorMath.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/28/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBVectorMath : NSObject


+(CGPoint)cbVectorAddFirst:(CGPoint)a Second:(CGPoint)b;

+(CGVector)vectorAddFirst:(CGVector)v1 second:(CGVector)v2;

+(CGVector)vectorSubFirst:(CGVector)v1 second:(CGVector)v2;


+(CGPoint)cbVectorSubFirst:(CGPoint)a Second:(CGPoint)b;

+(CGPoint)cbVectorMultFirst:(CGPoint)a Value:(double)b;

+(double)cbVectorLength:(CGPoint)a;

+(CGPoint)cbVectorNormalize:(CGPoint)a;

+(CGVector)vectorMult:(CGVector)vector Value:(double)multiplier;

+(CGVector)vectorNormalize:(CGVector)a;

+(double)vectorAngleFirst:(CGVector)a Second:(CGVector)b;


+(double)vectorLength:(CGVector)a;


struct Vector3D{
    double x;
    double y;
    double z;
};


@end
