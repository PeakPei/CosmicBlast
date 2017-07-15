//
//  CBButtonBar.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 9/8/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CBButtonDelegate.h"
#import "CBButton.h"
@interface CBButtonBar : SKSpriteNode


@property (nonatomic) NSArray<CBButton*> * buttons;




+(id)buttonBarWithFrame:(CGRect)frame buttonDelegate:(id <CBButtonDelegate>)delegate;

+(instancetype)menuButtonBarWithFrame:(CGRect)frame buttonDelegate:(id <CBButtonDelegate>)delegate;

+(instancetype)settingsButtonBarWithFrame:(CGRect)frame buttonDelegate:(id <CBButtonDelegate>)delegate;

+(instancetype)gameButtonBarWithFrame:(CGRect)frame buttonDelegate:(id <CBButtonDelegate>)delegate;

+(instancetype)instructionButtonBarWithFrame:(CGRect)frame buttonDelegate:(id <CBButtonDelegate>)delegate;

+(instancetype)demoButtonBarWithFrame:(CGRect)frame buttonDelegate:(id <CBButtonDelegate>)delegate;
@end
