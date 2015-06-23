//
//  CBButtonHandler.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 6/9/15.
//  Copyright (c) 2015 Teddy Kitchen. All rights reserved.
//

#import "CBButtonHandler.h"


@implementation CBButtonHandler


+(instancetype)buttonHandler
{
    CBButtonHandler * handler = [[CBButtonHandler alloc] init];
    handler.buttonMap = [[NSMutableDictionary alloc] init];
    return handler;
}

+(NSString *)getFarLeftButtonName
{
    return @"FarLeftButton";
}


+(NSString *)getLeftButtonName
{
    return @"LeftButton";
}


+(NSString *)getRightButtonName
{
    return @"RightButton";
}


+(NSString *)getFarRightButtonName
{
    return @"FarRightButton";
}


+(NSString *)pauseTaskName
{
    return @"Pause";
}



-(void)handleButton:(CBButton *)button
{
    
    //NOT WORKING
    
    NSString * task = [self.buttonMap objectForKey:button.title];
    
    if (self.buttonMap == nil) {
        NSLog(@"self.buttonMap == nil");
    }else{
        NSLog(@"AAYYYY %@", task);
    }
                       
    [self executeTaskWithButton:button task:task];

}



-(void)executeTaskWithButton:(CBButton *)button task:(NSString *)taskName
{
    
    if (taskName == [CBButtonHandler pauseTaskName])
    {
        [button pause];
    }
}


-(void)mapButton:(CBButton *)button toTask:(NSString *)taskName
{
    [self.buttonMap setObject:taskName forKey:button];
    
    
    
    
    
}




@end
