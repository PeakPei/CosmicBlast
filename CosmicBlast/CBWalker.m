//
//  CBWalker.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 9/4/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBWalker.h"
#import <CosmicBlast-Swift.h>
@implementation CBWalker


//creates a walker sprite with an image name
+(id)walkerWithImageNamed:(NSString *)name{
    
    CBWalker * walker = [CBWalker spriteNodeWithImageNamed:name];
    return walker;
}


+(id)walker{
    //GameValues * gameValues = [[GameValues alloc] init];
    CBWalker * walker = [CBWalker walkerWithImageNamed:@"EnemyShot"];
    //CBWalker * walker = [CBWalker spriteNodeWithColor:[gameValues walkerColor] size:[gameValues walkerSize]];
    return walker;
}


@end
