//
//  CBWorld.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/23/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBWorld.h"
#import <CosmicBlast-Swift.h>


@implementation CBWorld

+ (id)worldWithImageNamed:(NSString *)name {
     CBWorld * world = [CBWorld spriteNodeWithImageNamed:name];
    world.position = CGPointZero;
    return world;
}

+(id)world {
    GameValues * gameValues = [[GameValues alloc] init];
    CBWorld * world = [CBWorld spriteNodeWithImageNamed:[gameValues worldImageName]];
    
    return world;

}


@end
