//
//  CBHealthBar.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 12/11/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CBPlayer.h"

@interface CBHealthBar : SKSpriteNode
@property CBPlayer * player;


+(id)healthBarWithFrame:(CGRect)frame player:(CBPlayer *)myPlayer;

-(void)updateHealthBar;

@end
