//
//  CBEnemyFactory.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 9/4/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBEnemyFactory.h"

@implementation CBEnemyFactory

//CreateEnemyFactory
+(id)enemyFactoryWithImageNamed:(NSString *)name{
    CBEnemyFactory * enemyFactory = [CBEnemyFactory spriteNodeWithImageNamed:name];
    return enemyFactory;
}

+(id)enemyFactoryWithColor:(SKColor *)color size:(CGSize)size{
    
    CBEnemyFactory * enemyFactory = [CBEnemyFactory spriteNodeWithColor:color size:size];
    enemyFactory.maxHealth = 30;
    enemyFactory.health = 30;
    enemyFactory.dead = NO;
    return enemyFactory;
    
}




//CreateWalker in same position as factory
-(CBWalker *)createWalker{
    CBWalker * walker = [CBWalker walkerWithImageNamed:@"monster"];
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
