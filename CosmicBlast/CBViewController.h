//
//  CBViewController.h
//  CosmicBlast
//

//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "CBMenuScene.h"
#import "CBMyScene.h"
#import "CBGameSceneDelegate.h"
#import "CBTiltManager.h"



@interface CBViewController : UIViewController <CBGameSceneDelegate>
@property CBMyScene * gameScene;
@property CBTiltManager * tiltManager;
- (void)returnToParentMenu;


@end
