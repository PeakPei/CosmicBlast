//
//  CBLogger.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 3/16/15.
//  Copyright (c) 2015 Teddy Kitchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBLogger : NSObject


+(id)createLogger;



+(void)logData:(NSString*)data :(NSString*)dataSource;

@property BOOL verbose;

@end