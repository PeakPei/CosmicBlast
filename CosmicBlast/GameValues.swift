//
//  GameValues.swift
//  CosmicBlast
//
//  Created by Teddy Kitchen on 6/1/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

import UIKit


//This Object allows you to access the game's variables
class GameValues: NSObject {
    
    
    //Level Characteristics
    var backgroundColor:UIColor = UIColor.blackColor()
    //Player Characteristics
    var playerMaxHealth: Int = 50
    var playerColor: UIColor = UIColor.brownColor()
    var playerSize: CGSize = CGSizeMake(20, 30)
    var shotSize: CGSize = CGSizeMake(10,10)
    var shotColor: UIColor = UIColor.orangeColor()
    
    //Enemy Characteristics
    var walkerColor:UIColor = UIColor.darkGrayColor()
    var walkerSize: CGSize = CGSizeMake(20,30)
    var factoryColor:UIColor = UIColor.blackColor()
    var factorySize: CGSize = CGSizeMake(50,50)
    var factoryMaxHealth: Int = 50
    
    var factoryLocations: NSMutableArray
        {
        get {
            var pointArray = NSMutableArray()
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
