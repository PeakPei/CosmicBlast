//
//  CBShuriken.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 9/10/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBItem.h"
#import <CosmicBlast-Swift.h>

@interface CBShuriken : CBItem


+(id)shurikenWithImageNamed:(NSString *)name;

+(id)shuriken;

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;


@end
