//
//  CBHealthBar.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 12/11/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBHealthBar.h"

@implementation CBHealthBar

+(id)healthBarWithFrame:(CGRect)frame {
    
    
    
    
    
    
    
    CGFloat healthBarRatio = 15;
    CGSize mySize = CGSizeMake(frame.size.width, frame.size.height/healthBarRatio);
    CBHealthBar * healthBar = [CBHealthBar spriteNodeWithColor:[UIColor blueColor] size:(mySize)];
    [healthBar setPosition:CGPointMake(frame.size.width/2, frame.size.height)];
    
 
    
    
    return healthBar;
    
    
    
}


@end
