//
//  CBWalker.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 9/4/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBWalker.h"

@implementation CBWalker


//creates a walker sprite with an image name
+(id)walkerWithImageNamed:(NSString *)name{
    
    CBWalker * walker = [CBWalker spriteNodeWithImageNamed:name];
    
    return walker;
    
}


-(void)handleMovement{
    
    
    
}



@end
