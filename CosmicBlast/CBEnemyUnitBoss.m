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

-(void)updateWithPlayerPosition:(CGPoint)playerPosition timeSinceLastUpdate:(CFTimeInterval)timeSinceLast{
//    //update direction to player with updated player coordinates
//    CGPoint rawVector = CGPointMake(playerPosition.x-self.position.x,playerPosition.y-self.position.y);
//    CGPoint normalizedVector = [CBVectorMath cbVectorNormalize:rawVector];
//    CGVector directionToPlayer = CGVectorMake(normalizedVector.x,normalizedVector.y);
//    [self setDirectionToPlayer:directionToPlayer];
//    //update last spawnTimeInterval
//    self.lastSpawnTimeInterval += timeSinceLast;
    
    

    
    //[self applyMovement];
}
-(void)unitHit
//here we can implement behavior for when the boss is attacked.
{
    [super unitHit];
    
    
//    SKAction * actionWait = [SKAction waitForDuration:1];
//
//    
//    SKAction * actionMoveDone = [SKAction removeFromParent];
//    
//    
//    
//    [self runAction:[SKAction sequence:@[actionWait, actionMoveDone]]];
    
}







@end
