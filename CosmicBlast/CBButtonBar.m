//
//  CBButtonBar.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 9/8/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBButtonBar.h"

#import "EnumConstants.h"
#import <CosmicBlast-Swift.h>

@implementation CBButtonBar : SKSpriteNode

CGFloat buttonRatio;
CGRect sceneFrame;




+(id)buttonBarWithFrame:(CGRect)frame buttonDelegate:(id <CBButtonDelegate>)delegate {
    //CGSize mySize = CGSizeMake(frame.size.width, frame.size.height/buttonRatio);
    CBButtonBar * buttonBar = [CBButtonBar emptyBarWithFrame:frame];
    
    //[buttonBar setButtonValues];
    for (CBButton * button in buttonBar.buttons){
        button.delegate = delegate;
    }
    return buttonBar;
}




+(instancetype)menuButtonBarWithFrame:(CGRect)frame buttonDelegate:(id <CBButtonDelegate>)delegate{
    CBButtonBar * buttonBar = [CBButtonBar emptyBarWithFrame:frame];
    
    //[buttonBar setButtonValues];
    for (CBButton * button in buttonBar.buttons){
        button.delegate = delegate;
    }
    [buttonBar setButtonTitles:[CBButtonBar getMenuButtonTitles]];
    return buttonBar;
}

+(instancetype)settingsButtonBarWithFrame:(CGRect)frame buttonDelegate:(id <CBButtonDelegate>)delegate{
    CBButtonBar * buttonBar = [CBButtonBar emptyBarWithFrame:frame];
    
    //[buttonBar setButtonValues];
    for (CBButton * button in buttonBar.buttons){
        button.delegate = delegate;
    }
    [buttonBar setButtonTitles:[CBButtonBar getSettingsButtonTitles]];
    return buttonBar;
}


+(instancetype)gameButtonBarWithFrame:(CGRect)frame buttonDelegate:(id <CBButtonDelegate>)delegate{
    CBButtonBar * buttonBar = [CBButtonBar emptyBarWithFrame:frame];
    
    //[buttonBar setButtonValues];
    for (CBButton * button in buttonBar.buttons){
        button.delegate = delegate;
    }
    [buttonBar setButtonTitles:[CBButtonBar getGameButtonTitles]];
    return buttonBar;
}
+(instancetype)instructionButtonBarWithFrame:(CGRect)frame buttonDelegate:(id <CBButtonDelegate>)delegate{
    CBButtonBar * buttonBar = [CBButtonBar emptyBarWithFrame:frame];
    
    //[buttonBar setButtonValues];
    for (CBButton * button in buttonBar.buttons){
        button.delegate = delegate;
    }
    [buttonBar setButtonTitles:[CBButtonBar getInstructionButtonTitles]];
    return buttonBar;
    
}

+(instancetype)demoButtonBarWithFrame:(CGRect)frame buttonDelegate:(id <CBButtonDelegate>)delegate{
    CBButtonBar * buttonBar = [CBButtonBar emptyBarWithFrame:frame];
    
    //[buttonBar setButtonValues];
    for (CBButton * button in buttonBar.buttons){
        button.delegate = delegate;
    }
    [buttonBar setButtonTitles:[CBButtonBar getDemoButtonTitles]];
    return buttonBar;
}


+(instancetype)emptyBarWithFrame:(CGRect)frame{
    buttonRatio = [[[GameValues alloc] init] uiRatio];
    sceneFrame = frame;
    CGSize mySize = CGSizeMake(sceneFrame.size.width, sceneFrame.size.height/buttonRatio);
    CBButtonBar * buttonBar = [CBButtonBar spriteNodeWithColor:[UIColor clearColor] size:(mySize)];
    [buttonBar setButtonValues];
    return buttonBar;
}

+(NSArray<CBButton*> *)getMenuButtonTitles{
    return [NSArray arrayWithObjects:@"Previous\nLevel", @"Next\nLevel", @"Settings",  @"Start\nLevel", nil];
}


+(NSArray<CBButton*> *)getDemoButtonTitles{
    return [NSMutableArray arrayWithObjects:@"Break", @"Pause", @"-", @"Return", nil];
}

+(NSArray<CBButton*> *)getGameButtonTitles{
    return [NSMutableArray arrayWithObjects:@"Break", @"Pause", @"-", @"Menu", nil];
}


+(NSArray<CBButton*> *)getInstructionButtonTitles{
    return [NSArray arrayWithObjects:@"Previous\nPage", @"Next\nPage", @"-", @"Main\nMenu", nil];
}



+(NSArray<CBButton*> *)getSettingsButtonTitles{
    return [NSArray arrayWithObjects:@"Default\nTilt",@"Calibrate\nTilt",@"-", @"Main\nMenu", nil];
}


-(void)setButtonTitles:(NSArray *)titles {
    for (int i = 0; i<titles.count; i++){
        [[self.buttons objectAtIndex:i] updateLabelAndSetTitle:[titles objectAtIndex:i]];
        
    }

    
    
}


-(void)setButtonValues{

    [self setPosition:CGPointMake(sceneFrame.size.width/2, 0)];
    CBButton * farLeftButton, * leftButton, * rightButton, * farRightButton;
    

    
    farLeftButton = [CBButton buttonWithColor:[UIColor clearColor] size:CGSizeMake(sceneFrame.size.width/4, sceneFrame.size.height/buttonRatio)];
    
    leftButton = [CBButton buttonWithColor:[UIColor clearColor] size:CGSizeMake(sceneFrame.size.width/4, sceneFrame.size.height/buttonRatio)];
    
    rightButton = [CBButton buttonWithColor:[UIColor clearColor] size:CGSizeMake(sceneFrame.size.width/4, sceneFrame.size.height/buttonRatio)];
    
    farRightButton = [CBButton buttonWithColor:[UIColor clearColor] size:CGSizeMake(sceneFrame.size.width/4, sceneFrame.size.height/buttonRatio)];
    
    [farLeftButton setPosition:CGPointMake(-farLeftButton.size.width*1.5, farLeftButton.size.height/2)];
    [leftButton setPosition:CGPointMake(-leftButton.size.width/2, leftButton.size.height/2)];
    [rightButton setPosition:CGPointMake(rightButton.size.width/2, rightButton.size.height/2)];
    [farRightButton setPosition:CGPointMake(farRightButton.size.width*1.5, farRightButton.size.height/2)];
    
    
    self.buttons = [NSArray arrayWithObjects:farLeftButton, leftButton, rightButton, farRightButton, nil];

    
    for (CBButton * button in self.buttons){
        
        [self addChild:button];
    }
    


}
@end
