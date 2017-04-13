//
//  CBMyScene.m
//  CosmicBlast
//
//  Created by Teddy Kitchen on 7/23/14.
//  Copyright (c) 2014 Teddy Kitchen. All rights reserved.
//

@import CoreMotion;

#import "CBMyScene.h"
#import "CBEnemy.h"
#import "CBPlayer.h"
#import "CBEnemyUnit.h"
#import "CBVectorMath.h"
#import "CBMenuScene.h"
#import "CBShuriken.h"
#import "CBTiltVisualizer.h"
#import "CBWall.h"
#import "CBTrap.h"
#import <CosmicBlast-Swift.h>

static const uint32_t projectileCategory = 0x1 << 0;
static const uint32_t monsterCategory = 0x1 << 1;
static const uint32_t playerCategory = 0x1 << 2;
static const uint32_t edgeCategory = 0x1 << 3;
static const uint32_t enemyUnitCategory = 0x1 << 4;
static const uint32_t wallCategory = 0x1 << 5;
static const uint32_t trapCategory = 0x1 << 6;

@implementation CBMyScene{
    NSMutableArray * wallPositions;
    NSMutableArray * trapPositions;
    NSMutableArray * unitDescriptions;
}

CBTiltVisualizer * tiltVisualizer;
CMMotionManager *_motionManager;

+(instancetype)unarchiveFromFile:(NSString *)file withSize:(CGSize)size{
    // get file path for scene that we are using
    NSString * nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@".sks"];
    //Unarchive file to CBMyScene object
    NSData * data = [NSData dataWithContentsOfFile:nodePath options:NSDataReadingMappedIfSafe error:nil];
    NSKeyedUnarchiver * arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:CBMyScene.class forClassName:@"SKScene"];
    CBMyScene * dummyScene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [dummyScene setSize:size];
    [arch finishDecoding];
    CBMyScene * myScene = [CBMyScene sceneWithSize:size];
    myScene->wallPositions = [[NSMutableArray alloc] init];
    myScene->trapPositions = [[NSMutableArray alloc] init];
    myScene->unitDescriptions = [[NSMutableArray alloc] init];
    
    for (SKSpriteNode * child in dummyScene.children) {
        [myScene handleDummyChild:child];
//        if ([child.name isEqualToString:@"wall"]){
//            NSLog(@"wall position =( %f, %f )",child.position.x,child.position.y);
//            [myScene->wallPositions addObject:[NSValue valueWithCGPoint:child.position]];
//        } else if([child.name isEqualToString:@"trap"]){
//            
//            NSLog(@"trap position =( %f, %f )",child.position.x,child.position.y);
//            
//            
//            
//            [myScene->trapPositions addObject:[NSValue valueWithCGPoint:child.position]];
//            NSLog(@"trapPositions.count =  %f ",myScene->trapPositions.count);
//            
//            
//        } else if([child.name isEqualToString:@"unit"]){
//            CGPoint position = child.position;
//            //int movement = [child.userData valueForKey:@"movement"];
//            int attack = [[child.userData valueForKey:@"attack"] intValue];
//            NSLog(@"attack = %d", attack);
//            int movement = [[child.userData valueForKey:@"movement"] intValue];
//            NSLog(@"movement = %d", movement);
//            struct UnitDescription description;
//            description.attack = attack;
//            description.movement = movement;
//            description.position = position;
//            NSValue * value = [NSValue valueWithBytes:&description objCType:@encode(struct UnitDescription)];
//            //NSValue * value = [NSValue valueWithPointer:&description];
//            [myScene->unitDescriptions addObject:value];
//            NSLog(@"myScene->unitDescriptions.count (in loop) = %d", (int)myScene->unitDescriptions.count);
//            
//            NSLog(@"child Name is equal to unit.  struct value added to dictionary");
//        } else {
//            NSLog(@"child Name unknown");
//        }
    
    }
    NSLog(@"myScene->unitDescriptions.count (out loop) = %d", (int)myScene->unitDescriptions.count);
    [myScene prepareForDisplay];
    return myScene;
}



