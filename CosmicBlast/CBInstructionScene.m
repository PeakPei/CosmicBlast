//
//  CBInstructionScene.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 10/4/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

#import "CBInstructionScene.h"

@implementation CBInstructionScene




SKLabelNode * instructionLabel;
NSArray * instructionsStrings;
int currentInstructionsIndex;


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
    NSLog(@"SetUIValuesCalled in CBInstructionScene");
    instructionsStrings = @[@"Instructions, bitch", @"2", @"3", @"4", @"5"];
    currentInstructionsIndex = 0;
    instructionLabel = [SKLabelNode labelNodeWithText:instructionsStrings[currentInstructionsIndex]];
    [instructionLabel setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height/2))];
    [self addChild:instructionLabel];
    
}

-(void)nextInstructionStep {
    currentInstructionsIndex ++;
    if (currentInstructionsIndex < [instructionsStrings count]){
        instructionLabel.text =instructionsStrings[currentInstructionsIndex];
    } else {
        [self.gameDelegate launchMenuScreen];
    }

//    instructionLabel = [SKLabelNode labelNodeWithText:instructionsStrings[currentInstructionsIndex]];
    
    //[self.gameDelegate launchMenuScreen];
    
}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //[self.gameDelegate returnToParentMenu];
    [self nextInstructionStep];

    //NSLog(@"touchesEnded in CBMenuScene");
}

@end
