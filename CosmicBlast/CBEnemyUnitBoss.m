//
//  CBEnemyUnitBoss.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 5/14/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

#import "CBVectorMath.h"
#import "CBEnemyUnitBoss.h"
#import <CosmicBlast-Swift.h>



@implementation CBEnemyUnitBoss


+ (instancetype)enemyUnitBoss{
    CBEnemyUnitBoss * boss = [CBEnemyUnitBoss spriteNodeWithImageNamed:@"EnemyBoss"];
    GameValues * gameValues = [[GameValues alloc] init];
    
    boss.maxHealth = (int)[gameValues unitMaxHealth]*10;
    boss.health = boss.maxHealth;
    boss.dead = NO;
    return boss;
}


-(void)unitHit
//here we can implement behavior for when the boss is attacked.
{
    [super unitHit];
    if (arc4random_uniform(100) > 80){
        SKAction * actionMove = [SKAction moveTo:[self getPlayerPosition] duration:0.6];
        [self runAction:actionMove];
    }
}


-(CBEnemy *)maybeAttack {
    if (self.lastSpawnTimeInterval > 1) {
        self.lastSpawnTimeInterval = 0;
        CBEnemy * projectile;
        GameValues * gameValues = [[GameValues alloc] init];
        projectile = [self createProjectile];
        projectile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:projectile.size];
        projectile.physicsBody.dynamic = YES;
        
        float x = ((float)rand() / RAND_MAX)-0.5;
        float y = ((float)rand() / RAND_MAX)-0.5;
                
        CGVector randomVector = CGVectorMake(x, y);
        CGVector randomDirection = [CBVectorMath vectorNormalize:randomVector];
        CGVector shotVector = [CBVectorMath vectorMult:randomDirection Value:[gameValues unitShotSpeed]];
        projectile.physicsBody.velocity = shotVector;
        SKAction * actionWait = [SKAction waitForDuration:25];
        SKAction * actionMoveDone = [SKAction removeFromParent];
        [projectile runAction:[SKAction sequence:@[actionWait, actionMoveDone]]];
        
        return projectile;
    }
    return nil;
}


-(void)applyMovement {
    self.physicsBody.velocity = CGVectorMake(0, 0);
}



@end
