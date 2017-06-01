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

+(CGPoint)cbVectorMultFirst:(CGPoint)a Value:(float)b;

+(float)cbVectorLength:(CGPoint)a;

+(CGPoint)cbVectorNormalize:(CGPoint)a;

+(CGVector)vectorMult:(CGVector)vector Value:(float)multiplier;

+(CGVector)vectorNormalize:(CGVector)a;

+(float)vectorAngleFirst:(CGVector)a Second:(CGVector)b;


+(float)vectorLength:(CGVector)a;


struct Vector3D{
    float x;
    float y;
    float z;
};


@end
