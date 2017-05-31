//
//  CBTiltVisualizer.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 11/23/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CBTiltManager.h"

@interface CBTiltVisualizer : SKNode

@property CBTiltManager * tiltManager;


+(instancetype)tiltVisualizerWithTiltManager:(CBTiltManager *)manager;


-(void)update;



@end
