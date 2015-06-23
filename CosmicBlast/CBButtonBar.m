//
//  CBButtonBar.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 9/8/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBButtonBar.h"
#import "CBButton.h"
#import "EnumConstants.h"
#import "CBButtonHandler.h"

@implementation CBButtonBar



//Creates button bar initialized with buttons
+(id)buttonBarWithFrame:(CGRect)frame {
    
    CGFloat buttonRatio = 15;
    CGSize mySize = CGSizeMake(frame.size.width, frame.size.height/buttonRatio);
    CBButtonBar * buttonBar = [CBButtonBar spriteNodeWithColor:[UIColor blackColor] size:(mySize)];
    [buttonBar setPosition:CGPointMake(frame.size.width/2, 0)];
    CBButton * farLeftButton, * leftButton, * rightButton, * farRightButton;
    
    
    //create handler for buttons
    CBButtonHandler * handler = [CBButtonHandler buttonHandler];
    
    //createButtons
    farLeftButton = [CBButton buttonWithColor:[UIColor blueColor] size:CGSizeMake(frame.size.width/4, frame.size.height/buttonRatio) title:[CBButtonHandler getFarLeftButtonName]];
    
    leftButton = [CBButton buttonWithColor:[UIColor redColor] size:CGSizeMake(frame.size.width/4, frame.size.height/buttonRatio) title:[CBButtonHandler getLeftButtonName]];
    
    rightButton = [CBButton buttonWithColor:[UIColor blackColor] size:CGSizeMake(frame.size.width/4, frame.size.height/buttonRatio) title:[CBButtonHandler  getRightButtonName]];
    
    farRightButton = [CBButton buttonWithColor:[UIColor greenColor] size:CGSizeMake(frame.size.width/4, frame.size.height/buttonRatio) title:[CBButtonHandler getFarRightButtonName]];

    [farLeftButton setPosition:CGPointMake(-farLeftButton.size.width*1.5, farLeftButton.position.y)];
    [leftButton setPosition:CGPointMake(-leftButton.size.width/2, leftButton.position.y)];
    [rightButton setPosition:CGPointMake(rightButton.size.width/2, rightButton.position.y)];
    [farRightButton setPosition:CGPointMake(farRightButton.size.width*1.5, farRightButton.position.y)];
    
    
    
    
    
    buttonBar.buttons = [NSArray arrayWithObjects:farLeftButton, leftButton, rightButton, farRightButton, nil];
    
    for (CBButton * button in buttonBar.buttons){
        
        [buttonBar addChild:button];
        [button setHandler:handler];
        
        
        
    }
    
// This should bee fixed so we are not hard coding it.
//    [handler mapButton:farLeftButton toTask:[CBButtonHandler pauseTaskName]];
    handler.buttonMap = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                         [CBButtonHandler pauseTaskName] , [CBButtonHandler getFarLeftButtonName], nil];
    
  //@{
    //                      [CBButtonHandler getFarLeftButtonName] : [CBButtonHandler pauseTaskName]
      //                    };
    
    
    return buttonBar;
    
    
    
}


@end
