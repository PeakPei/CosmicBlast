//
//  GameValues.swift
//  CosmicBlast
//
//  Created by Teddy Kitchen on 6/1/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

import UIKit

//TODO MAKE ALL PROPERTIES LAZY AND READ FROM DISK
//
//
//This Object allows you to access the game's variables
class GameValues: NSObject {
    
    
    //World Characteristics
    var backgroundColor: UIColor = UIColor.blackColor()
    //var worldColor: UIColor = UIColor.greenColor()
    var worldColor = UIColor(patternImage: UIImage(named: "Background.png")!)
    var woldImage = UIImage(named: "checker.png")
    var worldSize: CGSize = CGSizeMake(500, 400)
    
    
    
    //Player Characteristics
    var playerMaxHealth: Int = 150
    var playerColor: UIColor = UIColor.brownColor()
    var playerSize: CGSize = CGSizeMake(20, 40)
    var playerAccelerationCoefficient: Int = 60
    
    var shotSize: CGSize = CGSizeMake(8,8)
    var shotColor: UIColor = UIColor.orangeColor()
    var playerShotSpeed: Int = 1000
    
    //Enemy Characteristics
    var walkerColor:UIColor = UIColor.darkGrayColor()
    var walkerSize: CGSize = CGSizeMake(20,30)
    var factoryColor:UIColor = UIColor.blackColor()
    var factorySize: CGSize = CGSizeMake(50,50)
    var factoryMaxHealth: Int = 50
    
    var factoryLocations: NSMutableArray
        {
        get {
            let pointArray = NSMutableArray()
            pointArray.addObject(NSValue(CGPoint: CGPointMake(200, 150)))
            pointArray.addObject(NSValue(CGPoint: CGPointMake(-200, 150)))
            pointArray.addObject(NSValue(CGPoint: CGPointMake(200, -150)))
            pointArray.addObject(NSValue(CGPoint: CGPointMake(-200, -150)))
            return pointArray
        }
    }
    
    func getFactoryLocations() -> NSArray{
        return self.factoryLocations
    }
}
