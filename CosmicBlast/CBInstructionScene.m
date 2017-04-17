//
//  CBInstructionScene.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 10/4/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

#import "CBInstructionScene.h"
#import "DSMultilineLabelNode.h"
@implementation CBInstructionScene




DSMultilineLabelNode * instructionLabel1;





int currentPage;

NSMutableArray * pages;


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //TODO make Background Color game values
        
        //long highestBeatenLevel = [[NSUserDefaults standardUserDefaults] integerForKey: @"highestBeatenLevel"];
        
        [self setBackgroundColor: [UIColor blueColor]];
        [self setUIValues];
        
        
    }
    return self;
};




-(void)setUIValues {
    //set up label
    [self initializeInstructionText];
    currentPage = 0;
    
    instructionLabel1 = [[DSMultilineLabelNode alloc] init];
    instructionLabel1.text = pages[currentPage];
    [instructionLabel1 setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height*0.5))];
    instructionLabel1.paragraphWidth = self.frame.size.width;
    
    [self addChild:instructionLabel1];
    

    self.buttonBar = [CBButtonBar emptyBarWithFrame:self.frame];
    [self addChild:self.buttonBar];
    
}


-(void)nextInstructionStep {
    currentPage ++;
    if (currentPage < [pages count]){
        instructionLabel1.text = pages[currentPage];
    } else {
        [self.gameDelegate launchMenuScreen];
    }
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self nextInstructionStep];
}


-(void)initializeInstructionText {
    pages = [[NSMutableArray alloc] init];
    [pages addObject:@"Lorem ipsum blah blah blah, guy thing sooooooo aaa yaaa In this game you will move around and defeat enemies to advance."];
    [pages addObject:@"You must hold your device with the screen facing directly up. Tilt the device to make the player move"];
    [pages addObject:@"The four buttons at the bottom of the screen can be used for various functions."];
    [pages addObject:@"At the top of the screen in-game is your health bar. It goes down as you get hit by attacks."];
    [pages addObject:@"Your enemies will fire shots to damage you and will move around when you attack them."];
    [pages addObject:@"You can shoot enemies by tapping the screen. They will change colors As they lose health"];
    [pages addObject:@"New levels will become available as you progress Good Luck!"];
}



@end
