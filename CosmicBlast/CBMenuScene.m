//
//  CBMenuScene.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 12/26/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBMenuScene.h"
#import "CBLogger.h"
@import CoreMotion;


@implementation CBMenuScene

CMMotionManager * _motionManager;
SKLabelNode * instructionLabel;
SKLabelNode * levelInfoLabel;



-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
    //TODO make Background Color game values
        
        //long highestBeatenLevel = [[NSUserDefaults standardUserDefaults] integerForKey: @"highestBeatenLevel"];
        [self setBackgroundColor: [UIColor redColor]];
        
        _motionManager = [[CMMotionManager alloc] init];
        
        [self startMonitoringAcceleration];
        NSLog(@"started monitoring");
        [self setUIValues];

        
    }
    return self;
};


-(void)setUIValues {
    //set up label
    NSLog(@"SetUIValuesCalled in CBMenuScene");
    
    instructionLabel = [SKLabelNode labelNodeWithText:@"tap the screen to start"];
    [instructionLabel setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height/2))];
    [self addChild:instructionLabel];
    
    long currentLevel = [[NSUserDefaults standardUserDefaults] integerForKey: @"currentLevel"];
    NSString * levelString = [NSString stringWithFormat:@"Current Level: %ld", currentLevel];
    levelInfoLabel = [SKLabelNode labelNodeWithText:levelString];
    [levelInfoLabel setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height/1.5))];
    [self addChild:levelInfoLabel];
    
    //Set up button bar
    self.buttonBar = [CBButtonBar menuButtonBarWithFrame:self.frame buttonDelegate:self];
    [self addChild:self.buttonBar];
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //[self.gameDelegate returnToParentMenu];
    
    [self.gameDelegate launchGameScreen];
    NSLog(@"touchesEnded in CBMenuScene");
}


-(void)setLevelNumber:(int)number{
    //NSInteger currentLevel = [[NSUserDefaults standardUserDefaults] integerForKey: @"currentLevel"];
    [[NSUserDefaults standardUserDefaults] setInteger:number forKey: @"currentLevel"];
    NSString * levelString = [NSString stringWithFormat:@"Current Level: %d", number];
    //levelInfoLabel = [SKLabelNode labelNodeWithText:levelString];
    [levelInfoLabel setText:levelString];
    
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
    if([function isEqualToString:@"<-"]){
        [self previousLevel];
    } else if ([function isEqualToString:@"->"]){
        [self nextLevel];
    } else if([function isEqualToString:@"?"]){
        [self.gameDelegate launchInstructionScreen];
        NSLog(@"[self launchInstructionScene]");
    }
    
    NSLog(@"executeButtonFunction Called in CBMenuScene.m,: %@",function);
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
