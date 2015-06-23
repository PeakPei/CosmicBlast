//
//  CBViewController.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 7/23/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBViewController.h"
#import "CBMyScene.h"
#import "CBMenuScene.h"

@implementation CBViewController

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    //Set up for menuScene
    [self setMenuScene: true];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    if (!skView.scene) {
        
        
        //skView.showsFPS = YES;
        //skView.showsNodeCount = YES;
        
        
        // Create and configure the scene.
        
        SKScene * menuScene = [CBMenuScene sceneWithSize:skView.bounds.size];
        menuScene.scaleMode = SKSceneScaleModeAspectFill;
        [skView presentScene:menuScene];
        
        
    }
    
    
    
    
    // Present the scene.
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    if(self.menuScene)
    {
        
        //touch happened, start game, set up scene
        [self setMenuScene:false];
        SKView * skView = (SKView *)self.view;
        CBMyScene * gameScene = [CBMyScene sceneWithSize:skView.bounds.size];
        self.gameScene = gameScene;
        [skView presentScene:self.gameScene transition:[SKTransition crossFadeWithDuration:0.2]];
    

    }
    if (self.gameScene.player.dead)
    {
        [self setMenuScene:YES];
        
        SKView * skView = (SKView *)self.view;
        SKScene * menuScene = [CBMenuScene sceneWithSize:skView.bounds.size];
        menuScene.scaleMode = SKSceneScaleModeAspectFill;
        [skView presentScene:menuScene];
        

    }
        
    
}


//-(void)view




@end
