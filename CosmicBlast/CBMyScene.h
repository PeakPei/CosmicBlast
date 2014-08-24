//
//  CBMyScene.h
//  CosmicBlast
//

//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CBMyScene : SKScene

@property (nonatomic) SKSpriteNode * player;



@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;


@end
