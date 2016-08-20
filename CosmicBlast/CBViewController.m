//
//  CBViewController.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 7/23/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBViewController.h"
#import "CBMyScene.h"
#import "CBAppDelegate.h"

@implementation CBViewController


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    NSInteger currentLevel = [[NSUserDefaults standardUserDefaults] integerForKey: @"currentLevel"];
    if (currentLevel == 0) {
        NSLog(@"currentLevel NSUserDefualt returned 0");
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey: @"currentLevel"];

    }
    
    //Set up for menuScene
//    [self setMenuScene: true];
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    if (!skView.scene) {
        
        
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        
        // Create and configure the scene.
        CBMenuScene * menuScene = [CBMenuScene sceneWithSize:skView.bounds.size];
        [menuScene setGameDelegate:self];
        menuScene.scaleMode = SKSceneScaleModeAspectFill;
        [skView presentScene:menuScene];
        
    }
    
    
    
}




- (IBAction)unwindToMainMenu:(UIStoryboardSegue*)sender
{

    NSLog(@"unwindToMainMenu called IBACTION");
    //UIViewController *sourceViewController = sender.sourceViewController;
    // Pull any data from the view controller which initiated the unwind segue.
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
    
    NSLog(@"LAUNCH GAME SCENE CALLED");
    SKView * skView = (SKView *)self.view;
    CBMyScene * gameScene = [CBMyScene sceneWithSize:skView.bounds.size];
    //SKScene * random = [SKScene sceneWithSize:skView.bounds.size];
    self.gameScene = gameScene;
    gameScene.gameDelegate = self;
    [skView presentScene:self.gameScene transition:[SKTransition crossFadeWithDuration:0.2]];

    
}




-(void)launchMenuScreen {
    SKView * skView = (SKView *)self.view;
    CBMenuScene * menuScene = [CBMenuScene sceneWithSize:skView.bounds.size];
    menuScene.gameDelegate = self;
    menuScene.scaleMode = SKSceneScaleModeAspectFill;
    menuScene.gameDelegate = self;
    [skView presentScene:menuScene transition:[SKTransition crossFadeWithDuration:0.2]];
}

- (void)returnToParentMenu
{
    //SKView * skView = (SKView *)self.view;
    //[skView presentScene:nil];
    CBAppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate resetWindowToInitialView];
    //[self performSegueWithIdentifier:@"unwindToMainMenu" sender:self];
    //[self performSegueWithIdentifier:@"returnToParentMenu" sender:self];
}







@end
