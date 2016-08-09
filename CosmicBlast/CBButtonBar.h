//
//  CBButtonBar.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 9/8/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CBButtonDelegate.h"
@interface CBButtonBar : SKSpriteNode


@property (nonatomic) NSArray * buttons;




+(id)buttonBarWithFrame:(CGRect)frame buttonDelegate:(id <CBButtonDelegate>)delegate;

//+(id)buttonBarWithSize:(CGSize)size buttonDelegate:(id <CBButtonDelegate>)delegate;

@end
