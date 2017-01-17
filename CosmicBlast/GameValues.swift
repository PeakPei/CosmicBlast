//
//  GameValues.swift
//  CosmicBlast
//
//  Created by Teddy Kitchen on 6/1/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

import UIKit
import CoreMotion
import CoreData
import SwiftyJSON

//TODO MAKE ALL PROPERTIES LAZY AND READ FROM DISK
//
//
//This Object allows you to access the game's variables
class GameValues: NSObject {


    
    
    
    
    var uiRatio = 10
    
    //var archiver: NSKeyedArchiver = NSKeyedArchiver()
    //GamePlay Characteristics
    var accelerometerZero: CMAcceleration = CMAcceleration(x: 0, y: 0, z: 0)
    var accelerometerDataMemoryLength = 9
    
    
    //World Characteristics
    var backgroundColor: UIColor = UIColor.black
    //var worldColor: UIColor = UIColor.greenColor()
    var worldColor = UIColor(patternImage: UIImage(named: "Background.png")!)
    var worldImageName = "Mothership"
    //    lazy var worldImage: () -> UIImage = {
    //
    //        var baseImage = UIImage(named: "Background.png")!
    //        UIGraphicsBeginImageContextWithOptions(self.worldSize, true, 0.0)
    //        baseImage.drawInRect(CGRectMake(0, 0, self.worldSize.width, self.worldSize.height))
    //        var toReturn = UIGraphicsGetImageFromCurrentImageContext()
    //        UIGraphicsEndImageContext()
    //        return toReturn
    //        }
    
//    var maxWorldSize: CGSize = CGSizeMake(2000, 2000)
    let maxWorldWidth: CGFloat = 500
    let maxWorldHeight: CGFloat = 500
    
    var worldSize: CGSize{
        get {
            let manager = DatabaseManager()
            let worldSettings = manager.fetchSavedWorldSettings()
            let heightMultiplier = CGFloat(worldSettings!.worldHeight!)
            let widthMultiplier = CGFloat(worldSettings!.worldWidth!)
            let size = CGSize(width: widthMultiplier*maxWorldWidth,height: heightMultiplier*maxWorldHeight)
            
            return size
        }
    }
    
    //Player Characteristics
    var playerMaxHealth: Int = 800
    
    var playerMaxSpeed: Float = 300
    
    var playerColor: UIColor = UIColor.brown
    var playerSize: CGSize = CGSize(width: 20, height: 40)
    var playerAccelerationCoefficient: Int = 100
    
    var shotSize: CGSize = CGSize(width: 8,height: 8)
    var shotColor: UIColor = UIColor.orange
    var playerShotSpeed: Int = 500
    
    //Enemy Characteristics
    var walkerColor:UIColor = UIColor.darkGray
    var walkerSize: CGSize = CGSize(width: 15,height: 15)
    var unitColor:UIColor = UIColor.green
    var unitSize: CGSize = CGSize(width: 30,height: 30)
    var unitMaxHealth: Int
        {
        get {
            return 100
            //let readValue = Int(archiver.decodeIntForKey("unitMaxHealth"))
            //return readValue
            
        }
    }
    
    

    
    
    
    var unitLocations: [NSValue]
        {
        get {
            let manager = DatabaseManager()
            if let worldSettings = manager.fetchSavedWorldSettings(){
                
                let locations = worldSettings.unitPositions ?? [NSValue]()
                return locations
            } else {
                return [NSValue]()
            }
        }
    }
    
    var unitBehaviors: [NSValue]
        {
        get {
            let manager = DatabaseManager()
            if let worldSettings = manager.fetchSavedWorldSettings(){
                
                let behaviors = worldSettings.unitBehaviors ?? [NSValue]()
                return behaviors
            } else {
                return [NSValue]()
            }
        }
    }
    
    
    
    func getUnitLocations() -> NSArray{
        return self.unitLocations as NSArray
    }
    
    func getUnitBehaviors() -> NSArray{
        return self.unitBehaviors as NSArray
    }
    
        
        
        
    
    
}





