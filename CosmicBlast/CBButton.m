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


+(id)buttonWithColor:(SKColor *)color size:(CGSize)size{
    
    CBButton *button = [CBButton spriteNodeWithColor:color size:size];

    button.userInteractionEnabled = YES;
    return button;
    
}

-(void)setButtonDelegate:(id <CBButtonDelegate>)toSet{
    self.delegate = toSet;
}

-(void)updateLabelAndSetTitle:(NSString *)myTitle{
    self.title = myTitle;
    SKLabelNode * label = [SKLabelNode labelNodeWithText:myTitle];
    //[label setFontSize:22]
    ;
    [label setPosition:CGPointMake(0, label.frame.size.height*-0.5)];
    [self addChild:label];
}

-(void)setButtonPosition:(CGPoint)position{
    [self setSummary:NSStringFromCGSize(self.size)];
    [self setPosition : position];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self description];
    [self.delegate executeButtonFunction:self.title];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.delegate buttonReleased:self.title];
}

-(NSString *)description{
    return self.summary;
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
