//
//  CBPlayer.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/28/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBPlayer.h"
#import "CBLogger.h"
#import "CBVectorMath.h"
#import <CosmicBlast-Swift.h>



@implementation CBPlayer

+(id)playerWithImageNamed:(NSString *)name{
    
    CBPlayer * player = [CBPlayer spriteNodeWithImageNamed:name];
    [CBPlayer setPlayerGameValues:player];
    return player;
}


//This does not use the color and size
+(id)playerWithColor:(UIColor *)color size:(CGSize)size{
    CBPlayer * player = [CBPlayer spriteNodeWithColor:color size:size];
    [CBPlayer setPlayerGameValues:player];
    return player;
}

+(void)setPlayerGameValues:(CBPlayer *)player{
    GameValues * gameValues = [[GameValues alloc] init];
    player.maxHealth = (int)[gameValues playerMaxHealth];
    player.health = player.maxHealth;
    player.dead = NO;
}






//should handle player movement and map movement
-(void)movePlayerWithAccelerationXvalue:(double)x yValue:(double)y speed:(int)speed{
    
    
    GameValues * gameValues = [[GameValues alloc] init];
    
    float coefficient = [gameValues playerAccelerationCoefficient];

    CGVector playerMotion = CGVectorMake(x*coefficient, y*coefficient);
    //CGVector worldMotion = CGVectorMake(playerMotion.dx*(-1.0), playerMotion.dy*(-1.0));

    
    
    [self.physicsBody applyForce:playerMotion];
    
    double parentOffsetX = self.parent.parent.frame.size.width/2.0;
    double parentOffsetY = self.parent.parent.frame.size.height/2.0;
//    NSLog(@"playerPosition x: %f, y: %f", self.position.x, self.position.y);
//    NSLog(@"parentPosition x: %f, y: %f", self.parent.position.x, self.parent.position.y);
//    self.position = CGPointMake((self.position.x)-parentOffsetX, (self.position.y)-parentOffsetY);
    
    CGPoint newParentPosition = CGPointMake((-self.position.x)+parentOffsetX, (-self.position.y)+parentOffsetY);
    CGPoint directionVector = [CBVectorMath cbVectorSubFirst:newParentPosition Second:self.parent.position];
    directionVector = [CBVectorMath cbVectorNormalize:directionVector];
    float newDirection = atan2(-directionVector.x, directionVector.y);
    NSLog(@"new direction = %f", newDirection);
    self.zRotation = newDirection;
    self.parent.position = newParentPosition;
    
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
