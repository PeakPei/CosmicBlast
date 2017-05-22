//
//  CBEnemy.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/23/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBEnemy.h"

@implementation CBEnemy


+(id)enemyWithImageNamed:(NSString *)name{

    CBEnemy * enemy = [CBEnemy spriteNodeWithImageNamed:name];

    return enemy;
}



-(void)setEnemyPosition:(CGPoint)position{
    
    self.position = position;
    
}



-(void)explode{
    
    
        SKEmitterNode * emitter = [[SKEmitterNode alloc] init];
        [emitter setParticleSize:CGSizeMake(3,3)];
        [emitter setParticleBirthRate: 100];
        [emitter setParticleSpeed:80];
        [emitter setParticleColor:[UIColor redColor]];
        [emitter setParticleLifetime:0.6];
        emitter.numParticlesToEmit = 30;
        emitter.position = self.position;
        [emitter setEmissionAngleRange:(2*M_PI)];
        //[emitter setEmissionAngle:player.zRotation];
        [self.parent addChild:emitter];
    
    
//    SKEmitterNode * emitter = [[SKEmitterNode alloc] init];
//    //emitter.numParticlesToEmit = 100;
//    emitter.particleBirthRate = 20;
//    //emitter.position = self.position;
//    emitter.particleColor = [UIColor blackColor];
//    [self addChild:emitter];
//    
    
    
    
    
    
    
    
}






@end
