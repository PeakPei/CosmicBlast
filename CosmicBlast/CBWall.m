//
//  CBWall.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 12/9/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

#import "CBWall.h"

@implementation CBWall



+(id)wall{
    
    //CBWall * wall = [CBWall spriteNodeWithColor:[UIColor grayColor] size:CGSizeMake(10, 600)];
    CBWall * wall = [CBWall spriteNodeWithImageNamed:@"Wall1"];
    return wall;
}

@end
