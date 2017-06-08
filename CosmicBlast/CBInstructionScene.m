//
//  CBInstructionScene.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 10/4/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

#import "CBInstructionScene.h"
#import "DSMultilineLabelNode.h"
#import "CosmicBlast-Swift.h"
#import "CBTiltVisualizer.h"


@implementation CBInstructionScene




DSMultilineLabelNode * instructionLabel1;
CBTiltVisualizer * visualizer;




int currentPage;

NSMutableArray * pages;


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {

        
    }
    return self;
}




-(void)setUIValues {
    //set up label
    [self initializeInstructionText];
    currentPage = 0;
    
    instructionLabel1 = [[DSMultilineLabelNode alloc] init];
    instructionLabel1.text = pages[currentPage];
    [instructionLabel1 setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height*0.5))];
    instructionLabel1.paragraphWidth = self.frame.size.width;
    
    [self addChild:instructionLabel1];
    
  
    // set up button bar
    self.buttonBar = [CBButtonBar instructionButtonBarWithFrame:self.frame buttonDelegate:self];
    [self addChild:self.buttonBar];
    
    visualizer = [CBTiltVisualizer tiltVisualizerWithTiltManager:self.tiltManager];
    [visualizer setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height/2))];
    [self addChild:visualizer];
    
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
    [pages addObject:@"The four buttons at the bottom of the screen are always there to be used for various functions.  Be mindful of the options they give"];
    
    [pages addObject:@"In this game you will move around and defeat enemies to advance."];
    [pages addObject:@"You must hold your device with the screen facing directly up. Tilt the device to make the player move"];
    [pages addObject:@"At the top of the screen in-game is your health bar. It goes down as you get hit by attacks."];
    [pages addObject:@"Your enemies will fire shots to damage you and will move around when you attack them."];
    [pages addObject:@"You can shoot enemies by tapping the screen. They will change colors As they lose health"];
    [pages addObject:@"New levels will become available as you progress Good Luck!"];
}


-(void)executeButtonFunction:(NSString *)function{
    if([function isEqualToString:@"Previous\nPage"]){
        [self.tiltManager resetTiltZero];
    } else if([function isEqualToString:@"Main\nMenu"]){
        [self.gameDelegate launchMenuScreen];
    } else if([function isEqualToString:@"Reset\nTilt"]){
        [self.tiltManager setTiltZero];
    }
}
-(void)buttonReleased:(NSString *)function{
    
}

-(void)update:(NSTimeInterval)currentTime{
    [visualizer update];
}



@end
