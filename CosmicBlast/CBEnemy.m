//
//  CBEnemy.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/23/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBEnemy.h"

@implementation CBEnemy


+(id)enemyWithImageNamed:(NSString *)name{

    CBEnemy * enemy = [CBEnemy spriteNodeWithImageNamed:name];

    return enemy;
}


@end
