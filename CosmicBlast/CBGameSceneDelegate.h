//
//  CBGameSceneDelegate.h
//  CosmicBlast
//
//  Created by Teddy Kitchen on 6/3/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

@protocol CBGameSceneDelegate <NSObject>

-(void)launchMenuScreen;
-(void)launchGameScreen;
-(void)launchInstructionScreen;
-(void)launchSettingsScreen;
-(void)launchTutorialScreenNumber:(int)i;

-(void)returnToParentMenu;





@end
