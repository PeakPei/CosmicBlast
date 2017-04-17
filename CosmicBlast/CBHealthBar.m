//
//  CBHealthBar.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 12/11/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBHealthBar.h"

@implementation CBHealthBar

+(instancetype)healthBarWithFrame:(CGRect)frame player:(CBPlayer *)myPlayer
{
    CGFloat healthBarRatio = 10;
    CGSize mySize = CGSizeMake(frame.size.width, frame.size.height/healthBarRatio);
    CBHealthBar * healthBar = [CBHealthBar spriteNodeWithColor:[UIColor blueColor] size:(mySize)];
    [healthBar setPosition:CGPointMake(frame.size.width/2, frame.size.height-(healthBar.size.height/2))];
    [healthBar setPlayer:myPlayer];
    [healthBar updateHealthBar];
    return healthBar;
}

-(void)updateHealthBar
{
    //look at player/s health vs max health ratio
    //take that rato of the total length of the health bar as dead bar
    //remove old dead bar and add new dead bar to health bar
    
    if (self.player.health >= 0){
        CGFloat deadWidth = self.size.width-((self.size.width*self.player.health)/self.player.maxHealth);
        CGSize deadSize = CGSizeMake(deadWidth, self.size.height);
        SKSpriteNode * deadBar = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:deadSize];
        CGPoint deadPosition = CGPointMake((self.size.width-deadBar.size.width)/2, 0);
        [deadBar setPosition:deadPosition];
        [self removeAllChildren];
        [self addChild:deadBar];
    }
    //else end game
    
    
    
    
    
    
}


@end
