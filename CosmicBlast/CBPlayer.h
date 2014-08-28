//
//  CBPlayer.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/28/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CBPlayer : SKSpriteNode

+(id)playerWithImageNamed:(NSString *)name;

-(void)movePlayerWithAccelerationXvalue:(double)x yValue:(double)y speed:(int)speed;

@end
