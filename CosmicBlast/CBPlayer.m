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
    
    return player;
}


//should handle player movement and map movement
-(void)movePlayerWithAccelerationXvalue:(double)x yValue:(double)y speed:(int)speed{
    
    
    
    CGVector playerMotion = CGVectorMake(x*5.0, y*5.0);
    //CGVector worldMotion = CGVectorMake(playerMotion.dx*(-1.0), playerMotion.dy*(-1.0));

    
    
    [self.physicsBody applyForce:playerMotion];
    
    double parentOffsetX = self.parent.parent.frame.size.width/2.0;
    double parentOffsetY = self.parent.parent.frame.size.height/2.0;
    
    self.parent.position = CGPointMake((-self.position.x)+parentOffsetX, (-self.position.y)+parentOffsetY);
    
    
    
    //self.parent.position = self.position;
    //[self.parent.physicsBody applyForce:deviceMotion];
    
    //NSLog(@"self pos: {x:%F}{y:%F} \n parent pos: {x:%F}{y:%F}",self.position.x,self.position.y,self.parent.position.x,self.parent.position.y);

    
    
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
