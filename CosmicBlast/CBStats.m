//
//  CBStats.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/10/15.
//  Copyright (c) 2015 Teddy Kitchen. All rights reserved.
//
#import "CBDatabase.h"
#import "CBStats.h"
@implementation CBStats

#define totalKillsKey @"totalKills"
#define saveFile @"saveFile.plist"

+(id)stats
{
    CBStats * newStats = [[CBStats alloc] init];
    
    //Use this method to load stats from disk
    [newStats setKills: 0];
    [newStats setTotalKills: 0];
    
    
    return newStats;
}


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[self totalKills] forKey:totalKillsKey];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [self init]))
    {
        [self setTotalKills: [aDecoder decodeObjectForKey:totalKillsKey]];
        [self setKills: 0];
    }
    return self;
}

-(void)saveData
{
    //IMPLEMENT
}

-(void)deleteData
{
    //IMPLEMENT
}

-(BOOL)createDataPath
{
    if ([self docPath] == nil)
    {
        self.docPath = [CBDatabase nextStatsDocPath];
    }
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:[self docPath] withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success)
    {
        NSLog(@"Error creating data path: %@", [error localizedDescription]);
    }

    return success;
}


- (NSNumber *)totalKills
{
    //Wondering about recursive structure here
    if (self.totalKills != nil)  {return self.totalKills;}
    
    NSString * totalKillsPath = [[self docPath] stringByAppendingPathComponent:saveFile];
    NSData * codedTotalKills = [[NSData alloc] initWithContentsOfFile:totalKillsPath];
    if (codedTotalKills == nil) return nil;
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedTotalKills];
    self.totalKills = [unarchiver decodeObjectForKey:totalKillsKey];
    [unarchiver finishDecoding];
    
    
    return self.totalKills;
}




-(void)killDidHappen
{
    int newKillsInt = [self.kills intValue]+1;
    int newTotalKillsInt = [self.totalKills intValue]+1;
    
    [self setKills:[NSNumber numberWithInt:newKillsInt]];
    [self setTotalKills:[NSNumber numberWithInt:newTotalKillsInt]];
}


@end
