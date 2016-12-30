//
//  CBButtonDelegate.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 6/2/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

@protocol CBButtonDelegate <NSObject>

-(void)executeButtonFunction:(NSString *)function;

-(void)buttonReleased:(NSString *)function;


@end
