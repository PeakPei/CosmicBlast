//
//  CBPlayer.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/28/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CBPlayer : SKSpriteNode
@property int maxHealth;
@property int health;
@property BOOL dead;

//properties for stats
@property int kills;




+(id)playerWithImageNamed:(NSString *)name;

-(void)movePlayerWithAccelerationXvalue:(double)x yValue:(double)y speed:(int)speed;


-(void)playerHit;



@end
