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
    BehaviorType_Aggressive
} BehaviorType;



@interface CBEnemyUnit : CBEnemy
@property int maxHealth;
@property int health;
@property BOOL dead;
@property BehaviorType shootingBehavior;
@property BehaviorType movementBehavior;

+(id)enemyUnitWithImageNamed:(NSString *)name;

+(id)enemyUnitWithColor:(SKColor *)color size:(CGSize)size;

+(id)enemyUnit;

-(void)setUnitPosition:(CGPoint)position;

-(void)updateWithPlayerPosition:(CGPoint)playerPosition timeSinceLastUpdate:(CFTimeInterval)timeSinceLast;

-(void)unitHit;

-(CBWalker *)createWalker;




@end
