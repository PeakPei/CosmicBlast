//
//  CBInstructionScene.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 10/4/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

#import "CBInstructionScene.h"

@implementation CBInstructionScene




SKLabelNode * instructionLabel1;
SKLabelNode * instructionLabel2;
SKLabelNode * instructionLabel3;
SKLabelNode * instructionLabel4;
SKLabelNode * instructionLabel5;

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
    NSLog(@"SetUIValuesCalled in CBInstructionScene");
    //instructionsStrings = @[@"Welcome to Cosmic Blast", @"Overview", @"Movement", @"Buttons", @"Enemies"];
    currentPage = 0;
    instructionLabel1 = [SKLabelNode labelNodeWithText:pages[currentPage][0]];
    [instructionLabel1 setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height*0.85))];
    [self addChild:instructionLabel1];
    
    instructionLabel2 = [SKLabelNode labelNodeWithText:pages[currentPage][1]];
    [instructionLabel2 setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height*0.70))];
    [self addChild:instructionLabel2];
    
    instructionLabel3 = [SKLabelNode labelNodeWithText:pages[currentPage][2]];
    [instructionLabel3 setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height*0.55))];
    [self addChild:instructionLabel3];
    
    instructionLabel4 = [SKLabelNode labelNodeWithText:pages[currentPage][3]];
    [instructionLabel4 setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height*0.40))];
    [self addChild:instructionLabel4];

    instructionLabel5 = [SKLabelNode labelNodeWithText:@"Tap Screen To Continue"];
    [instructionLabel5 setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height*0.25))];
    [self addChild:instructionLabel5];

    self.buttonBar = [CBButtonBar emptyBarWithFrame:self.frame];
    [self addChild:self.buttonBar];
    
    UITextView * testView = [[UITextView alloc] init];
    testView.text = @"hello fuckers";
    
    
    
}


-(void)nextInstructionStep {
    currentPage ++;
    if (currentPage < [pages count]){
        instructionLabel1.text = pages[currentPage][0];
        instructionLabel2.text = pages[currentPage][1];
        instructionLabel3.text = pages[currentPage][2];
        instructionLabel4.text = pages[currentPage][3];
    } else {
        [self.gameDelegate launchMenuScreen];
    }
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //[self.gameDelegate returnToParentMenu];
    [self nextInstructionStep];
    //NSLog(@"touchesEnded in CBMenuScene");
}


-(void)initializeInstructionText {
    pages = [[NSMutableArray alloc] init];
    [pages addObject:@[@"Welcome to Cosmic Blast.", @"In this game you will", @"move around and defeat", @"enemies to advance."]];
    [pages addObject:@[@"You must hold your device", @"with the screen facing", @"directly up. Tilt the device", @"to make the player move"]];
    [pages addObject:@[@"The four buttons at the", @"bottom of the screen", @"can be used for various", @"functions."]];
    [pages addObject:@[@"At the top of the screen", @"in-game is your health", @"bar. It goes down as", @"you get hit by attacks."]];
    [pages addObject:@[@"Your enemies will fire", @"shots to damage you", @"and will move around", @"when you attack them."]];
    [pages addObject:@[@"You can shoot enemies", @"by tapping the screen.", @"They will change colors", @"As they lose health"]];
    [pages addObject:@[@"New levels will become", @"available as you progress", @"Good Luck!", @""]];
}



@end
