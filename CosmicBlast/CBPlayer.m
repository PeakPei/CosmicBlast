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
    player.maxSpeed = gameValues.playerMaxSpeed;
    
//    SKEmitterNode * emitter = [[SKEmitterNode alloc] init];
//    [emitter setParticleSize:CGSizeMake(1,1)];
//    [emitter setParticleBirthRate: 50];
//    [emitter setParticleSpeed:100];
//    [emitter setParticleColor:[UIColor greenColor]];
//    [emitter setParticleLifetime:100];
//    [emitter setEmissionAngleRange:(2*M_PI)];
//    //[emitter setEmissionAngle:];
//    [player addChild:emitter];
    
}






//should handle player movement and map movement
-(void)movePlayerWithAccelerationXvalue:(double)x yValue:(double)y speed:(int)speed{
    
    
    GameValues * gameValues = [[GameValues alloc] init];
    
    float coefficient = [gameValues playerAccelerationCoefficient];

    CGVector playerMotion = CGVectorMake(x*coefficient, y*coefficient);
    //CGVector worldMotion = CGVectorMake(playerMotion.dx*(-1.0), playerMotion.dy*(-1.0));

    
    [self.physicsBody applyForce:playerMotion];
    
    
    
    CGPoint velocityPoint = CGPointMake(self.physicsBody.velocity.dx, self.physicsBody.velocity.dy);
    CGFloat playerSpeed = [CBVectorMath cbVectorLength:velocityPoint];
 //   NSLog(@"playerSpeed: %f", playerSpeed);
    if (playerSpeed > self.maxSpeed) {
        CGPoint direction = [CBVectorMath cbVectorNormalize:velocityPoint];
        CGPoint newVelocityPoint = [CBVectorMath cbVectorMultFirst:direction Value:self.maxSpeed];
        CGVector newVelocity = CGVectorMake(newVelocityPoint.x, newVelocityPoint.y);
        self.physicsBody.velocity = newVelocity;
    }
    
    
    double parentOffsetX = self.parent.parent.frame.size.width/2.0;
    double parentOffsetY = self.parent.parent.frame.size.height/2.0;
    CGPoint newParentPosition = CGPointMake((-self.position.x)+parentOffsetX, (-self.position.y)+parentOffsetY);
    CGPoint directionVector = [CBVectorMath cbVectorSubFirst:newParentPosition Second:self.parent.position];
    directionVector = [CBVectorMath cbVectorNormalize:directionVector];
    float newDirection = atan2(-directionVector.x, directionVector.y);
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
