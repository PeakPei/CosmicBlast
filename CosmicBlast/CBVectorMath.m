//
//  CBVectorMath.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/28/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBVectorMath.h"

@implementation CBVectorMath

//VectorAddition
+(CGPoint)cbVectorAddFirst:(CGPoint)a Second:(CGPoint)b{
    return CGPointMake(a.x + b.x, a.y + b.y);
}

//Vector subtraction
+(CGPoint)cbVectorSubFirst:(CGPoint)a Second:(CGPoint)b{
    return CGPointMake(a.x - b.x, a.y - b.y);
}


//Vector multiplication
+(CGPoint)cbVectorMultFirst:(CGPoint)a Value:(float)b{
    return CGPointMake(a.x * b, a.y * b);
}

+(CGVector)vectorAddFirst:(CGVector)v1 second:(CGVector)v2{
    return CGVectorMake(v1.dx+v2.dx, v1.dy+v2.dy);
}

+(CGVector)vectorSubFirst:(CGVector)v1 second:(CGVector)v2{
    return CGVectorMake(v1.dx-v2.dx, v1.dy-v2.dy);
}

+(CGVector)vectorMult:(CGVector)vector Value:(float)multiplier{
    return CGVectorMake(vector.dx * multiplier, vector.dy * multiplier);
}

+(CGVector)vectorNormalize:(CGVector)a{
    float length = [CBVectorMath vectorLength:a];
    return CGVectorMake(a.dx / length, a.dy / length);
}

+(float)vectorLength:(CGVector)a{
    return sqrtf(a.dx*a.dx + a.dy * a.dy);
}

///Vector Length
+(float)cbVectorLength:(CGPoint)a{
    return sqrtf(a.x*a.x + a.y * a.y);
}

//Vector normalization (makes length = 1)
+(CGPoint)cbVectorNormalize:(CGPoint)a{
    float length = [CBVectorMath cbVectorLength:a];
    return CGPointMake(a.x / length, a.y/length);
}

+(float)vectorAngleFirst:(CGVector)a Second:(CGVector)b{
    //float angle = atan2(a.dy - b.dy, a.dx - b.dx);
    float angle = atan2(a.dx - b.dx, a.dy - b.dy);
    //Math.atan2(vectorA.y - vectorB.y, vectorA.x - vectorB.x)
    
    return angle;
}




@end
