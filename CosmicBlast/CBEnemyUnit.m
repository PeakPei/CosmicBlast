//
//  CBEnemyUnit.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 9/4/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBEnemyUnit.h"
#import "CBVectorMath.h"
#import <CosmicBlast-Swift.h>



@implementation CBEnemyUnit{
//    CGVector directionToPlayer;
    CGPoint playerPosition;
}




//CreateEnemyUnit
+(id)enemyUnitWithImageNamed:(NSString *)name{
    CBEnemyUnit * enemyUnit = [CBEnemyUnit spriteNodeWithImageNamed:name];
    return enemyUnit;
}

+(id)enemyUnitWithColor:(SKColor *)color size:(CGSize)size{
    
    GameValues * gameValues = [[GameValues alloc] init];
    CBEnemyUnit * enemyUnit = [CBEnemyUnit spriteNodeWithColor:color size:size];
    enemyUnit.maxHealth = (int)[gameValues unitMaxHealth];
    enemyUnit.health = enemyUnit.maxHealth;
    enemyUnit.dead = NO;
    return enemyUnit;
    
}

+(id)enemyUnit{
    GameValues * gameValues = [[GameValues alloc] init];
    CBEnemyUnit * enemyUnit = [CBEnemyUnit enemyUnitWithImageNamed:@"EnemyUnit"];
    enemyUnit.maxHealth = (int)[gameValues unitMaxHealth];
    enemyUnit.health = enemyUnit.maxHealth;
    enemyUnit.dead = NO;
    enemyUnit.movementBehavior = BehaviorType_Aggressive;
    return enemyUnit;
}




-(CGPoint)getPlayerPosition{
    return self->playerPosition;
}


-(CGVector)getDirectionToPlayer{
    CGPoint rawVector = CGPointMake(playerPosition.x-self.position.x,playerPosition.y-self.position.y);
    CGPoint normalizedVector = [CBVectorMath cbVectorNormalize:rawVector];
    CGVector directionToPlayer = CGVectorMake(normalizedVector.x,normalizedVector.y);
    return directionToPlayer;
}




-(BehaviorType)getBehaviorTypeFromInt:(int)behaviorInt {
    switch (behaviorInt) {
        case 0:
            return BehaviorType_None;
        case 1:
            return BehaviorType_Random;
        case 2:
            return BehaviorType_Aggressive;
        default:
            return BehaviorType_None;
    }
}


-(void)setUnitMovementBehavior:(int)behavior{
    self.movementBehavior = [self getBehaviorTypeFromInt:behavior];
}

-(void)setUnitAttackBehavior:(int)behavior{
    self.attackBehavior = [self getBehaviorTypeFromInt:behavior];
}



//createProjectile in same position as unit
-(CBEnemy *)createProjectile{
    
    CBWalker * walker = [CBWalker walker];
    [walker setEnemyPosition:self.position];
    
    return walker;
}

-(CBEnemy *)maybeAttack {
    if (self.lastSpawnTimeInterval > 0.5) {
        self.lastSpawnTimeInterval = 0;
        CBEnemy * projectile;
        GameValues * gameValues = [[GameValues alloc] init];
        projectile = [self createProjectile];
        projectile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:projectile.size];
        projectile.physicsBody.dynamic = YES;
        
        switch (_attackBehavior){
            case BehaviorType_None:
                return nil;
                break;
            case BehaviorType_Random:
                //need to have this statement here or it won't compile.  WTF.
                NSLog(@"");
                float x = ((float)rand() / RAND_MAX)-0.5;
                float y = ((float)rand() / RAND_MAX)-0.5;
                
                CGVector randomVector = CGVectorMake(x, y);
                CGVector randomDirection = [CBVectorMath vectorNormalize:randomVector];
                CGVector shotVector = [CBVectorMath vectorMult:randomDirection Value:[gameValues unitShotSpeed]];
                projectile.physicsBody.velocity = shotVector;
                break;
            case BehaviorType_Aggressive:
            {
                CGVector shotVector = [CBVectorMath vectorMult:[self getDirectionToPlayer] Value:[gameValues unitShotSpeed]];
                projectile.physicsBody.velocity = shotVector;
                break;
            }
            default:
                return nil;
                break;
        }
        

        
        SKAction * actionWait = [SKAction waitForDuration:1];
        SKAction * actionMoveDone = [SKAction removeFromParent];
        [projectile runAction:[SKAction sequence:@[actionWait, actionMoveDone]]];

        return projectile;
    }
    return nil;
}


-(void)updateWithPlayerPosition:(CGPoint)position timeSinceLastUpdate:(CFTimeInterval)timeSinceLast{
    //update direction to player with updated player coordinates
    self->playerPosition = position;
    //update last spawnTimeInterval
    self.lastSpawnTimeInterval += timeSinceLast;
    
    
    [self applyMovement];
}




-(void)applyMovement {
    
    //GameValues * gameValues = [[GameValues alloc] init];
    switch (_movementBehavior){
        case BehaviorType_None:
            self.physicsBody.dynamic = NO;
            break;
        case BehaviorType_Random:
            //[self.physicsBody applyForce:CGVectorMake(10,10)];
            
            break;
        case BehaviorType_Aggressive:{
            CGVector movementVector = [CBVectorMath vectorMult:[self getDirectionToPlayer] Value:10];
            [self.physicsBody applyForce:movementVector];
            break;
        }
        default:
            break;
    }
}




-(void)unitHit
{
    [self unitHitWithDamageAmount:10];
}

-(void)unitHitWithDamageAmount:(int)damage
{
    
    if (self.health>0){
        [self setHealth:self.health-damage];
        SKAction * fade = [SKAction fadeAlphaTo:0.2 duration: 0.05];
        SKAction * unfade = [SKAction fadeAlphaTo:1 duration: 0.05];
        SKAction *sequence = [SKAction sequence:@[fade, unfade, fade, unfade, fade, unfade]];
        [self runAction:sequence];
    }
    else{
        self.dead = YES;
        [self explode];
    }
}


@end
