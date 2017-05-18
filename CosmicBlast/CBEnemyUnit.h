//
//  CBEnemyUnit.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 9/4/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CBWalker.h"

typedef enum {
    BehaviorType_Random,
    BehaviorType_Aggressive,
    BehaviorType_None
} BehaviorType;



@interface CBEnemyUnit : CBEnemy
@property int maxHealth;
@property int health;
@property BOOL dead;
@property BehaviorType attackBehavior;
@property BehaviorType movementBehavior;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;



+(id)enemyUnit;

//-(void)setUnitPosition:(CGPoint)position;



-(void)setUnitMovementBehavior:(int)behavior;

-(void)setUnitAttackBehavior:(int)behavior;


-(void)applyMovement;

-(void)updateWithPlayerPosition:(CGPoint)position timeSinceLastUpdate:(CFTimeInterval)timeSinceLast;

-(void)unitHit;

-(CGVector)getDirectionToPlayer;


-(CGPoint)getPlayerPosition;

-(CBEnemy *)createProjectile;

-(CBWalker *)maybeAttack;




@end
