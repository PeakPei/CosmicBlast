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
#import "CBEnemyFactory.h"
#import "CBButtonBar.h"
#import "CBVectorMath.h"
#import "CBMenuScene.h"
#import "CBShuriken.h"
#import <CosmicBlast-Swift.h>

static const uint32_t projectileCategory = 0x1 << 0;
static const uint32_t monsterCategory = 0x1 << 1;
static const uint32_t playerCategory = 0x1 << 2;
static const uint32_t edgeCategory = 0x1 << 3;
static const uint32_t enemyFactoryCategory = 0x1 << 4;


@implementation CBMyScene

CMMotionManager *_motionManager;

-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        
        
        
        //Initialize word
        GameValues *gameValues = [[GameValues alloc] init];
        self.backgroundColor = [gameValues backgroundColor];
        //self.currentWorld = [CBWorld worldWithImageNamed:@"Background" position:CGPointZero];
        //self.currentWorld.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        self.currentWorld = [CBWorld world];
        [self addChild: self.currentWorld];
        
        
        //Initialize player
        //self.player = [CBPlayer playerWithImageNamed:@"player"];
        self.player = [CBPlayer playerWithColor:[gameValues playerColor] size:[gameValues playerSize]];
        [self.currentWorld addChild: self.player];
        
        
        //
 
        

        //add physics body for player
        self.player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.player.size];
        self.player.physicsBody.dynamic = YES;
        self.player.physicsBody.categoryBitMask = playerCategory;
        self.player.physicsBody.contactTestBitMask = monsterCategory;
        self.player.physicsBody.collisionBitMask = edgeCategory;
        self.player.physicsBody.usesPreciseCollisionDetection = YES;
        
        
        //add physics body for currentWorld
       //CGRect  adjustedWorld = CGRectMake(self.currentWorld.frame.origin.x - (self.currentWorld.frame.size.width/2.0), self.currentWorld.frame.origin.y - (self.currentWorld.frame.size.height/2.0), self.currentWorld.frame.size.width, self.currentWorld.frame.size.height);
        
        //self.currentWorld.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:adjustedWorld];
        
        self.currentWorld.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.currentWorld.frame];
        
        self.currentWorld.physicsBody.dynamic = NO;
        self.currentWorld.physicsBody.categoryBitMask = edgeCategory;
        self.currentWorld.physicsBody.contactTestBitMask = projectileCategory;
        self.currentWorld.physicsBody.collisionBitMask = 0;
        
        

        
        self.factories = [[NSMutableArray alloc] init];
        
        _motionManager = [[CMMotionManager alloc] init];
        [self startMonitoringAcceleration];
        
        
        //Set up Statistics collecting object
        [self setStats:[CBStats stats]];
        
        
        //Set up button bar
        
        NSLog(@"self.frame.width: %f,  self.frame.height: %f",self.frame.size.width, self.frame.size.height);
        
        NSLog(@"self.view.bounds.size.width: %f,  self.view.bounds.size.height: %f",self.view.bounds.size.width, self.view.bounds.size.height);
        
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
       
        NSLog(@"screenSize: %f,  screenSize.height: %f",screenSize.width, screenSize.height);
        //self.buttonBar = [CBButtonBar buttonBarWithSize:screenSize buttonDelegate:self];
        self.buttonBar = [CBButtonBar buttonBarWithFrame:self.frame buttonDelegate:self];
        [self addChild:self.buttonBar];
        
        
        //Set up health bar
        self.healthBar = [CBHealthBar healthBarWithFrame:self.frame player:self.player];
        [self addChild:self.healthBar];
        
        
         
        
        
        //set up factories        
        //Change this depending on levels
        //NSArray array[] = [gameValues fa]
        NSArray * array = [gameValues getFactoryLocations];
        for (NSValue * point in array){
            [self placeFactoryAtPosition:[point CGPointValue]];
        }



        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
    }
    return self;
    
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


//- (void)stopMonitoringAcceleration{
//    if (_motionManager.accelerometerAvailable && _motionManager.accelerometerActive) {
//        [_motionManager stopAccelerometerUpdates];
//        NSLog(@"accelerometer updates off...");
//    }
//}


-(void)updatePositionFromMotionManager{

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
-(void)placeFactoryAtPosition:(CGPoint)position{
    CBEnemyFactory * factory = [CBEnemyFactory enemyFactory];
    
    [factory setPosition:position];
    factory.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:factory.size];
    factory.physicsBody.dynamic = NO;
    factory.physicsBody.categoryBitMask = enemyFactoryCategory;
    factory.physicsBody.contactTestBitMask = projectileCategory;
    factory.physicsBody.usesPreciseCollisionDetection = NO;
    
    [self.currentWorld addChild:factory];
    [self.factories addObject:factory];
}

-(void)moveFactory:(CBEnemyFactory *)factory {
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    
    //Create the actions
    
    int randx = arc4random_uniform(self.currentWorld.size.width)-self.currentWorld.size.width/2;
    int randy = arc4random_uniform(self.currentWorld.size.height)-self.currentWorld.size.height/2;
    
    SKAction * actionMove = [SKAction moveTo:CGPointMake(randx,randy) duration:actualDuration];
    
//    SKAction * actionMoveDone = [SKAction  ];
    
    [factory runAction:actionMove];
}



