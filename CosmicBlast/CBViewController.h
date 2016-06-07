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


@interface CBViewController : UIViewController <CBGameSceneDelegate>

//@property (nonatomic) BOOL menuScene;

@property CBMyScene * gameScene;
//@property CBMenuScene * menuScene;


@end
