//
//  LevelData.swift
//  CosmicBlast
//
//  Created by Teddy Kitchen on 8/9/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

import Foundation
import CoreGraphics
import SwiftyJSON

//this class stores the values for a specific level
class LevelValues: NSObject, NSCopying{
    
    //let worldWidth: NSNumber
    //let worldHeight: NSNumber
    let imageName: String
    let shape: String
    let unitLocations: [NSValue]
    let unitBehaviors: [NSValue]
    let levelNumber: NSNumber
    
    required init(image: String, worldShape: String, locations: [NSValue], behaviors: [NSValue], levNum: NSNumber) {
        
        imageName = image
        shape = worldShape
        unitLocations = locations
        unitBehaviors = behaviors
        levelNumber = levNum
    }
    
    func copy(with zone: NSZone?) -> Any {
        return self
    }
    
}

class LevelData:NSObject {
    var levels = [LevelValues]()
    
    override init() {
        super.init()
        populateLevelsDictionary()
    }
    
    class func jsonTest() {
        let bundle = Bundle.main
        if let resourceUrl = bundle.url(forResource: "LevelsJSON", withExtension: "txt") {
            do {
                let fileContents = try Data(contentsOf: resourceUrl)
                print("contents of file = \(fileContents)")
                let json = JSON(data: fileContents)
                print(json.count)
                print(json["levels"].count)//[0]["number"])
            } catch {
                print("error")
            }
        }
    }
    
    
    
    
    func populateLevelsDictionary() {
        
        let bundle = Bundle.main
        if let resourceUrl = bundle.url(forResource: "LevelsJSON", withExtension: "txt") {
            do {
                let fileContents = try Data(contentsOf: resourceUrl)
                let json = JSON(data: fileContents)
                UserDefaults().set(json["levels"].count, forKey: "availableLevels")
            
                for (_,level):(String, JSON)in json["levels"] {
                    var pointArray = [NSValue]()
                    var behaviorArray = [NSValue]()
                    let levelNumber = NSNumber(integerLiteral: level["number"].intValue)
                    let shape = level["shape"].stringValue
                    let imageName = level["imageName"].stringValue
                    
                    
                    
                    for (_,unit):(String, JSON) in level["Units"] {
                        let unitX = unit["x"].intValue
                        let unitY = unit["y"].intValue
                        pointArray.append(NSValue.init(cgPoint: CGPoint(x: unitX, y: unitY)))
                        
                        let unitMove = unit["movement"].intValue
                        let unitAttack = unit["attack"].intValue
                        behaviorArray.append(NSValue.init(cgPoint: CGPoint(x: unitMove, y: unitAttack)))
                        //Do something you want
                    }
                    levels.append(LevelValues(image: imageName, worldShape: shape, locations: pointArray, behaviors: behaviorArray, levNum: levelNumber))
                    //levels.append(LevelValues(: 1.5, height: 1.5, locations: pointArray, behaviors: behaviorArray,  levNum: levelNumber))
//                    for (_,unit) in jsonLevel["Units"] {
//                        pointArray.append(NSValue.init(cgPoint: CGPoint(x: unit["x"], y: unit["y"])))
//                    }
//                    let level = LevelValues(width: 1.0, height: 1.0, facLocs:pointArray1, levNum: 1.0)
                }
            } catch {
                print("error finding levesJSON file in bundle")
            }
        }
    }
    
    
    
    
    
//    func populateLevelsDictionary() {
//        
//        //Need to adjust when we add more levels
//        //var levels = [LevelValues]()
//        UserDefaults().set(3, forKey: "availableLevels")
//        
//        var pointArray1 = [NSValue]()
//        pointArray1.append(NSValue.init(cgPoint: CGPoint(x: 0,y: 0)));
//        let level1 = LevelValues(width: 1.0, height: 1.0, facLocs:pointArray1, levNum: 1.0)
//        levels.append(level1)
//        
//        var pointArray2 = [NSValue]()
//        pointArray2.append(NSValue.init(cgPoint: CGPoint(x: 200,y: 150)));
//        pointArray2.append(NSValue.init(cgPoint: CGPoint(x: -200,y: -150)));
//        let level2 = LevelValues(width: 1.5, height: 1.0, facLocs:pointArray2, levNum: 2.0)
//        levels.append(level2)
//        
//        var pointArray3 = [NSValue]()
//        pointArray3.append(NSValue.init(cgPoint: CGPoint(x: 200,y: 190)));
//        pointArray3.append(NSValue.init(cgPoint: CGPoint(x: 200,y: 150)));
//        pointArray3.append(NSValue.init(cgPoint: CGPoint(x: 20,y: 190)));
//        let level3 = LevelValues(width: 1.0, height: 1.5, facLocs:pointArray3, levNum: 3.0)
//        levels.append(level3)
//    }
    
    
    
    
}
