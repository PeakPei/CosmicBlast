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
CBButton * demoButton;
CBButton * nextButton;



int currentPage;

NSMutableArray * pages;
NSMutableArray * buttonSequence;


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {

        
    }
    return self;
}




-(void)setUIValues {

    
  
    // set up button bar
    self.buttonBar = [CBButtonBar instructionButtonBarWithFrame:self.frame buttonDelegate:self];
    [self addChild:self.buttonBar];
    
    
    
    //initializeButtons
    nextButton = [CBButton buttonWithImageNamed:@"Next"];
    nextButton.delegate = self;
    [nextButton setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height/4.75))];
    
    demoButton = [CBButton buttonWithImageNamed:@"Demo"];
    demoButton.delegate = self;
    [demoButton setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height/4.75))];
    
    //set up label
    [self initializeInstructionText];
    currentPage = 0;
    
    instructionLabel1 = [[DSMultilineLabelNode alloc] init];
    instructionLabel1.text = pages[currentPage];
    [instructionLabel1 setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height* 0.65))];
    instructionLabel1.paragraphWidth = self.frame.size.width;
    
    [self addChild:instructionLabel1];
    
    [self addChild:buttonSequence[currentPage]];
    
    
    visualizer = [CBTiltVisualizer tiltVisualizerWithTiltManager:self.tiltManager];
    [visualizer setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height/2))];
    [visualizer setAlphaValue:0.8];
    [self addChild:visualizer];
    
}


-(void)nextInstructionStep {
    currentPage ++;
    if (currentPage < [pages count]){
        instructionLabel1.text = pages[currentPage];
        [demoButton removeFromParent];
        [nextButton removeFromParent];
        [self addChild:buttonSequence[currentPage]];
    } else {
        [self.gameDelegate launchMenuScreen];
    }
}


-(void)previousInstructionStep {
    currentPage --;
    if (currentPage >= 0){
        instructionLabel1.text = pages[currentPage];
        [demoButton removeFromParent];
        [nextButton removeFromParent];
        [self addChild:buttonSequence[currentPage]];
    } else {
        currentPage ++;
    }
}

-(void)setPage:(int)i{
    currentPage = i-1;
    [self nextInstructionStep];
}


//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//
//}


-(void)initializeInstructionText {
    pages = [[NSMutableArray alloc] init];
    buttonSequence =[[NSMutableArray alloc] init];
    //[pages addObject:@"The four buttons at the bottom of the screen are always there to be used for various functions.  Be mindful of the options they give are always there to be used for various functions. and fuck and shit and stuff"];
    
    [pages addObject:@"Welcome to Tilt Rider!  First, notice the four buttons at the bottom of the screen. These allow you to do things like start a level or pause the game.  Pay attention to what the labels say"];
    [buttonSequence addObject:nextButton];
    
    
    [pages addObject:@"In this game you will move around 2D levels by tilting your device.  Observe the white Tilt Indicator line in the center of your screen, and how it behaves as you tilt your device. "];
    [buttonSequence addObject:nextButton];
    
    [pages addObject:@"The Tilt Indicator shows which direction your player will move.  Angle your phone so that the screen faces directly up and press the demo buttton to try moving around."];
    [buttonSequence addObject:demoButton];
    
    [pages addObject:@"You can try the Movement demo again by tapping the previous page button.  You can callibrate the Tilt indicator to your preference in the settings menu."];
    [buttonSequence addObject:nextButton];
    
    [pages addObject:@"In addition to moving around, you will need to shoot at your enemies.  Tapping anywhere on the screen will let you shoot in that direction relative to the player"];
    [buttonSequence addObject:nextButton];
    
    [pages addObject:@"Tap on or towards your enemies to fire shots at them and destroy them.  Tap the Demo Button below to give it a shot."];
    [buttonSequence addObject:demoButton];

    [pages addObject:@"Nice job. New levels will become available as you progress.  The difficulty can be adjusted in the settings menu."];
    [buttonSequence addObject:nextButton];

}


-(void)executeButtonFunction:(NSString *)function{
    if([function isEqualToString:@"Previous\nPage"]){
        [self previousInstructionStep];
    }if([function isEqualToString:@"Next\nPage"]){
        [self nextInstructionStep];
    } else if([function isEqualToString:@"Main\nMenu"]){
        [self.gameDelegate launchMenuScreen];
    } else if([function isEqualToString:@"Demo"]){
        //Need to handle getting to next page
        // and being tilt centered
        [self.gameDelegate launchTutorialScreenNumber:currentPage+1];
    } else if([function isEqualToString:@"Next"]){
        [self nextInstructionStep];
    }
}
-(void)buttonReleased:(NSString *)function{
    
}

-(void)update:(NSTimeInterval)currentTime{
    [visualizer update];
}



@end