-(void)handleDummyChild:(SKSpriteNode *)child {
    if (child.children.count>0) {
        for(SKSpriteNode * subChild in child.children) {
            subChild.position = [CBVectorMath cbVectorAddFirst:child.position Second:subChild.position];
            [self handleDummyChild: subChild];
        }
    } else if ([child.name isEqualToString:@"wall"]){
        NSLog(@"wall position =( %f, %f )",child.position.x,child.position.y);
        [self->wallPositions addObject:[NSValue valueWithCGPoint:child.position]];
    } else if([child.name isEqualToString:@"trap"]){
        
        [self->trapPositions addObject:[NSValue valueWithCGPoint:child.position]];
        
        
    } else if([child.name isEqualToString:@"unit"]){
        CGPoint position = child.position;
        int attack = [[child.userData valueForKey:@"attack"] intValue];
        int movement = [[child.userData valueForKey:@"movement"] intValue];
        struct UnitDescription description;
        description.attack = attack;
        description.movement = movement;
        description.position = position;
        NSValue * value = [NSValue valueWithBytes:&description objCType:@encode(struct UnitDescription)];
        //NSValue * value = [NSValue valueWithPointer:&description];
        [self->unitDescriptions addObject:value];
        NSLog(@"myScene->unitDescriptions.count (in loop) = %d", (int)self->unitDescriptions.count);
        
        NSLog(@"child Name is equal to unit.  struct value added to dictionary");
    } else {
        NSLog(@"child Name unknown");
    }
}

-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        NSLog(@"InitWithSizeCalled on CBMYScene");
        
    }
    return self;
}




-(void)prepareForDisplay {
    NSLog(@"PREPARE FOR DISPLAY IN CBMyScene");
    
    [self setWorldValues];
    [self setPlayerValues];
    [self setObstacleValues];
    [self setPhysicsValues];
    [self setUIValues];
    [self setEnemyValues];
}


-(void)setPlayerValues {
//    GameValues *gameValues = [[GameValues alloc] init];
    self.player = [CBPlayer player];
    [self.currentWorld addChild: self.player];
    //Set up Statistics collecting object
    [self setStats:[CBStats stats]];
}


-(void)setWorldValues {
    GameValues *gameValues = [[GameValues alloc] init];
    self.backgroundColor = [gameValues backgroundColor];
    //self.currentWorld = [CBWorld worldWithImageNamed:@"Background" position:CGPointZero];
    //self.currentWorld.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.currentWorld = [CBWorld world];
    NSLog(@"about to add the world as a child");
    [self addChild: self.currentWorld];
}


-(void)setObstacleValues {
    for (NSValue * pointValue in self->wallPositions){
        CBWall * wall = [CBWall wall];
        CGPoint wallPosition = [pointValue CGPointValue];
        [wall setPosition:wallPosition];
        //wall.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:wall.size.width/2];
        wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
        
        wall.physicsBody.restitution = 1;
        wall.physicsBody.dynamic = NO;
        wall.physicsBody.categoryBitMask = wallCategory;
        wall.physicsBody.collisionBitMask = playerCategory | projectileCategory | enemyUnitCategory | monsterCategory;
        wall.physicsBody.usesPreciseCollisionDetection = NO;
        
        [self.currentWorld addChild:wall];
        
        [self.walls addObject:wall];
        
    }
    for (NSValue * pointValue in self->trapPositions){
        CBTrap * trap = [CBTrap trap];
        CGPoint trapPosition = [pointValue CGPointValue];
        [trap setPosition:trapPosition];
        trap.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:trap.size.width/2];
        trap.physicsBody.restitution = 15;
        trap.physicsBody.dynamic = NO;
        trap.physicsBody.categoryBitMask = trapCategory;
        trap.physicsBody.contactTestBitMask = playerCategory;
        trap.physicsBody.collisionBitMask = enemyUnitCategory | monsterCategory | playerCategory;
        trap.physicsBody.usesPreciseCollisionDetection = NO;
        
        [self.currentWorld addChild:trap];
        
        [self.traps addObject:trap];
        
    }
    
}

