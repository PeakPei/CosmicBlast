//
//  CBEnemyFactory.h
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



@interface CBEnemyFactory : CBEnemy
@property int maxHealth;
@property int health;
@property BOOL dead;
@property BehaviorType shootingBehavior;
@property BehaviorType movementBehavior;

+(id)enemyFactoryWithImageNamed:(NSString *)name;

+(id)enemyFactoryWithColor:(SKColor *)color size:(CGSize)size;

+(id)enemyFactory;

-(void)setFactoryPosition:(CGPoint)position;

-(void)updateWithPlayerPosition:(CGPoint)playerPosition;

-(void)factoryHit;

-(CBWalker *)createWalker;



@end
