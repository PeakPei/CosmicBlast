//
//  CBMenuScene.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 12/26/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CBViewController.h"
#import "CBButtonDelegate.h"
#import "CBGameSceneDelegate.h"
#import "CBButtonBar.h"


@interface CBMenuScene : SKScene <CBButtonDelegate>

@property (nonatomic) CBButtonBar * buttonBar;
@property (weak) id <CBGameSceneDelegate> gameDelegate;
//@property UIViewController * viewController;



//+(id)initWithSize:(CGSize)size;

@end