-(void)setPhysicsValues {
    GameValues * gameValues = [[GameValues alloc] init];
    
    //physics body for player
    
    //self.player.physicsBody = [SKPhysicsBody bodyWithTexture: self.player.texture alphaThreshold: 0.1 size:self.player.size];
    self.player.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.player.size.width/2];
    //self.player.physicsBody.
    
    
    //[SKPhysicsBody bodyWithCircleOfRadius:self.player.size.height/2];
    //self.player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.player.frame.size];
    self.player.physicsBody.mass = 0.05;
    self.player.physicsBody.dynamic = YES;
    self.player.physicsBody.categoryBitMask = playerCategory;
    self.player.physicsBody.contactTestBitMask = monsterCategory | trapCategory;
    self.player.physicsBody.collisionBitMask = enemyUnitCategory | edgeCategory | monsterCategory | wallCategory | trapCategory;
    self.player.physicsBody.usesPreciseCollisionDetection = NO;
    self.player.physicsBody.restitution = 0;
    self.player.physicsBody.linearDamping = 3;
    self.player.physicsBody.allowsRotation = NO;
    
    if([[gameValues worldShape]  isEqual: @"circle"]){
        //Uncomment for circular level
        UIBezierPath * circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:self.currentWorld.frame.size.width/2 startAngle:0 endAngle:M_PI*2 clockwise:false];
        self.currentWorld.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:circlePath.CGPath];
    } else if ([[gameValues worldShape]  isEqual: @"square"]){
        self.currentWorld.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.currentWorld.frame];
    } else {
        NSLog(@"ERROR: no shape recognized for world physics body");
    }
    
    
    

    
    self.currentWorld.physicsBody.dynamic = NO;
    self.currentWorld.physicsBody.categoryBitMask = edgeCategory;
    self.currentWorld.physicsBody.contactTestBitMask = projectileCategory;
    self.currentWorld.physicsBody.collisionBitMask = 0;
    
    
    self.units = [[NSMutableArray alloc] init];
    self.walls = [[NSMutableArray alloc] init];
    self.traps = [[NSMutableArray alloc] init];
    _motionManager = [[CMMotionManager alloc] init];
    [self startMonitoringAcceleration];
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
    
}

-(void)setUIValues {
    //Set up button bar
    self.buttonBar = [CBButtonBar gameButtonBarWithFrame:self.frame buttonDelegate:self];
    NSLog(@"self.frame.width = %f self.frame.height = %f",self.frame.size.width,self.frame.size.height);
    [self addChild:self.buttonBar];
    

    
    //Set up health bar
    self.healthBar = [CBHealthBar healthBarWithFrame:self.frame player:self.player];
    [self addChild:self.healthBar];
    
    
    
    tiltVisualizer = [CBTiltVisualizer tiltVisualizerWithMotionManager:_motionManager];
    [tiltVisualizer setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height/2))];
    [self addChild:tiltVisualizer];
    
}

-(void)setEnemyValues {
    
    //locations and behaviors should be of the same length
    NSLog(@"self->unitDescriptions.count = %d", (int)self->unitDescriptions.count);
    for (NSValue * description in self->unitDescriptions){
        struct UnitDescription structValue;
        [description getValue:&structValue];
        NSLog(@"structValue.Attack = %d",structValue.attack);
        CBEnemyUnit * newUnit = [self placeUnitAtPosition:structValue.position];
        [newUnit setUnitMovementBehavior:structValue.movement];
        [newUnit setUnitAttackBehavior:structValue.attack];
    }
    
//    
//    for (int i = 0; i < locationArray.count; i++){
//        NSValue * point = locationArray[i];
//        NSValue * behaviorPair = behaviorArray[i];
//        CBEnemyUnit * newUnit = [self placeUnitAtPosition:[point CGPointValue]];
//        [newUnit setUnitMovementBehavior:[behaviorPair CGPointValue].x];
//        [newUnit setUnitAttackBehavior:[behaviorPair CGPointValue].y];
//    }
//    for (NSValue * point in array){
//        CBEnemyUnit * newUnit = [self placeUnitAtPosition:[point CGPointValue]];
//        [newUnit setUnitMovementBehavior:BehaviorType_None];
//    }
    
}





