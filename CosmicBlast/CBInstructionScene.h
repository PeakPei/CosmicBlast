//
//  CBInstructionScene.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 10/4/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CBViewController.h"
#import "CBButtonDelegate.h"
#import "CBGameSceneDelegate.h"
#import "CBButtonBar.h"



@interface CBInstructionScene : SKScene <CBButtonDelegate>

@property (nonatomic) CBButtonBar * buttonBar;
@property (weak) id <CBGameSceneDelegate> gameDelegate;
@property CBTiltManager * tiltManager;


-(void)setUIValues;
-(void)setPage:(int)i;

@end
