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
@interface CBViewController : UIViewController

@property (nonatomic) BOOL menuScene;
@property CBMyScene * gameScene;
//@property CBMenuScene * menuScene;


@end
