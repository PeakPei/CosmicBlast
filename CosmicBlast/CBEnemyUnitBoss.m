//
//  CBEnemyUnitBoss.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 5/14/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

#import "CBEnemyUnitBoss.h"
#import <CosmicBlast-Swift.h>



@implementation CBEnemyUnitBoss


+ (instancetype)enemyUnitBoss{
    CBEnemyUnitBoss * boss = [CBEnemyUnitBoss spriteNodeWithImageNamed:@"EnemyBoss"];
    GameValues * gameValues = [[GameValues alloc] init];
    
    boss.maxHealth = (int)[gameValues unitMaxHealth];
    boss.health = boss.maxHealth;
    boss.dead = NO;
    return boss;
}

-(void)updateWithPlayerPosition:(CGPoint)playerPosition timeSinceLastUpdate:(CFTimeInterval)timeSinceLast{
    //IMPLEMENT
}

-(void)unitHit{
    //IMPLEMENT
}

-(CBWalker *)createProjectile{
    //IMPLEMENT
    return nil;
}

-(CBWalker *)maybeAttack{
    //IMPLEMENT
    return nil;
}



@end
