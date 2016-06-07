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
#define totalKillsFile @totalKillsFile.plist

+(id)stats{
    CBStats * newStats = [[CBStats alloc] init];
    
    //Use this method to load stats from disk
    [newStats setKills: 0];
    if([newStats totalKills] == nil){
        [newStats setTotalKills:[NSNumber numberWithInt:0]];
    NSLog(@"retrieving total kills; value: %@",[newStats totalKills]);
    }
    return newStats;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:[self totalKills] forKey:totalKillsKey];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if((self = [self init]))
    {
        [self setTotalKills: [aDecoder decodeObjectForKey:totalKillsKey]];
//        [self setKills: 0];
    }
    return self;
}

-(void)saveData{
    //IMPLEMENT
}

-(void)deleteData{
    //IMPLEMENT
}

-(BOOL)createDataPath{
    if ([self docPath] == nil)
    {
        _docPath = [CBDatabase totalKillsDocPath];
    }
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:[self docPath] withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success)
    {
        NSLog(@"Error creating data path: %@", [error localizedDescription]);
    }
    NSLog(@"creatingDataPath %@",[self docPath]);
    return success;
}


- (NSNumber *)totalKills{
    //Wondering about recursive structure here
    
    if (_totalKills != nil)  {
        return _totalKills;
    }
    else{
        
        NSInteger totalKillsInteger = [[NSUserDefaults standardUserDefaults] integerForKey: @"totalKills"];
        
        NSNumber * totalKills = [NSNumber numberWithInteger:totalKillsInteger];
        _totalKills = totalKills;
    
        return _totalKills;
    }
    
}




-(void)saveTotalKills{
    NSLog(@"saveTotalKills called");
    if([self totalKills] == nil) {
        NSLog(@"total kills is nil");
        return;
    }
    
    int intTotalKills = [[self totalKills] intValue];
    [[NSUserDefaults standardUserDefaults] setInteger: intTotalKills forKey: @"totalKills"];

    
}



- (void)deleteDoc {
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:_docPath error:&error];
    if (!success) {
        NSLog(@"Error removing document path: %@", error.localizedDescription);
    }
    
}

-(void)killDidHappen{
    int newKillsInt = [self.kills intValue]+1;
    int newTotalKillsInt = [self.totalKills intValue]+1;
    
    [self setKills:[NSNumber numberWithInt:newKillsInt]];
    [self setTotalKills:[NSNumber numberWithInt:newTotalKillsInt]];
}









@end
