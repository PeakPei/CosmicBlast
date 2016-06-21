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

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
    //TODO make Background Color game values
        [self setBackgroundColor: [UIColor redColor]];
        
        _motionManager = [[CMMotionManager alloc] init];
        
        [self startMonitoringAcceleration];
        NSLog(@"started monitoring");
        
        SKLabelNode * label  = [SKLabelNode labelNodeWithText:@"tap the screen to start"];
        
//        CGPoint centerPoint = CGPointMake(self.frame.origin.x , self.frame.origin.y);

//        label setPosition:[self poin]
        [label setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height/2))];
        [self addChild:label];
//        [label setPosition:centerPoint];
        
    }
    return self;
};

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.gameDelegate launchGameScreen];
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


        
        
@end