-(void)startMonitoringAcceleration{
    
    
    if(_motionManager.accelerometerAvailable){
        [_motionManager startAccelerometerUpdates];
        //NSLog(@"accelerometer updates on...");
    }
    else{
        //NSLog(@"motionManager.accelerometerAvailable is false");
    }
}




-(void)updatePositionFromMotionManager{
    [tiltVisualizer update];
    CMAccelerometerData* data = _motionManager.accelerometerData;
    int speed = 0;
    GameValues * gameValues = [[GameValues alloc] init];
    CMAcceleration zeroAcceleration = [gameValues accelerometerZero];
//    CMAcceleration adjustedAcceleration = [CMAccelerometerData init];
    double zeroX = zeroAcceleration.x;
    double zeroY = zeroAcceleration.y;
//    double zeroZ = zeroAcceleration.z;
    [self.player movePlayerWithAccelerationXvalue:(data.acceleration.x-zeroX) yValue:(data.acceleration.y-zeroY) speed:speed];
    
    //NSLog(@"data.acceleration.x = %f, data.acceleration.y = %f",data.acceleration.x, data.acceleration.y);
    
    
}




//Fix hardcoding.  need to figur out world configuration
-(CBEnemyUnit *)placeUnitAtPosition:(CGPoint)position{
    CBEnemyUnit * unit = [CBEnemyUnit enemyUnit];
    
    [unit setPosition:position];
    unit.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:unit.size.width/2];
    //unit.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:unit.size.height];
    unit.physicsBody.dynamic = YES;
    unit.physicsBody.mass = 0.05;
    //unit.physicsBody.linearDamping = 0;
    unit.physicsBody.categoryBitMask = enemyUnitCategory;
    unit.physicsBody.contactTestBitMask = projectileCategory;
    unit.physicsBody.collisionBitMask = playerCategory | projectileCategory | edgeCategory | enemyUnitCategory | wallCategory;
    unit.physicsBody.usesPreciseCollisionDetection = NO;
    
    [self.currentWorld addChild:unit];
    [self.units addObject:unit];
    return unit;
}


//NOT CURRENTLY BEING USED
-(void)moveUnit:(CBEnemyUnit *)unit {
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    
    //Create the actions
    
    int randx = arc4random_uniform(self.currentWorld.size.width)-self.currentWorld.size.width/2;
    int randy = arc4random_uniform(self.currentWorld.size.height)-self.currentWorld.size.height/2;
    [self removeAllActions];
    SKAction * actionMove = [SKAction moveTo:CGPointMake(randx,randy) duration:actualDuration];
    
//    SKAction * actionMoveDone = [SKAction  ];
    
    [unit runAction:actionMove];
}



-(void)updateWithTimeSinceLastUpdate: (CFTimeInterval) timeSinceLast{
    
    
    //Need to update how enemies behave here
    for (CBEnemyUnit *unit in self.units) {
        [unit updateWithPlayerPosition:self.player.position timeSinceLastUpdate:timeSinceLast];
        CBWalker * shot = [unit maybeAttack];
        if (shot==nil) {
            //NSLog(@"SHOT IS NIL");
            
            //DO NOTHING IF SHOT IS NIL
            
        } else {
            shot.physicsBody.categoryBitMask = monsterCategory;
            shot.physicsBody.contactTestBitMask = projectileCategory;
            shot.physicsBody.collisionBitMask = wallCategory | playerCategory | edgeCategory;
            shot.physicsBody.mass = 0.008;
            [self.currentWorld addChild:shot];
        }

    }
    
//    self.lastSpawnTimeInterval += timeSinceLast;
//    if (self.lastSpawnTimeInterval > 0.5) {
//        self.lastSpawnTimeInterval = 0;
//        
//        //uncomment to enable monsters
//        [self addMonster];
//    }
    [self updatePositionFromMotionManager];
    
    
}

