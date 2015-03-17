//
//  CBLogger.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 3/16/15.
//  Copyright (c) 2015 Teddy Kitchen. All rights reserved.
//

#import "CBLogger.h"

@implementation CBLogger

static bool verbose = YES;

+(id)createLogger{
    
    
    
    CBLogger * logger = [[CBLogger alloc] init];
    
    
    
    
    return logger;
}

//For now just log out the String
+(void)logData:(NSString *)data :(NSString*)dataSource{
    
    if (verbose) {
        NSLog(@"Data Source:\n");
        NSLog(@"%@",dataSource);
        NSLog(@"\n\n");
    }
    
    NSLog(@"collisions:\n");
    NSLog(@"%@",data);
    NSLog(@"\n\n");
    

}


@end
