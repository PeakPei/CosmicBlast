//
//  CBMenuScene.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 12/26/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBMenuScene.h"
#import "CBLogger.h"

@implementation CBMenuScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
    //TODO make Background Color game values
        [self setBackgroundColor: [UIColor redColor]];
    }
    return self;
};

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"MenuScene touchesEnded");
    [self.gameDelegate launchGameScreen];
}



    
        
        
        
@end
