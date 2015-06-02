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
    
    
    
    
    button.userInteractionEnabled = YES;
    
    
    return button;
    
}



-(void)setButtonPosition:(CGPoint)position{
    
    //[NSStringFromCGPoint(self.position);
    //[self setSummary:@"hi"];
    //[self setSummary:NSStringFromCGPoint(position)];
    [self setSummary:NSStringFromCGSize(self.size)];
    [self setPosition : position];
    
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self description];
    
}



-(NSString *)description{
    
    
    NSLog(@"Summary: %@", self.summary);
    
    return self.summary;
}








@end
