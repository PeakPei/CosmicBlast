//
//  CBStats.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/10/15.
//  Copyright (c) 2015 Teddy Kitchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>



@interface CBStats : NSObject <NSCoding>

@property (nonatomic) NSNumber * kills;
@property (nonatomic) NSNumber * totalKills;


//@property (nonatomic) UIColor * backgroundColor;
//@property (nonatomic) int playerMaxHealth;





@property NSString *docPath;

+(id)stats;

-(void)encodeWithCoder:(NSCoder *)aCoder;

-(id)initWithCoder:(NSCoder *)aDecoder;

-(void)killDidHappen;

-(void)saveTotalKills;


-(void)deleteData;







@end
