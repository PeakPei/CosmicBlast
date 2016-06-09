//
//  CBViewController.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 7/23/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBViewController.h"
#import "CBMyScene.h"


@implementation CBViewController 

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
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
    CBMyScene * gameScene = [CBMyScene sceneWithSize:skView.bounds.size];
    self.gameScene = gameScene;
    gameScene.gameDelegate = self;
    [skView presentScene:self.gameScene transition:[SKTransition crossFadeWithDuration:0.2]];

    
}




-(void)launchMenuScreen {
    SKView * skView = (SKView *)self.view;
    NSLog(@"about to init");
    CBMenuScene * menuScene = [CBMenuScene initWithSize:skView.bounds.size];
    NSLog(@"inited");
    menuScene.gameDelegate = self;
    menuScene.scaleMode = SKSceneScaleModeAspectFill;
    menuScene.gameDelegate = self;
    [skView presentScene:menuScene transition:[SKTransition crossFadeWithDuration:0.2]];
}



@end
