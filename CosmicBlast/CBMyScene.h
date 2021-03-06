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
#import "CBTiltManager.h"

@interface CBMyScene : SKScene <SKPhysicsContactDelegate, CBButtonDelegate>

@property (weak) id <CBGameSceneDelegate> gameDelegate;

@property (nonatomic) CBPlayer * player;
@property (nonatomic) CBWorld * currentWorld;
@property (nonatomic) NSMutableArray * units;
@property (nonatomic) NSMutableArray * walls;
@property (nonatomic) NSMutableArray * traps;
@property (nonatomic) CBButtonBar * buttonBar;
@property(nonatomic) CBHealthBar * healthBar;
@property(nonatomic) CBStats * stats;
@property CBTiltManager * tiltManager;
@property BOOL isDemo;


@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

+(instancetype)unarchiveFromFile:(NSString *)file withSize:(CGSize)size;

-(void)prepareForDisplay;

-(void)returnToParentMenu;



@end
