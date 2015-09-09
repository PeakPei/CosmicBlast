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
        
        
        

        
        
        
        
        [self setBackgroundColor: [UIColor redColor]];
        
        
        
        
        //add buttons here
        
        
        NSString *toLog = [NSString stringWithFormat: @"%@ %@", @"Size: %@", NSStringFromCGSize(size)];
    
        [CBLogger logData:toLog :@"CBMenuScene on Init"];
        
        
        
        
        
    }
    return self;
    
    
};

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    
    
    
    
    //[self.viewController presentGameScreen];
}



    
        
        
        
@end
