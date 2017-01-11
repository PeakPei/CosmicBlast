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
    CGVector directionToPlayer;
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
    NSLog(@"movementBehavior number = %d",behavior);
}

-(void)setUnitAttackBehavior:(int)behavior{
    self.attackBehavior = [self getBehaviorTypeFromInt:behavior];
}



//createProjectile in same position as unit
-(CBWalker *)createProjectile{
    
    CBWalker * walker = [CBWalker walker];
    [walker setEnemyPosition:self.position];
    
    return walker;
}

-(CBWalker *)maybeAttack {
    if (self.lastSpawnTimeInterval > 0.5) {
        self.lastSpawnTimeInterval = 0;
        CBWalker * projectile;
        GameValues * gameValues = [[GameValues alloc] init];
        projectile = [self createProjectile];
        projectile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:projectile.size];
        projectile.physicsBody.dynamic = YES;
        
        switch (_attackBehavior){
            case BehaviorType_None:
                NSLog(@"applying none attack behavior type");
                return nil;
                break;
            case BehaviorType_Random:
                NSLog(@"applying random attack behavior type");
                float x = ((float)rand() / RAND_MAX)-0.5;
                float y = ((float)rand() / RAND_MAX)-0.5;
                
                CGVector randomVector = CGVectorMake(x, y);
                //int x = rand();
                NSLog(@"randomVector = x: %f, y: %f",randomVector.dx,randomVector.dy);
                CGVector randomDirection = [CBVectorMath vectorNormalize:randomVector];
                NSLog(@"randomDirection = x: %f, y: %f",randomDirection.dx,randomDirection.dy);
                CGVector shotVector = [CBVectorMath vectorMult:randomDirection Value:[gameValues playerShotSpeed]];
                projectile.physicsBody.velocity = shotVector;
                break;
            case BehaviorType_Aggressive:
            {
                CGVector shotVector = [CBVectorMath vectorMult:directionToPlayer Value:[gameValues playerShotSpeed]];
                projectile.physicsBody.velocity = shotVector;
                break;
            }
            default:
                return nil;
                break;
        }
        
        
//        CBWalker * monster = [self createProjectile];
//        
//        
//        //Set up monster physics body (may want to make a class to do this later)
//        monster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:monster.size];
//        monster.physicsBody.dynamic = YES;
//        CGVector shotVector = [CBVectorMath vectorMult:directionToPlayer Value:[gameValues playerShotSpeed]];
//        monster.physicsBody.velocity = shotVector;


        
        //Create the actions
        

        
    SKAction * actionWait = [SKAction waitForDuration:1];
        
        SKAction * actionMoveDone = [SKAction removeFromParent];
        
        [projectile runAction:[SKAction sequence:@[actionWait, actionMoveDone]]];
        
        
        
        
        return projectile;
    }
    return nil;
}


//-(void)setUnitPosition:(CGPoint)position{
//    
//    self.position = position;
//    
//}
-(void)updateWithPlayerPosition:(CGPoint)playerPosition timeSinceLastUpdate:(CFTimeInterval)timeSinceLast{
    //update direction to player with updated player coordinates
    CGPoint rawVector = CGPointMake(playerPosition.x-self.position.x,playerPosition.y-self.position.y);
    CGPoint normalizedVector = [CBVectorMath cbVectorNormalize:rawVector];
    directionToPlayer = CGVectorMake(normalizedVector.x,normalizedVector.y);
    
    //update last spawnTimeInterval
    self.lastSpawnTimeInterval += timeSinceLast;

    


    
    
    [self applyMovement];
}

-(void)applyMovement {
    switch (_movementBehavior){
        case BehaviorType_None:
            NSLog(@"applying none movement behavior type");
            self.physicsBody.dynamic = NO;
            break;
        case BehaviorType_Random:
            NSLog(@"applying random movement behavior type");
            //[self.physicsBody applyForce:CGVectorMake(10,10)];
            break;
        case BehaviorType_Aggressive:
            NSLog(@"applying aggressive movement behavior type");
            [self.physicsBody applyForce:directionToPlayer];
            break;
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
//    float ratio = (float)self.health/(float)self.maxHealth;
//    NSLog(@"Ratio:%f", ratio);
//    float red, green;
//    red = 1-ratio;
//    green = ratio;
//    
//    
//    SKColor * newColor = [SKColor colorWithRed:red green:green blue:0.5 alpha:1];
//    SKAction *changeColorAction = [SKAction colorizeWithColor:newColor colorBlendFactor:1.0 duration:0.5];
//    [self runAction:changeColorAction];
    
    if (self.health>0){
        [self setHealth:self.health-damage];
        
    }
    else{
        
        self.dead = YES;
        
    }
    
    
}






@end
