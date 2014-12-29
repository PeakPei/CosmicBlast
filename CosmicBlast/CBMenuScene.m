//
//  CBMenuScene.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 12/26/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import "CBMenuScene.h"

@implementation CBMenuScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        
        [self setBackgroundColor: [UIColor redColor]];
        
        
        
        //add buttons here
        
        
        
        NSLog(@"Size: %@", NSStringFromCGSize(size));
    }
    return self;
    
    
};

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"TOUCHES ENDED");
    [self.viewController presentGameScreen];
}



    
        
        
        
@end
