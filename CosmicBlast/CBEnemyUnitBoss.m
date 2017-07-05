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


#define DEGREES_TO_RADIANS(degrees)((M_PI * degrees)/180)

@implementation CBEnemyUnitBoss {
    BOOL isShooting;
    double shotTimer;
}


+ (instancetype)enemyUnitBoss{
    CBEnemyUnitBoss * boss = [CBEnemyUnitBoss spriteNodeWithImageNamed:@"EnemyBoss"];
    GameValues * gameValues = [[GameValues alloc] init];
    boss->isShooting = false;
    boss.lastSpawnTimeInterval = arc4random_uniform(40) / -10.0 ;
    boss.maxHealth = (int)[gameValues unitMaxHealth]*10;
    boss.health = boss.maxHealth;
    boss.dead = NO;
    return boss;
}


-(void)unitHit
//here we can implement behavior for when the boss is attacked.
{
    
    [super unitHit];
    
    int roll = arc4random_uniform(360);
    double angle = DEGREES_TO_RADIANS(roll);
    double newX = (self.scene.size.width/2) * cos(angle);
    double newY = (self.scene.size.height/2) * sin(angle);
    CGPoint newPos = CGPointMake(newX, newY);
    
    [self runAction:[SKAction moveTo:newPos duration:0.5]];

}




-(CBEnemy *)maybeAttack {
    int roll = arc4random_uniform(100) ;
    if(isShooting){
        if  (self.lastSpawnTimeInterval < 2) {
            if (self.lastShotTimeInterval > 0.3) {
                self.lastShotTimeInterval = 0.0;
                return [self getAimedShot];
            }
            
            //self.lastSpawnTimeInterval = 0;
        } else {
            isShooting = false;
        }
    }
    if (self.lastSpawnTimeInterval > 2) {
        self.lastSpawnTimeInterval = 0;
        if (roll < 33){
            return [self getAimedShot];
        } else if (roll < 66){
            [self chargePlayer];
            return nil;
        } else {
            isShooting = true;
        }
        
    }
    return nil;
}




//-(CBEnemy *)getAimedShot{
//    
//    CBEnemy * projectile;
//    GameValues * gameValues = [[GameValues alloc] init];
//    projectile = [self createProjectile];
//    CGVector shotVector = [CBVectorMath vectorMult:[self getDirectionToPlayer] Value:[gameValues unitShotSpeed]];
//    projectile.physicsBody.dynamic = YES;
//    projectile.physicsBody.velocity = shotVector;
//    return projectile;
//}


//-(CBEnemy *)randomShot{
//    CBEnemy * projectile;
//    GameValues * gameValues = [[GameValues alloc] init];
//    projectile = [self createProjectile];
//    projectile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:projectile.size];
//    projectile.physicsBody.dynamic = YES;
//    
//    float x = ((float)rand() / RAND_MAX)-0.5;
//    float y = ((float)rand() / RAND_MAX)-0.5;
//    
//    CGVector randomVector = CGVectorMake(x, y);
//    CGVector randomDirection = [CBVectorMath vectorNormalize:randomVector];
//    CGVector shotVector = [CBVectorMath vectorMult:randomDirection Value:[gameValues unitShotSpeed]];
//    projectile.physicsBody.velocity = shotVector;
//    SKAction * actionWait = [SKAction waitForDuration:25];
//    SKAction * actionMoveDone = [SKAction removeFromParent];
//    [projectile runAction:[SKAction sequence:@[actionWait, actionMoveDone]]];
//    
//    return projectile;
//}



-(void)chargePlayer{
    
    SKAction * fade = [SKAction fadeAlphaTo:0.0 duration: 0.1];
    SKAction * unfade = [SKAction fadeAlphaTo:1.0 duration: 0.1];
    SKAction * actionMove = [SKAction moveTo:[self getPlayerPosition] duration:0.5];
    SKAction *sequence = [SKAction sequence:@[fade, unfade, actionMove]];
    [self runAction:sequence];
    self.lastSpawnTimeInterval = -4.0;
}





-(void)applyMovement {
    self.physicsBody.velocity = CGVectorMake(0, 0);
}



@end