//This belongs in another class
-(void)addMonster {
    //Create Sprite
    for (CBEnemyFactory *factory in self.factories) {
        
    
        CBWalker * monster = [factory createWalker];
    
    
        //Set up monster physics body (may want to make a class to do this later)
        monster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:monster.size];
        monster.physicsBody.dynamic = YES;
        monster.physicsBody.categoryBitMask = monsterCategory;
        monster.physicsBody.contactTestBitMask = projectileCategory;
        monster.physicsBody.collisionBitMask = 0;
        [self.currentWorld addChild:monster];
    
        int minDuration = 2.0;
        int maxDuration = 4.0;
        int rangeDuration = maxDuration - minDuration;
        int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    
        //Create the actions
        
        int randx = arc4random_uniform(self.currentWorld.size.width)-self.currentWorld.size.width/2;
        int randy = arc4random_uniform(self.currentWorld.size.height)-self.currentWorld.size.height/2;
        
        SKAction * actionMove = [SKAction moveTo:CGPointMake(randx,randy) duration:actualDuration];
    
        SKAction * actionMoveDone = [SKAction removeFromParent];
    
        [monster runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    }
    
}

-(void)updateWithTimeSinceLastUpdate: (CFTimeInterval) timeSinceLast{
    
    self.lastSpawnTimeInterval += timeSinceLast;
    if (self.lastSpawnTimeInterval > 0.5) {
        self.lastSpawnTimeInterval = 0;
        
        //uncomment to enable monsters
        [self addMonster];
    }
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
    
    //factory hit by projectile
    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&(secondBody.categoryBitMask & enemyFactoryCategory) != 0){
        //if ([secondBody isKindOfClass:[CBEnemyFactory class]]){
                [self projectile:(SKSpriteNode *) firstBody.node didCollideWithEnemyFactory:(CBEnemyFactory*) secondBody.node];
        //}
        

    }
    
    //Player hit by monster
    if((firstBody.categoryBitMask & monsterCategory) != 0){
    
        
        
        [self.player playerHit];
        [self.healthBar updateHealthBar];
        //NSLog(@"player hit by enemy!!!");
        
        if (self.player.dead) {
            
            [self returnToMenuScreen];
            
            
        }
    
    }
    
}


-(void)returnToMenuScreen {
    [self.gameDelegate launchMenuScreen];
//    SKView * skView = (SKView *)self.view;
//    SKScene * menuScene = [CBMenuScene sceneWithSize:skView.bounds.size];
//    menuScene.scaleMode = SKSceneScaleModeAspectFill;
//    [skView presentScene:menuScene];
    [self.stats saveTotalKills];
    
}

-(void)pause{
    NSLog(@"\n*\n pause Called on CBMyScene not implemented \n*\n");
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    //  This is going to need to be changed.  Will need to split behavior of different items up somehow
    //
    
    
    //  VVV OK UNTIL  VVV
    //chose a touch to work with
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self.currentWorld];
    // ^^^ HERE ^^^^
    
    
    
    //VVV Should be moved to CBShuriken VVV
    //set up initial location
    //SKSpriteNode * projectile = [SKSpriteNode spriteNodeWithImageNamed:@"projectile"];
    SKSpriteNode * projectile = [CBShuriken shuriken];
    projectile.position = self.player.position;
    
    projectile.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:projectile.size.width/2];
    projectile.physicsBody.dynamic = YES;
    projectile.physicsBody.categoryBitMask = projectileCategory;
    projectile.physicsBody.contactTestBitMask = monsterCategory;
    projectile.physicsBody.collisionBitMask = 0;
    projectile.physicsBody.usesPreciseCollisionDetection = YES;
    
    
    
    
    //configure offset
    CGPoint offset = [CBVectorMath cbVectorSubFirst:location Second:projectile.position];
    
    
    
    //Add the projectile
    [self.currentWorld addChild:projectile];
    
    //Get shooting direction
    CGPoint direction = [CBVectorMath cbVectorNormalize:offset];

    
    //Create shot vector
    CGPoint shotVector = [CBVectorMath cbVectorMultFirst:direction Value:350];
    
    //Add shot vector to current position
    CGPoint realDest = [CBVectorMath cbVectorAddFirst:shotVector Second:projectile.position];
    
    GameValues * gameValues = [[GameValues alloc] init];
    
    //Create actions
    float velocity = [gameValues playerShotSpeed];
    float realMoveDuration = self.size.width / velocity;
    
    SKAction * actionMove = [SKAction moveTo:realDest duration: realMoveDuration];
    
    SKAction * actionMoveDone = [SKAction removeFromParent];
    
    
    
    [projectile runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    
    //^^^ end add to CBShuriken
    
}




-(void)projectile:(SKSpriteNode *)projectile didCollideWithMonster:(SKSpriteNode *)monster {
    [projectile removeFromParent];
    [monster removeFromParent];
    
}

-(void)projectile:(SKSpriteNode *)projectile didCollideWithEnemyFactory:(CBEnemyFactory *)factory {
    [projectile removeFromParent];
    [factory factoryHit];
    [self moveFactory:factory];
    
    if(factory.dead){
        NSLog(@"factoryDead");
        [factory removeFromParent];
        [self.factories removeObject:factory];
    }
    
}








@end
