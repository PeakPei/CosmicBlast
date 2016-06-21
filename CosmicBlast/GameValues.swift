//
//  GameValues.swift
//  CosmicBlast
//
//  Created by Teddy Kitchen on 6/1/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

import UIKit
import CoreMotion

//TODO MAKE ALL PROPERTIES LAZY AND READ FROM DISK
//
//
//This Object allows you to access the game's variables
class GameValues: NSObject {
    
    
    
    //var archiver: NSKeyedArchiver = NSKeyedArchiver()
    //GamePlay Characteristics
    var accelerometerZero: CMAcceleration = CMAcceleration(x: 0, y: 0, z: 0)
    
    
    
    //World Characteristics
    var backgroundColor: UIColor = UIColor.blackColor()
    //var worldColor: UIColor = UIColor.greenColor()
    var worldColor = UIColor(patternImage: UIImage(named: "Background.png")!)
    var worldImageName = "Background.png"
//    lazy var worldImage: () -> UIImage = {
//        
//        var baseImage = UIImage(named: "Background.png")!
//        UIGraphicsBeginImageContextWithOptions(self.worldSize, true, 0.0)
//        baseImage.drawInRect(CGRectMake(0, 0, self.worldSize.width, self.worldSize.height))
//        var toReturn = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return toReturn
//        }

    var worldSize: CGSize = CGSizeMake(400, 400)
    
    
    
    //Player Characteristics
    var playerMaxHealth: Int = 20
    var playerColor: UIColor = UIColor.brownColor()
    var playerSize: CGSize = CGSizeMake(20, 40)
    var playerAccelerationCoefficient: Int = 60
    
    var shotSize: CGSize = CGSizeMake(8,8)
    var shotColor: UIColor = UIColor.orangeColor()
    var playerShotSpeed: Int = 1000
    
    //Enemy Characteristics
    var walkerColor:UIColor = UIColor.darkGrayColor()
    var walkerSize: CGSize = CGSizeMake(20,30
    )
    var factoryColor:UIColor = UIColor.redColor()
    var factorySize: CGSize = CGSizeMake(50,50)
    var factoryMaxHealth: Int
    {
        get {
            return 10
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





