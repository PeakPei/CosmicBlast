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
    
    SKAction * actionMove = [SKAction moveTo:[self getPlayerPosition] duration:0.6];
    
//    SKAction * actionWait = [SKAction waitForDuration:1];
//
//    
//    SKAction * actionMoveDone = [SKAction removeFromParent];
//    
//    
//    
//    [self runAction:[SKAction sequence:@[actionMove]]];
    [self runAction:actionMove];
    
}



-(void)applyMovement {
    self.physicsBody.velocity = CGVectorMake(0, 0);
}



@end
