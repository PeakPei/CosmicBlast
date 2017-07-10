//
//  CBMenuScene.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 12/26/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBMenuScene.h"
#import "CBTiltVisualizer.h"
#import "CosmicBlast-Swift.h"
#import "DSMultilineLabelNode.h"
#import "CBButton.h"

@implementation CBMenuScene

DSMultilineLabelNode * instructionLabel;
SKLabelNode * levelInfoLabel;
CBTiltVisualizer * visualizer;


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {        
        SKSpriteNode * menuLogo = [SKSpriteNode spriteNodeWithImageNamed:@"MenuLogo"];
        [self addChild:menuLogo];
        CGPoint logoPosition = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
        [menuLogo setPosition:logoPosition];
    }
    return self;
};


-(void)setUIValues {
    //set up label
    instructionLabel = [[DSMultilineLabelNode alloc] init];
    [self updateInstructionLabel];

    [instructionLabel setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height/1.25))];
    [self addChild:instructionLabel];

    
    //Set up button bar
    self.buttonBar = [CBButtonBar menuButtonBarWithFrame:self.frame buttonDelegate:self];
    [self addChild:self.buttonBar];
    
    CBButton * tutorialButton = [CBButton buttonWithImageNamed:@"Tutorial"];
    tutorialButton.delegate = self;
    [tutorialButton setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height/4))];
    [self addChild:tutorialButton];
    
    
    visualizer = [CBTiltVisualizer tiltVisualizerWithTiltManager:self.tiltManager];
    [visualizer setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height/2))];
    [self addChild:visualizer];
    
    

}



-(void)setLevelNumber:(int)number{
    [[NSUserDefaults standardUserDefaults] setInteger:number forKey: @"currentLevel"];
    NSString * levelLocation =  [[[GameValues alloc] init] getWorldImageDescription];
    NSString * levelString = [NSString stringWithFormat:@"Current Level: %d\nLocation: %@\nPress Start Level", number, levelLocation];
    instructionLabel.text = levelString;
}



-(void)updateInstructionLabel{
    int currentLevel = (int)[[NSUserDefaults standardUserDefaults] integerForKey: @"currentLevel"];
    [self setLevelNumber:currentLevel];
    

}




-(void)update:(NSTimeInterval)currentTime{
    [visualizer update];
}


-(void)returnToParentMenu {
    [self.gameDelegate returnToParentMenu];
    
}

-(void)pause {
    NSLog(@"Pause called on CBMenuScene,  RETHINK THIS");
}



-(void)executeButtonFunction:(NSString *)function{
    if([function isEqualToString:@"Previous\nLevel"]){
        [self previousLevel];
    } else if ([function isEqualToString:@"Next\nLevel"]){
        //Remove this for production we want to limit the highest accessible level
        [[NSUserDefaults standardUserDefaults] setInteger:20 forKey:@"highestBeatenLevel"];
        [self nextLevel];
    } else if([function isEqualToString:@"Tutorial"]){
        [self.gameDelegate launchInstructionScreen];
    } else if([function isEqualToString:@"Start\nLevel"]){
        [self.gameDelegate launchGameScreen];
    }
    NSLog(@"function:%@", function);
}

-(void)buttonReleased:(NSString *)function{

}




-(void)nextLevel{
    NSInteger currentLevel = [[NSUserDefaults standardUserDefaults] integerForKey: @"currentLevel"];
    if (currentLevel <= [[NSUserDefaults standardUserDefaults] integerForKey:@"highestBeatenLevel"] && currentLevel < [[NSUserDefaults standardUserDefaults] integerForKey:@"availableLevels"]){
        [self setLevelNumber:currentLevel+1.0];
    }
    
}
-(void)previousLevel{
    NSInteger currentLevel = [[NSUserDefaults standardUserDefaults] integerForKey: @"currentLevel"];
    if (currentLevel >1){
        [self setLevelNumber:currentLevel-1.0];
    }
}

 
@end
