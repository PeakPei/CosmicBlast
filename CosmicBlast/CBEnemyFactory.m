//
//  CBEnemyFactory.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 9/4/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBEnemyFactory.h"
#import <CosmicBlast-Swift.h>

@implementation CBEnemyFactory




//CreateEnemyFactory
+(id)enemyFactoryWithImageNamed:(NSString *)name{
    CBEnemyFactory * enemyFactory = [CBEnemyFactory spriteNodeWithImageNamed:name];
    return enemyFactory;
}


+(id)enemyFactoryWithColor:(SKColor *)color size:(CGSize)size{
    
    GameValues * gameValues = [[GameValues alloc] init];
    CBEnemyFactory * enemyFactory = [CBEnemyFactory spriteNodeWithColor:color size:size];
    enemyFactory.maxHealth = [gameValues factoryMaxHealth];
    enemyFactory.health = enemyFactory.maxHealth;
    enemyFactory.dead = NO;
    return enemyFactory;
    
}


+(id)enemyFactory{
    GameValues * gameValues = [[GameValues alloc] init];
    CBEnemyFactory * enemyFactory = [CBEnemyFactory spriteNodeWithColor:[gameValues factoryColor] size:[gameValues factorySize]];
    enemyFactory.maxHealth = [gameValues factoryMaxHealth];
    enemyFactory.health = enemyFactory.maxHealth;
    enemyFactory.dead = NO;
    return enemyFactory;

}

//CreateWalker in same position as factory
-(CBWalker *)createWalker{
    CBWalker * walker = [CBWalker walker];
    [walker setEnemyPosition:self.position];
    
    return walker;
}


-(void)setFactoryPosition:(CGPoint)position{
    
    self.position = position;
    
}


-(void)factoryHit
{
    [self factoryHitWithDamageAmount:10];
}

-(void)factoryHitWithDamageAmount:(int)damage
{
    if (self.health>0){
        [self setHealth:self.health-damage];
    }
    else{
        self.dead = YES;
    }
}






@end