-(void)update:(NSTimeInterval)currentTime {
    // Handle time delta.
    // If we drop below 60fps, we still want everything to move the same distance.
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
        
        
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    
}



-(void)didBeginContact:(SKPhysicsContact *)contact{
    SKPhysicsBody *firstBody, *secondBody;
    
    // make sure that first body is smaller or equal to secondBody
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else{
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    
    //monster hit by projectile
    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&(secondBody.categoryBitMask & monsterCategory) != 0){
        [self projectile:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
        [self.stats killDidHappen];
    }
    
    //unit hit by projectile
    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&(secondBody.categoryBitMask & enemyUnitCategory) != 0){
        //if ([secondBody isKindOfClass:[CBEnemyUnit class]]){
                [self projectile:(SKSpriteNode *) firstBody.node didCollideWithEnemyUnit:(CBEnemyUnit*) secondBody.node];
        //}
    }
    
    if ((firstBody.categoryBitMask & playerCategory) != 0 &&(secondBody.categoryBitMask & trapCategory) != 0){

        [self.player playerHit];
        [self.healthBar updateHealthBar];
        //NSLog(@"player hit by enemy!!!");
        
        if (self.player.dead) {
            
            [self returnToParentMenu];
            
        }
    }
    
    //Player hit by monster
    if((firstBody.categoryBitMask & monsterCategory) != 0){
    
        [self.player playerHit];
        [self.healthBar updateHealthBar];
        //NSLog(@"player hit by enemy!!!");
        
        if (self.player.dead) {
            
            [self returnToParentMenu];
            
        }
    }
}


-(void)returnToParentMenu {
    if (self.view.paused){
        [self pause];
    }
    [self.gameDelegate launchMenuScreen];
//    SKView * skView = (SKView *)self.view;
//    SKScene * menuScene = [CBMenuScene sceneWithSize:skView.bounds.size];
//    menuScene.scaleMode = SKSceneScaleModeAspectFill;
//    [skView presentScene:menuScene];
    [self.stats saveTotalKills];
}

-(void)pause{
    if(self.view.paused)
    {
        self.view.paused = NO;
    }
    else
    {
        self.view.paused = YES;
    }
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //  This is going to need to be changed.  Will need to split behavior of different items up somehow
    //
    GameValues * gameValues = [[GameValues alloc] init];
    
    //  VVV OK UNTIL  VVV
    //chose a touch to work with
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self.currentWorld];
    // ^^^ HERE ^^^^
    
    
    
    //VVV Should be moved to CBShuriken VVV
    //set up initial location
    //SKSpriteNode * projectile = [SKSpriteNode spriteNodeWithImageNamed:@"projectile"];
    if([self.player weaponRecharged]){
        
        
        SKSpriteNode * projectile = [CBShuriken shuriken];
        projectile.position = self.player.position;
        projectile.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:projectile.size.width/2];
        projectile.physicsBody.mass = 0.008;
        projectile.physicsBody.dynamic = YES;
        projectile.physicsBody.usesPreciseCollisionDetection = NO;
        projectile.physicsBody.restitution = 1;
        projectile.physicsBody.friction = 0;
    
    

        projectile.physicsBody.categoryBitMask = projectileCategory;
        projectile.physicsBody.contactTestBitMask = monsterCategory;
        projectile.physicsBody.collisionBitMask = enemyUnitCategory | wallCategory | edgeCategory;

    
    
    
    
        //configure offset
        CGPoint offset = [CBVectorMath cbVectorSubFirst:location Second:projectile.position];
    
    
    
        //Add the projectile
        [self.currentWorld addChild:projectile];
    
        //Get shooting direction
        CGPoint direction = [CBVectorMath cbVectorNormalize:offset];

    
        //Create shot vector
        CGPoint shotPoint = [CBVectorMath cbVectorMultFirst:direction Value:[gameValues playerShotSpeed]];
        CGVector shotVector = CGVectorMake(shotPoint.x, shotPoint.y);
    
        //projectile.physicsBody.velocity = shotVector;
        projectile.physicsBody.velocity = [CBVectorMath vectorAddFirst:shotVector second:self.player.physicsBody.velocity];
        //Add shot vector to current position
    
    
    
        //Create actions

    
    
        //SKAction * actionMove = [SKAction moveTo:realDest duration: realMoveDuration];
    
        SKAction * actionWait = [SKAction waitForDuration:1];
    
        SKAction * actionMoveDone = [SKAction removeFromParent];
    
    
    
        [projectile runAction:[SKAction sequence:@[actionWait, actionMoveDone]]];
    
        //^^^ end add to CBShuriken
    }
}




