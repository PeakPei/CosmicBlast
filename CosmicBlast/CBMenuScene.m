//
//  CBMenuScene.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 12/26/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBMenuScene.h"
#import "CBLogger.h"
#import "CBTiltVisualizer.h"
#import "CosmicBlast-Swift.h"
#import "DSMultilineLabelNode.h"
@import CoreMotion;


@implementation CBMenuScene

CMMotionManager * _motionManager;
DSMultilineLabelNode * instructionLabel;
SKLabelNode * levelInfoLabel;
CBTiltVisualizer * visualizer;


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
    //TODO make Background Color game values
        
        //long highestBeatenLevel = [[NSUserDefaults standardUserDefaults] integerForKey: @"highestBeatenLevel"];
        //[self setBackgroundColor: [UIColor redColor]];
        SKSpriteNode * menuLogo = [SKSpriteNode spriteNodeWithImageNamed:@"MenuLogo"];
        [self addChild:menuLogo];
        CGPoint logoPosition = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
        [menuLogo setPosition:logoPosition];
        //[menuIcon setPosition:self.position];
        _motionManager = [[CMMotionManager alloc] init];
        
        [self startMonitoringAcceleration];
        NSLog(@"started monitoring");
        [self setUIValues];
        //GameValues * gv = [[GameValues alloc] init];
        

        ;
        
        //[[[LevelValues alloc] init] jsonTest];
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
    
    
    visualizer = [CBTiltVisualizer tiltVisualizerWithMotionManager:_motionManager];
    [visualizer setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height/2))];
    [self addChild:visualizer];
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //[self.gameDelegate returnToParentMenu];
    
    [self.gameDelegate launchGameScreen];
    NSLog(@"touchesEnded in CBMenuScene");
}


-(void)setLevelNumber:(int)number{
    [[NSUserDefaults standardUserDefaults] setInteger:number forKey: @"currentLevel"];
    NSString * levelString = [NSString stringWithFormat:@"Tap Screen to Start\n Current Level: %d", number];
    instructionLabel.text = levelString;
    
}



-(void)updateInstructionLabel{
    long currentLevel = [[NSUserDefaults standardUserDefaults] integerForKey: @"currentLevel"];
    NSString * levelString = [NSString stringWithFormat:@"Tap Screen to Start\n Current Level: %ld", currentLevel];
    
    instructionLabel.text = levelString;
}



-(void)startMonitoringAcceleration{
    
    NSLog(@"Starting to monitor in method");
    if(_motionManager.accelerometerAvailable){
        [_motionManager startAccelerometerUpdates];
        //NSLog(@"accelerometer updates on...");
    }
    else{
        //NSLog(@"motionManager.accelerometerAvailable is false");
    }
}

-(void)update:(NSTimeInterval)currentTime{
    [visualizer update];
    //CMAccelerometerData* data = _motionManager.accelerometerData;
    //NSLog(@"menu data.acceleration.x = %f, menu data.acceleration.y = %f, menu data.acceleration.z = %f",data.acceleration.x, data.acceleration.y, data.acceleration.z);
}


-(void)returnToParentMenu {
    //[self removeFromParent];
    [self.gameDelegate returnToParentMenu];
    
}

-(void)pause {
    NSLog(@"Pause called on CBMenuScene,  RETHINK THIS");
}



-(void)executeButtonFunction:(NSString *)function{
    if([function isEqualToString:@"Previous\nLevel"]){
        [self previousLevel];
    } else if ([function isEqualToString:@"Next\nLevel"]){
        [self nextLevel];
    } else if([function isEqualToString:@"Tutorial"]){
        [self.gameDelegate launchInstructionScreen];
        NSLog(@"[self launchInstructionScene]");
    } else if([function isEqualToString:@"Start/nGame"]){
        [[NSUserDefaults standardUserDefaults] setInteger:20 forKey:@"highestBeatenLevel"];
    }
    
    NSLog(@"executeButtonFunction Called in CBMenuScene.m,: %@",function);
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
