//
//  CBMyScene.h
//  CosmicBlast
//

//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CBButtonBar.h"
#import "CBWorld.h"
#import "CBPlayer.h"
#import "CBHealthBar.h"
#import "CBStats.h"
#import "CBButtonDelegate.h"
#import "CBGameSceneDelegate.h"


@interface CBMyScene : SKScene <SKPhysicsContactDelegate, CBButtonDelegate>

@property (weak) id <CBGameSceneDelegate> gameDelegate;

@property (nonatomic) CBPlayer * player;
@property (nonatomic) CBWorld * currentWorld;
@property (nonatomic) NSMutableArray * Units;
@property (nonatomic) NSMutableArray * walls;
@property (nonatomic) CBButtonBar * buttonBar;
@property(nonatomic) CBHealthBar * healthBar;
@property(nonatomic) CBStats * stats;


@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
-(void)returnToParentMenu;




@end
