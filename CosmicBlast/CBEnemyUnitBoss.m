//
//  CBEnemyUnitBoss.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 5/14/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

#import "CBEnemyUnitBoss.h"

@implementation CBEnemyUnitBoss


+(instancetype)enemyUnitBoss{
    return [CBEnemyUnit enemyUnit];
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
