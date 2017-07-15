//
//  CBSettingsScene.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 7/14/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CBViewController.h"
#import "CBButtonDelegate.h"
#import "CBGameSceneDelegate.h"
#import "CBButtonBar.h"



@interface CBSettingsScene : SKScene <CBButtonDelegate>


@property (nonatomic) CBButtonBar * buttonBar;
@property (weak) id <CBGameSceneDelegate> gameDelegate;
@property CBTiltManager * tiltManager;

-(void)setUIValues;

@end
