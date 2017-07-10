//
//  CBButton.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 9/8/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//


#import <SpriteKit/SpriteKit.h>
#import "CBItem.h"
#import "CBButtonDelegate.h"


@interface CBButton : SKSpriteNode

//@property NSString * summary;
@property NSString * title;
@property (weak) id <CBButtonDelegate> delegate;


+(id)buttonWithColor:(SKColor *)color size:(CGSize)size;

+(id)buttonWithImageNamed:(NSString *)name;

-(void)updateLabelAndSetTitle:(NSString *)myTitle;

//-(NSString *)description;

-(void)setButtonPosition:(CGPoint)position;







@end
