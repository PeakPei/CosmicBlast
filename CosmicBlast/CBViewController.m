//
//  CBViewController.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 7/23/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBViewController.h"
#import "CBMyScene.h"
#import "CBInstructionScene.h"
#import "CBAppDelegate.h"


@implementation CBViewController


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NSInteger currentLevel = [[NSUserDefaults standardUserDefaults] integerForKey: @"currentLevel"];
    if (currentLevel == 0) {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey: @"currentLevel"];
    }
    CBTiltManager * manager = [CBTiltManager tiltManager];
    [self setTiltManager:manager];
    
    
     
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    if (!skView.scene) {
        [self launchMenuScreen];
//        skView.showsFPS = YES;
//        
//        // Create and configure the scene.
//        CBMenuScene * menuScene = [CBMenuScene sceneWithSize:skView.bounds.size];
//        [menuScene setGameDelegate:self];
//        menuScene.scaleMode = SKSceneScaleModeAspectFill;
//        [skView presentScene:menuScene];
    }
}




- (IBAction)unwindToMainMenu:(UIStoryboardSegue*)sender
{
}



- (BOOL)shouldAutorotate
{
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


-(void)launchGameScreen {
    SKView * skView = (SKView *)self.view;
    int currentLevel = (int)[[NSUserDefaults standardUserDefaults] integerForKey: @"currentLevel"];
    NSString * fileName = [NSString stringWithFormat:@"Level-%d", currentLevel];
    CBMyScene * gameScene = [CBMyScene unarchiveFromFile:fileName withSize:skView.bounds.size];
    self.gameScene = gameScene;
    gameScene.gameDelegate = self;
    gameScene.tiltManager = self.tiltManager;
    [gameScene prepareForDisplay];
    [skView presentScene:self.gameScene transition:[SKTransition crossFadeWithDuration:0.2]];
}


-(void)launchMenuScreen {
    SKView * skView = (SKView *)self.view;
    CBMenuScene * menuScene = [CBMenuScene sceneWithSize:skView.bounds.size];
    [menuScene setTiltManager:[self tiltManager]];
    menuScene.gameDelegate = self;
    [menuScene setUIValues];
    
    
    menuScene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:menuScene transition:[SKTransition crossFadeWithDuration:0.2]];
    
}

-(void)launchInstructionScreen {
    SKView * skView = (SKView *)self.view;
    CBInstructionScene * instructionScene = [CBInstructionScene sceneWithSize:skView.bounds.size];
    
    [instructionScene setTiltManager:[self tiltManager]];
    instructionScene.gameDelegate = self;
    [instructionScene setUIValues];
    instructionScene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:instructionScene transition:[SKTransition crossFadeWithDuration:0.2]];
}

-(void)launchTutorialScreenNumber:(int)i {
    SKView * skView = (SKView *)self.view;
    NSString * fileName = [NSString stringWithFormat:@"Demo-%d", i];
    NSLog(@"FileName for demo scene = %@", fileName);
    CBMyScene * gameScene = [CBMyScene unarchiveFromFile:fileName withSize:skView.bounds.size];
    self.gameScene = gameScene;
    gameScene.gameDelegate = self;
    gameScene.tiltManager = self.tiltManager;
    [gameScene prepareForDisplay];
    [skView presentScene:self.gameScene transition:[SKTransition crossFadeWithDuration:0.2]];
}




-(BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)returnToParentMenu
{
}


@end
