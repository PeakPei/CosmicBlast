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


//CreateWalker in same position as unit
-(CBWalker *)createWalker{
    CBWalker * walker = [CBWalker walker];
    [walker setEnemyPosition:self.position];
    
    return walker;
}

-(CBWalker *)maybeAttack {
    if (self.lastSpawnTimeInterval > 0.5) {
        self.lastSpawnTimeInterval = 0;
        
        
        CBWalker * monster = [self createWalker];
        
        
        //Set up monster physics body (may want to make a class to do this later)
        monster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:monster.size];
        monster.physicsBody.dynamic = YES;
        GameValues * gameValues = [[GameValues alloc] init];
        [gameValues playerShotSpeed];
        CGVector shotVector = [CBVectorMath vectorMult:directionToPlayer Value:[gameValues playerShotSpeed]];
        monster.physicsBody.velocity = shotVector;


        
        //Create the actions
        

        
    SKAction * actionWait = [SKAction waitForDuration:1];
        
        SKAction * actionMoveDone = [SKAction removeFromParent];
        
        [monster runAction:[SKAction sequence:@[actionWait, actionMoveDone]]];
        
        
        
        
        return monster;
    }
    return nil;
}


-(void)setUnitPosition:(CGPoint)position{
    
    self.position = position;
    
}
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
        case BehaviorType_Random:
            [self.physicsBody applyForce:CGVectorMake(10,10)];
        case BehaviorType_Aggressive:
            [self.physicsBody applyForce:directionToPlayer];
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
