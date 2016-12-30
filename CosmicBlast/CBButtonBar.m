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
+(instancetype)gameButtonBarWithFrame:(CGRect)frame buttonDelegate:(id <CBButtonDelegate>)delegate{
    CBButtonBar * buttonBar = [CBButtonBar emptyBarWithFrame:frame];
    
    //[buttonBar setButtonValues];
    for (CBButton * button in buttonBar.buttons){
        button.delegate = delegate;
    }
    [buttonBar setButtonTitles:[CBButtonBar getGameButtonTitles]];
    return buttonBar;
}


+(instancetype)emptyBarWithFrame:(CGRect)frame{
    buttonRatio = [[[GameValues alloc] init] uiRatio];
    sceneFrame = frame;
    CGSize mySize = CGSizeMake(sceneFrame.size.width, sceneFrame.size.height/buttonRatio);
    CBButtonBar * buttonBar = [CBButtonBar spriteNodeWithColor:[UIColor blackColor] size:(mySize)];
    [buttonBar setButtonValues];
    return buttonBar;
}

+(NSArray<CBButton*> *)getMenuButtonTitles{
    return [NSArray arrayWithObjects:@"<-", @"->", @"?", @"4", nil];
}

+(NSArray<CBButton*> *)getGameButtonTitles{
    return [NSMutableArray arrayWithObjects:@"break", @"pause", @"7", @"menu", nil];
}




-(void)setButtonTitles:(NSArray *)titles {
    for (int i = 0; i<titles.count; i++){
        [[self.buttons objectAtIndex:i] updateLabelAndSetTitle:[titles objectAtIndex:i]];
        
    }

    
    
}


-(void)setButtonValues{

    [self setPosition:CGPointMake(sceneFrame.size.width/2, 0)];
    CBButton * farLeftButton, * leftButton, * rightButton, * farRightButton;
    

    
    farLeftButton = [CBButton buttonWithColor:[UIColor blueColor] size:CGSizeMake(sceneFrame.size.width/4, sceneFrame.size.height/buttonRatio)];
    
    leftButton = [CBButton buttonWithColor:[UIColor redColor] size:CGSizeMake(sceneFrame.size.width/4, sceneFrame.size.height/buttonRatio)];
    
    rightButton = [CBButton buttonWithColor:[UIColor blackColor] size:CGSizeMake(sceneFrame.size.width/4, sceneFrame.size.height/buttonRatio)];
    
    farRightButton = [CBButton buttonWithColor:[UIColor greenColor] size:CGSizeMake(sceneFrame.size.width/4, sceneFrame.size.height/buttonRatio)];
    
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
