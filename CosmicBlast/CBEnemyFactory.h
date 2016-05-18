//
//  CBEnemyFactory.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 9/4/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CBWalker.h"


@interface CBEnemyFactory : SKSpriteNode
@property int maxHealth;
@property int health;
@property BOOL dead;


+(id)enemyFactoryWithImageNamed:(NSString *)name;

+(id)enemyFactoryWithColor:(SKColor *)color size:(CGSize)size;

-(void)setFactoryPosition:(CGPoint)position;

-(void)factoryHit;

-(CBWalker *)createWalker;



@end
