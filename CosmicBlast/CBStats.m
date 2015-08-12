//
//  CBStats.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/10/15.
//  Copyright (c) 2015 Teddy Kitchen. All rights reserved.
//

#import "CBStats.h"
@implementation CBStats
//#import "CBDatabase.h"
#define totalKillsKey @"totalKills"


+(id)stats
{
    
    
    
    CBStats * newStats = [[CBStats alloc] init];
                          
    [newStats setKills: 0];
    [newStats setTotalKills: 0];
    
    return newStats;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:[self totalKills] forKey:totalKillsKey];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [self init]))
    {
        [self setTotalKills: [aDecoder decodeIntForKey:totalKillsKey]];
        [self setKills: 0];
    }
    return self;
}

-(void)killDidHappen
{
    self.kills += 1;
    self.totalKills += 1;
}


@end
