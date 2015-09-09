//
//  CBDataBase.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/11/15.
//  Copyright (c) 2015 Teddy Kitchen. All rights reserved.
//

#import "CBDataBase.h"

@implementation CBDatabase
+(NSString *)nextTotalKillsDocPath{
    //Get Private Docs Directory
    NSString *documentsDirectory = [CBDatabase getPrivateDocsDir];
    
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if(files == nil){
        NSLog(@"Error reading contents of documents directory: %@",[error localizedDescription]);
        return nil;
    }
    //search for an available name
    int maxNumber = 0;
    for (NSString *file in files){
        if([file.pathExtension compare:@"totalKills" options:NSCaseInsensitiveSearch] == NSOrderedSame){
            NSString *fileName = [file stringByDeletingPathExtension];
            maxNumber = MAX(maxNumber, fileName.intValue);
        }
    }
    //get available name
    NSString *availableName = [NSString stringWithFormat:@"%d.totalKills", maxNumber+1];
    NSLog(@"NextTotalKillsDocPath %@",[documentsDirectory stringByAppendingPathComponent:availableName]);
    return [documentsDirectory stringByAppendingPathComponent:availableName];

}

+(NSMutableArray *)loadTotalKillDocs{
    NSString *documentsDirectory = [CBDatabase getPrivateDocsDir];
    NSLog(@"Loading totalKills from %@", documentsDirectory);
    
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (files == nil){
        NSLog(@"Error reading contents of total kills directory: %@", [error localizedDescription]);
        return nil;
    }
    NSMutableArray *toReturn = [[NSMutableArray alloc] init];
    //TESTING
    int fileCounter = 0;
    //TESTING
    for (NSString *file in files){
        if ([file.pathExtension compare:@"totalKills" options:NSCaseInsensitiveSearch] == NSOrderedSame){
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            NSData *fileData = [[NSFileManager defaultManager] contentsAtPath:fullPath];
            [toReturn addObject:fileData];
        
        }
        fileCounter++;
    }
    
    
    NSLog(@"fileCounter = %d",fileCounter);
    return toReturn;
}






+(NSString *)getPrivateDocsDir {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    
    NSError * error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    return documentsDirectory;
    
}


@end
