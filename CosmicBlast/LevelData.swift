//
//  LevelData.swift
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/9/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

import Foundation
import CoreGraphics

//this class stores the values for a specific level
class LevelValues: NSObject, NSCopying{
    let worldWidth: NSNumber
    let worldHeight: NSNumber
    let factoryLocations: [NSValue]
    let levelNumber: NSNumber
    required init(width: NSNumber, height: NSNumber, facLocs: [NSValue], levNum: NSNumber) {
        worldWidth = width
        worldHeight = height
        factoryLocations = facLocs
        levelNumber = levNum
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return self
    }
    
}

class LevelData {
    var levels = [LevelValues]()
    init(){
        populateLevelsDictionary()
    }
    
    func populateLevelsDictionary(){
        //Need to adjust when we add more levels
        NSUserDefaults().setInteger(2, forKey: "availableLevels")
        
        var pointArray1 = [NSValue]()
        pointArray1.append(NSValue.init(CGPoint: CGPointMake(200,150)));
        let level1 = LevelValues(width: 0.5, height: 0.5, facLocs:pointArray1, levNum: 1)
        levels.append(level1)
        
        var pointArray2 = [NSValue]()
        pointArray2.append(NSValue.init(CGPoint: CGPointMake(200,150)));
        pointArray2.append(NSValue.init(CGPoint: CGPointMake(-200,-150)));
        let level2 = LevelValues(width: 1.0, height: 0.5, facLocs:pointArray2, levNum: 2)
        levels.append(level2)
    }
    
    
    
    
}