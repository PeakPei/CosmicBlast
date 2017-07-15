//
//  CBSettingsScene.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 7/14/17.
//  Copyright © 2017 Teddy Kitchen. All rights reserved.
//

#import "CBSettingsScene.h"
#import "DSMultilineLabelNode.h"
#import "CosmicBlast-Swift.h"
#import "CBTiltVisualizer.h"

@implementation CBSettingsScene

CBTiltVisualizer * visualizer;



-(void)setUIValues {
    
    
    
    // set up button bar
    self.buttonBar = [CBButtonBar settingsButtonBarWithFrame:self.frame buttonDelegate:self];
    [self addChild:self.buttonBar];
    
    
    
    visualizer = [CBTiltVisualizer tiltVisualizerWithTiltManager:self.tiltManager];
    [visualizer setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height/2))];
    [visualizer setAlphaValue:0.8];
    [self addChild:visualizer];
    
}





-(void)executeButtonFunction:(NSString *)function{
    if([function isEqualToString:@"Previous\nPage"]){
//        [self previousInstructionStep];
    }if([function isEqualToString:@"Next\nPage"]){
//        [self nextInstructionStep];
    } else if([function isEqualToString:@"Main\nMenu"]){
        [self.gameDelegate launchMenuScreen];
    } else if([function isEqualToString:@"Reset\nTilt"]){
        [self.tiltManager setTiltZero];
    }
}


-(void)buttonReleased:(NSString *)function{
    
}

-(void)update:(NSTimeInterval)currentTime{
    [visualizer update];
}



@end
