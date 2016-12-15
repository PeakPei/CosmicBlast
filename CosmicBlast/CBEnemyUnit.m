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


@implementation CBEnemyUnit




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



//+(id)enemyUnit{
//    GameValues * gameValues = [[GameValues alloc] init];
//    CBEnemyUnit * enemyUnit = [CBEnemyUnit spriteNodeWithColor:[gameValues unitColor] size:[gameValues unitSize]];
//    enemyUnit.maxHealth = (int)[gameValues unitMaxHealth];
//    enemyUnit.health = enemyUnit.maxHealth;
//    enemyUnit.dead = NO;
//    return enemyUnit;
//}



//CreateWalker in same position as unit
-(CBWalker *)createWalker{
    CBWalker * walker = [CBWalker walker];
    [walker setEnemyPosition:self.position];
    
    return walker;
}


-(void)setUnitPosition:(CGPoint)position{
    
    self.position = position;
    
}
-(void)updateWithPlayerPosition:(CGPoint)playerPosition{
    CGPoint rawVector = CGPointMake(playerPosition.x-self.position.x,playerPosition.y-self.position.y);
    CGPoint normalizedVector = [CBVectorMath cbVectorNormalize:rawVector];
    switch (_movementBehavior){
        case BehaviorType_Random:
            [self.physicsBody applyForce:CGVectorMake(10,10)];
        case BehaviorType_Aggressive:
            [self.physicsBody applyForce:CGVectorMake(normalizedVector.x,normalizedVector.y)];
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
