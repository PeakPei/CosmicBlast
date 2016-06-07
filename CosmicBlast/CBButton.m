//
//  CBButton.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 9/8/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBButton.h"
#import "EnumConstants.h"
#import "CBButtonDelegate.h"

@implementation CBButton


+(id)buttonWithColor:(SKColor *)color size:(CGSize)size title:(NSString *)buttonTitle{
    
    CBButton *button = [CBButton spriteNodeWithColor:color size:size];
    
   
    
    button.title = buttonTitle;
    button.userInteractionEnabled = YES;
    
    
    return button;
    
}

-(void)setButtonDelegate:(id <CBButtonDelegate>)toSet{
    self.delegate = toSet;
}

-(void)setButtonPosition:(CGPoint)position{
    [self setSummary:NSStringFromCGSize(self.size)];
    [self setPosition : position];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    [self.handler handleButton:self];
    [self description];
    
}



-(NSString *)description{
    NSLog(@"Title: %@", self.title);
    return self.summary;
}


-(void)pause
{
    if(self.scene.view.paused)
    {
        self.scene.view.paused = NO;
    }
    else
    {
        self.scene.view.paused = YES;
    }
}

-(void)restart
{
    [self.delegate returnToMenuScreen];
}



-(void)switchToItem:(CBItem *)newItem
{
    //STUB
}

-(void)heal
{
    //STUB
}

-(void)block
{
    //STUB
}











@end
