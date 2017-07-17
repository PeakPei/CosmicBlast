//
//  CBSettingsScene.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 7/14/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

#import "CBSettingsScene.h"
#import "DSMultilineLabelNode.h"
#import "CosmicBlast-Swift.h"
#import "CBTiltVisualizer.h"

@implementation CBSettingsScene

CBTiltVisualizer * visualizer;
DSMultilineLabelNode * infoLabel;


-(void)setUIValues {
    
    //set up label
    infoLabel = [[DSMultilineLabelNode alloc] init];
    [self updateInfoLabel];
    
    [infoLabel setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height/1.25))];
    [self addChild:infoLabel];
    
    
    
    // set up button bar
    self.buttonBar = [CBButtonBar settingsButtonBarWithFrame:self.frame buttonDelegate:self];
    [self addChild:self.buttonBar];
    
    
    
    CBButton * easyButton = [CBButton buttonWithImageNamed:@"Easy"];
    CBButton * normalButton = [CBButton buttonWithImageNamed:@"Normal"];
    CBButton * hardButton = [CBButton buttonWithImageNamed:@"Hard"];
    
    easyButton.delegate = self;
    normalButton.delegate = self;
    hardButton.delegate = self;
    
    [hardButton setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height * 0.2))];
    [normalButton setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height * 0.35))];
    [easyButton setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height * 0.5))];
    
    [self addChild:easyButton];
    [self addChild:normalButton];
    [self addChild:hardButton];
    
    
    
    visualizer = [CBTiltVisualizer tiltVisualizerWithTiltManager:self.tiltManager];
    [visualizer setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height/2))];
    [visualizer setAlphaValue:1];
    [self addChild:visualizer];
    
}



-(void)updateInfoLabel{
    NSString * tiltCalibrationString;
    if([self tiltManager].customTilt){
        tiltCalibrationString = @"\nTilt Callibration: Custom";
    } else {
        tiltCalibrationString = @"\nTilt Callibration: Default";
    }
    
    
    int currentDifficulty = (int)[[NSUserDefaults standardUserDefaults] integerForKey: @"difficulty"];
    NSString * difficultyString;
    if(currentDifficulty == 1){
        difficultyString = @"Easy";
    } else if (currentDifficulty == 2){
        difficultyString = @"Normal";
    } else if (currentDifficulty == 3){
        difficultyString = @"Hard";
    }
    if (currentDifficulty>0 && currentDifficulty<4){
        NSString * infoString = [NSString stringWithFormat:@"Current Difficulty: %@ %@", difficultyString,tiltCalibrationString];
        infoLabel.text = infoString;
    } else {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey: @"difficulty"];
        NSLog(@"Invalid Difficulty Selected.  See SetDifficultyNumber");
    }

    
    
    
//    [self setDifficultyNumber:currentDifficulty];
    
    
}




-(void)setDifficultyNumber:(int)number{
    [[NSUserDefaults standardUserDefaults] setInteger:number forKey: @"difficulty"];
}



-(void)executeButtonFunction:(NSString *)function{
    if([function isEqualToString:@"Main\nMenu"]){
        [self.gameDelegate launchMenuScreen];
    } else if([function isEqualToString:@"Calibrate\nTilt"]){
        [self.tiltManager setTiltZero];
    } else if([function isEqualToString:@"Default\nTilt"]){
        [self.tiltManager resetTiltZero];
    } else if([function isEqualToString:@"Easy"]){
        [self setDifficultyNumber:1];
    } else if([function isEqualToString:@"Normal"]){
        [self setDifficultyNumber:2];
    } else if([function isEqualToString:@"Hard"]){
        [self setDifficultyNumber:3];
    }
}


-(void)buttonReleased:(NSString *)function{
    
}

-(void)update:(NSTimeInterval)currentTime{
    [self updateInfoLabel];
    [visualizer update];
}



@end
