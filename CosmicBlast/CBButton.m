//
//  CBButton.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 9/8/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBButton.h"

@implementation CBButton


+(id)buttonWithColor:(SKColor *)color size:(CGSize)size{
    
    CBButton *button = [CBButton spriteNodeWithColor:color size:size];
    
    return button;
    
}



-(void)setButtonPosition:(CGPoint)position{
    
    self.position = position;
    
}


@end
