//
//  CBButton.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 9/8/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CBButton : SKSpriteNode



@property NSString * summary;


+(id)buttonWithColor:(SKColor *)color size:(CGSize)size;

-(void)setButtonPosition:(CGPoint)position;







@end
