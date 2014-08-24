//
//  CBMyScene.h
//  CosmicBlast
//

//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import"CBWorld.h"

@interface CBMyScene : SKScene

@property (nonatomic) SKSpriteNode * player;
@property (nonatomic) CBWorld * currentWorld;

@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;


@end
