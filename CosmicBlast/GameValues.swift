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

//TODO MAKE ALL PROPERTIES LAZY AND READ FROM DISK
//
//
//This Object allows you to access the game's variables
class GameValues: NSObject {

    
    var uiRatio = 10
    
    //var archiver: NSKeyedArchiver = NSKeyedArchiver()
    //GamePlay Characteristics
    var accelerometerZero: CMAcceleration = CMAcceleration(x: 0, y: 0, z: 0)
    
    
    
    //World Characteristics
    var backgroundColor: UIColor = UIColor.black
    //var worldColor: UIColor = UIColor.greenColor()
    var worldColor = UIColor(patternImage: UIImage(named: "Background.png")!)
    var worldImageName = "checker.png"
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
    var playerAccelerationCoefficient: Int = 60
    
    var shotSize: CGSize = CGSize(width: 8,height: 8)
    var shotColor: UIColor = UIColor.orange
    var playerShotSpeed: Int = 1000
    
    //Enemy Characteristics
    var walkerColor:UIColor = UIColor.darkGray
    var walkerSize: CGSize = CGSize(width: 15,height: 15)
    var factoryColor:UIColor = UIColor.green
    var factorySize: CGSize = CGSize(width: 30,height: 30)
    var factoryMaxHealth: Int
        {
        get {
            return 100
            //let readValue = Int(archiver.decodeIntForKey("factoryMaxHealth"))
            //return readValue
            
        }
    }
    
    
    override init()
    {
        
        //        let baseImage = UIImage(named: "checker.png")!
        //        UIGraphicsBeginImageContextWithOptions(self.worldSize, true, 0.0)
        //        baseImage.drawInRect(CGRectMake(0, 0, self.worldSize.width, self.worldSize.height))
        //        self.worldImage = UIGraphicsGetImageFromCurrentImageContext()
        //        UIGraphicsEndImageContext()
        
        //            + (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
        //UIGraphicsBeginImageContext(newSize);
        // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
        // Pass 1.0 to force exact pixel size.
        //                UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
        //                [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        //                UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        //               UIGraphicsEndImageContext();
        //                return newImage;
        //        }
    }

    
    
    
    var factoryLocations: [NSValue]
        {
        get {
            let manager = DatabaseManager()
            if let worldSettings = manager.fetchSavedWorldSettings(){
                
                let locations = worldSettings.factoryPositions ?? [NSValue]()
                return locations
            } else {
                return [NSValue]()
            }
            
            
//            let pointArray = NSMutableArray()
//            pointArray.addObject(NSValue(CGPoint: CGPointMake(200, 150)))
//            pointArray.addObject(NSValue(CGPoint: CGPointMake(-200, 150)))
//            pointArray.addObject(NSValue(CGPoint: CGPointMake(200, -150)))
//            pointArray.addObject(NSValue(CGPoint: CGPointMake(-200, -150)))
//            return pointArray
            
        }
    }
    
    func getFactoryLocations() -> NSArray{
        return self.factoryLocations as NSArray
    }
    
        
        
        
    
    
}





