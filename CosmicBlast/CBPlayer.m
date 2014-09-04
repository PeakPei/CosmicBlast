//
//  CBPlayer.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/28/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBPlayer.h"

@implementation CBPlayer

+(id)playerWithImageNamed:(NSString *)name{
    
    CBPlayer * player = [CBPlayer spriteNodeWithImageNamed:name];
    
    return player;
    
}



-(void)movePlayerWithAccelerationXvalue:(double)x yValue:(double)y speed:(int)speed{
    
    
    
    if (x < -.2){
        CGPoint oldPoint = CGPointMake(self.position.x, self.position.y);
        self.position = CGPointMake(oldPoint.x - speed, oldPoint.y);
    }
    if (x > .2){
        
        CGPoint oldPoint = CGPointMake(self.position.x, self.position.y);
        self.position = CGPointMake(oldPoint.x + speed, oldPoint.y);
        
    }
    if (y > -.2){
        
        CGPoint oldPoint = CGPointMake(self.position.x, self.position.y);
        self.position = CGPointMake(oldPoint.x, oldPoint.y + speed);
        
    }
    if (y < -.5){
        CGPoint oldPoint = CGPointMake(self.position.x, self.position.y);
        self.position = CGPointMake(oldPoint.x, oldPoint.y - speed);
    }
    
    
}

@end
