//
//  CBPlayer.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/28/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBPlayer.h"
#import "CBLogger.h"


@implementation CBPlayer

+(id)playerWithImageNamed:(NSString *)name{
    
    CBPlayer * player = [CBPlayer spriteNodeWithImageNamed:name];
    
    player.maxHealth = 100;
    player.health = 100;
    player.dead = NO;
    
    return player;
}


//should handle player movement and map movement
-(void)movePlayerWithAccelerationXvalue:(double)x yValue:(double)y speed:(int)speed{
    
    float coefficient = 30.0;
    
    CGVector playerMotion = CGVectorMake(x*coefficient, y*coefficient);
    //CGVector worldMotion = CGVectorMake(playerMotion.dx*(-1.0), playerMotion.dy*(-1.0));

    
    
    [self.physicsBody applyForce:playerMotion];
    
    double parentOffsetX = self.parent.parent.frame.size.width/2.0;
    double parentOffsetY = self.parent.parent.frame.size.height/2.0;
    
    self.parent.position = CGPointMake((-self.position.x)+parentOffsetX, (-self.position.y)+parentOffsetY);
    
}





-(void)playerHit
{
    [self playerHitWithDamageAmount:10];
}

-(void)playerHitWithDamageAmount:(int)damage
{
    if (self.health>0){
        [self setHealth:self.health-damage];
    }
    else{
        self.dead = YES;
    }
}




@end
