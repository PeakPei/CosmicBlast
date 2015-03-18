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


//should handle player movement and map movement
-(void)movePlayerWithAccelerationXvalue:(double)x yValue:(double)y speed:(int)speed{
    
    
    
    CGVector deviceMotion = CGVectorMake(x*5.0, y*5.0);
    [self.physicsBody applyForce:deviceMotion];
    
    
    [self.parent.physicsBody applyForce:deviceMotion];
    
    
    
    
    
//    if (x < -.2){
//        CGPoint oldPoint = CGPointMake(self.position.x, self.position.y);
//        self.position = CGPointMake(oldPoint.x - speed, oldPoint.y);
//        
//        CGPoint oldParentPoint = CGPointMake(self.parent.position.x,self.parent.position.y);
//        self.parent.position = CGPointMake(oldParentPoint.x + speed, oldParentPoint.y);
//    }
//    if (x > .2){
//        
//        CGPoint oldPoint = CGPointMake(self.position.x, self.position.y);
//        self.position = CGPointMake(oldPoint.x + speed, oldPoint.y);
//        
//        CGPoint oldParentPoint = CGPointMake(self.parent.position.x,self.parent.position.y);
//        self.parent.position = CGPointMake(oldParentPoint.x - speed, oldParentPoint.y);
//        
//    }
//    if (y > .2){
//        
//        CGPoint oldPoint = CGPointMake(self.position.x, self.position.y);
//        self.position = CGPointMake(oldPoint.x, oldPoint.y + speed);
//        
//        CGPoint oldParentPoint = CGPointMake(self.parent.position.x,self.parent.position.y);
//        self.parent.position = CGPointMake(oldParentPoint.x, oldParentPoint.y - speed);
//        
//    }
//    if (y < -.5){
//        CGPoint oldPoint = CGPointMake(self.position.x, self.position.y);
//        self.position = CGPointMake(oldPoint.x, oldPoint.y - speed);
//        
//        CGPoint oldParentPoint = CGPointMake(self.parent.position.x,self.parent.position.y);
//        self.parent.position = CGPointMake(oldParentPoint.x, oldParentPoint.y + speed);
//    }
    
   //NSLog(@"CBPlayer ----> self.position: %f self.parent.position %f", self.position, self.parent.position);
}

@end
