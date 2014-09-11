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

///Vector Length
+(float)cbVectorLength:(CGPoint)a{
    return sqrtf(a.x*a.x + a.y * a.y);
}

//Vector normalization (makes length = 1)
+(CGPoint)cbVectorNormalize:(CGPoint)a{
    float length = [CBVectorMath cbVectorLength:a];
    return CGPointMake(a.x / length, a.y/length);
    
}


@end
