//
//  CBButtonHandler.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 6/9/15.
//  Copyright (c) 2015 Teddy Kitchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBButton.h"



@class CBButton;



@interface CBButtonHandler : NSObject

@property NSMutableDictionary * buttonMap;

+(instancetype)buttonHandler;


+(NSString *)getFarLeftButtonName;
+(NSString *)getLeftButtonName;
+(NSString *)getRightButtonName;
+(NSString *)getFarRightButtonName;

+(NSString *)pauseTaskName;


-(void)handleButton:(CBButton *)button;

-(void)executeTaskWithButton:(CBButton *)button task:(NSString *)taskName;

-(void)mapButton:(CBButton *)button toTask:(NSString *)taskName;





@end