-(void)projectile:(SKSpriteNode *)projectile didCollideWithMonster:(SKSpriteNode *)monster {
    [projectile removeFromParent];
    [monster removeFromParent];
}

-(void)projectile:(SKSpriteNode *)projectile didCollideWithEnemyUnit:(CBEnemyUnit *)unit {
    //[projectile removeFromParent];
    [unit unitHit];
    //[self moveUnit:unit];
    
    if(unit.dead){
        NSLog(@"unitDead");
        [unit removeFromParent];
        [self.units removeObject:unit];
    }
    if (self.units.count == 0) {
        SKLabelNode * instructionLabel1 = [SKLabelNode labelNodeWithText:@"You Win!"];
        SKLabelNode * instructionLabel2 = [SKLabelNode labelNodeWithText:@"Press Green to Return"];
        [instructionLabel1 setFontColor:[UIColor purpleColor]];
        [instructionLabel2 setFontColor:[UIColor purpleColor]];
        [instructionLabel1 setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height*0.66))];
        [instructionLabel2 setPosition:CGPointMake((self.frame.size.width/2), (self.frame.size.height*0.33))];
        [instructionLabel1 setFontName:@"Arial"];
        [instructionLabel2 setFontName:@"Arial"];
        [self addChild:instructionLabel1];
        [self addChild:instructionLabel2];
        long currentLevel = [[NSUserDefaults standardUserDefaults] integerForKey: @"currentLevel"];
        long highestBeatenLevel = [[NSUserDefaults standardUserDefaults] integerForKey: @"highestBeatenLevel"];
        if (currentLevel > highestBeatenLevel) {
            [[NSUserDefaults standardUserDefaults] setInteger:currentLevel forKey:@"highestBeatenLevel"];
        }
        
        if( currentLevel < [[NSUserDefaults standardUserDefaults] integerForKey:@"availableLevels"]){
            currentLevel += 1;
            [[NSUserDefaults standardUserDefaults] setInteger:(currentLevel) forKey:@"currentLevel"];
        }
        
        
        
        
    }
}




-(void)executeButtonFunction:(NSString *)function{
    
    
    if([function isEqualToString:@"menu"]){
        [self returnToParentMenu];
    } else if ([function isEqualToString:@"pause"]){
        [self pause];
    } else if ([function isEqualToString:@"break"]){
        [self.player startBreaking];
    }
    NSLog(@"executeButtonFunction Called in CBMyScene.m,: %@",function);
}


-(void)buttonReleased:(NSString *)function{
    
    
    if([function isEqualToString:@"menu"]){
        [self returnToParentMenu];
    } else if ([function isEqualToString:@"pause"]){
        [self pause];
    } else if ([function isEqualToString:@"break"]){
        [self.player endBreaking];
    }
    NSLog(@"executeButtonFunction Called in CBMyScene.m,: %@",function);
}

struct UnitDescription{
    CGPoint position;
    int movement;
    int attack;
};


@end
