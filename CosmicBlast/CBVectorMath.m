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
+(CGPoint)cbVectorMultFirst:(CGPoint)a Value:(double)b{
    return CGPointMake(a.x * b, a.y * b);
}

+(CGVector)vectorAddFirst:(CGVector)v1 second:(CGVector)v2{
    return CGVectorMake(v1.dx+v2.dx, v1.dy+v2.dy);
}

+(CGVector)vectorSubFirst:(CGVector)v1 second:(CGVector)v2{
    return CGVectorMake(v1.dx-v2.dx, v1.dy-v2.dy);
}

+(CGVector)vectorMult:(CGVector)vector Value:(double)multiplier{
    return CGVectorMake(vector.dx * multiplier, vector.dy * multiplier);
}

+(CGVector)vectorNormalize:(CGVector)a{
    double length = [CBVectorMath vectorLength:a];
    return CGVectorMake(a.dx / length, a.dy / length);
}

+(double)vectorLength:(CGVector)a{
    return sqrtf(a.dx*a.dx + a.dy * a.dy);
}

///Vector Length
+(double)cbVectorLength:(CGPoint)a{
    return sqrtf(a.x*a.x + a.y * a.y);
}

//Vector normalization (makes length = 1)
+(CGPoint)cbVectorNormalize:(CGPoint)a{
    double length = [CBVectorMath cbVectorLength:a];
    return CGPointMake(a.x / length, a.y/length);
}

+(double)vectorAngleFirst:(CGVector)b Second:(CGVector)a{
    

    

//    a = [CBVectorMath vectorNormalize:a];
//    b = [CBVectorMath vectorNormalize:b];
    
    double dotProduct = (a.dx * b.dx) + (a.dy * b.dy);
    double determinant = (a.dx * b.dy) - (a.dy * b.dx);
    double angle1;
//    if (dotProduct < 0){
//        angle1 = atan2(determinant, dotProduct) - M_PI;
//        
//    } else {
//        angle1 = atan2(determinant, dotProduct);
//    }
    angle1 = atan2(determinant, dotProduct);
    
    //float angle1 = acos(dotProduct/(lengthA*lengthB));
//    float angle = atan2f( a.dy - b.dy , a.dx - b.dx) + M_PI;
//    float angle = atan2(a.dx - b.dx, a.dy - b.dy);
    
    
    

    
    return angle1;
}



+(double)angleFromVector:(CGVector)v{
    return atan2 (v.dy, v.dx);
}


+(CGVector)vectorFromAngle:(double)a{
    CGVector v;
    v.dx = cos(a);
    v.dy = sin(a);
    return v;
}



@end
