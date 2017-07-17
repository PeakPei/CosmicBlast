//
//  CBPlayer.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/28/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "CBPlayer.h"
#import "CBVectorMath.h"
#import <CosmicBlast-Swift.h>



@implementation CBPlayer{
    NSMutableArray * pastXData;
    NSMutableArray * pastYData;
    int accelerometerDataMemoryLength;
    BOOL breaking;
    CFTimeInterval lastShotTime;
    CFTimeInterval deadTime;
    CFTimeInterval healthGoneTime;
}





+(instancetype)playerWithImageNamed:(NSString *)name{
    
    CBPlayer * player = [CBPlayer spriteNodeWithImageNamed:name];
    [CBPlayer setPlayerGameValues:player];
    player -> pastXData = [[NSMutableArray alloc] init];
    player -> pastYData = [[NSMutableArray alloc] init];
    player -> accelerometerDataMemoryLength = (int)[[[GameValues alloc] init] accelerometerDataMemoryLength];

    player -> lastShotTime = 0;
    player -> deadTime = 0;
    // perform some action
    return player;
}



+(instancetype)playerWithColor:(UIColor *)color size:(CGSize)size{
    CBPlayer * player = [CBPlayer spriteNodeWithColor:color size:size];
    [CBPlayer setPlayerGameValues:player];
    return player;
}



+(instancetype)player {
    return [CBPlayer playerWithImageNamed:@"Player"];
}




+(void)setPlayerGameValues:(CBPlayer *)player{
    GameValues * gameValues = [[GameValues alloc] init];
    player.maxHealth = (int)[gameValues playerMaxHealth];
    player.health = player.maxHealth;
    player.dead = NO;
    player.maxSpeed = gameValues.playerMaxSpeed;

    
}


-(CGVector)dampenMovementVectorWith:(double)x :(double)y{
    
    //X data first
    NSNumber * lineXData = [NSNumber numberWithFloat:roundf(x*200.0)/200.0];
    [self->pastXData addObject:lineXData];
    if([pastXData count] > self->accelerometerDataMemoryLength) {
        [pastXData removeObjectAtIndex:0];
    }
    float xTotal = 0.0;
    for (NSNumber * x in pastXData) {
        xTotal += [x floatValue];
    }
    float moveX = xTotal/[pastXData count];
    
    
    //Then Y Data
    NSNumber * lineYData = [NSNumber numberWithFloat:roundf(y*200.0)/200.0];
    [self->pastYData addObject:lineYData];
    if([pastYData count] > self->accelerometerDataMemoryLength) {
        [pastYData removeObjectAtIndex:0];
    }
    float yTotal = 0.0;
    for (NSNumber * y in pastYData) {
        yTotal += [y floatValue];
    }
    float moveY = yTotal/[pastYData count];
    
    return CGVectorMake(moveX, moveY);
}



//should handle player movement and map movement
-(void)movePlayerWithAccelerationXvalue:(double)x yValue:(double)y speed:(int)speed{

    CGVector move = [self dampenMovementVectorWith:x :y];
    float moveX = move.dx;
    float moveY = move.dy;
    
    GameValues * gameValues = [[GameValues alloc] init];
    float coefficient = [gameValues playerAccelerationCoefficient];
    CGVector playerMotion;
    if (breaking) {
        playerMotion = [CBVectorMath vectorSubFirst:CGVectorMake(0, 0) second:self.physicsBody.velocity];
    } else{
        playerMotion = CGVectorMake(moveX*coefficient, moveY*coefficient);
    }
    [self.physicsBody applyForce:playerMotion];

    CGPoint velocityPoint = CGPointMake(self.physicsBody.velocity.dx, self.physicsBody.velocity.dy);
    CGFloat playerSpeed = [CBVectorMath cbVectorLength:velocityPoint];
    CGPoint direction = [CBVectorMath cbVectorNormalize:velocityPoint];
    if (playerSpeed > self.maxSpeed) {
        
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
    
    
    if ([self playerDeadYet]){
        
        
        self.dead = YES;
    }
    
}

-(BOOL)weaponRecharged{
    CFTimeInterval shotWaitTime = [[[GameValues alloc] init] playerShotRechargeTime];
    CFTimeInterval elapsedTime = CACurrentMediaTime() - lastShotTime;
    if(elapsedTime > shotWaitTime){
        self->lastShotTime = CACurrentMediaTime();
        return true;
    } else {
        return false;
    }
}


-(void)startBreaking{
    breaking = true;
}

-(void)endBreaking{
    breaking = false;
}


-(void)playerHit{
    SKAction * fade = [SKAction fadeAlphaTo:0.2 duration: 0.05];
    SKAction * unfade = [SKAction fadeAlphaTo:1 duration: 0.05];
    SKAction *sequence = [SKAction sequence:@[fade, unfade, fade, unfade, fade, unfade]];
    
    [self runAction:sequence];
    
    // Easy = 5
    // Normal = 20
    // Hard = 40
    int currentDifficulty = (int)[[NSUserDefaults standardUserDefaults] integerForKey: @"difficulty"];
    if (currentDifficulty == 2) {
        [self playerHitWithDamageAmount:20];
    } else if (currentDifficulty == 3) {
        [self playerHitWithDamageAmount:40];
    } else {
        [self playerHitWithDamageAmount:5];
    }
}


-(BOOL)playerDeadYet{
    if (self.dying){
        self.alpha = 0.2;
        CFTimeInterval deathWaitTime = 1;
        CFTimeInterval elapsedTime = CACurrentMediaTime() - healthGoneTime;
        if(elapsedTime > deathWaitTime){
            return true;
        }
    }
    return false;
}



-(void)explode{
    SKEmitterNode * emitter = [[SKEmitterNode alloc] init];
    [emitter setParticleSize:CGSizeMake(4,4)];
    [emitter setParticleBirthRate: 100];
    [emitter setParticleSpeed:200];
    [emitter setParticleColor:[UIColor magentaColor]];
    [emitter setParticleLifetime:1];
    emitter.numParticlesToEmit = 30;
    emitter.position = self.position;
    [emitter setEmissionAngleRange:(2*M_PI)];
    [self.parent addChild:emitter];
}



-(void)playerHitWithDamageAmount:(int)damage
{
    if (self.health>0){
        [self setHealth:self.health-damage];
    }
    else{
        if (!self.dying){
            healthGoneTime = CACurrentMediaTime();
            [self explode];
            self.dying = YES;
            
        }

    }
}




@end
