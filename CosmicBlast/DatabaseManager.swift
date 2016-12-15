//
//  DatabaseManager.swift
//  CosmicBlast
//
//  Created by Teddy Kitchen on 6/28/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

import CoreData


fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}


class DatabaseManager: NSObject {
    let moc = DataController().managedObjectContext
    
    func maybeInitializeDatabase() {
        maybeInitializeWorldSettings()
    }
    
    
    
    //This will need to take a level as an argument
    func fetchSavedWorldSettings() -> WorldSettings? {
        let worldSettingsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "WorldSettings")
        do {
            let fetchedWorldSettingsList = try moc.fetch(worldSettingsFetch) as! [WorldSettings]
            let sortedSettingsList = fetchedWorldSettingsList.sorted(by: { $0.levelNumber?.int32Value < $1.levelNumber?.int32Value})
            let currentLevel = UserDefaults().integer(forKey: "currentLevel")
            let loadedWorldSettings = sortedSettingsList[currentLevel-1]
            return loadedWorldSettings
        } catch {
            fatalError("Failed to fetch worldSettings: \(error)")
        }
    }
    
    
    
    func maybeInitializeWorldSettings() {
        print("maybeInitializeWorldSettingsCalled")
        let worldSettingsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "WorldSettings")
        do {
            let
            fetchedWorldSettingsList = try moc.fetch(worldSettingsFetch) as! [WorldSettings]
            if (fetchedWorldSettingsList.count < 1){
                
                let levelData = LevelData()
                for level in levelData.levels {
                    let entity = NSEntityDescription.insertNewObject(forEntityName: "WorldSettings", into: moc) as! WorldSettings
                    // add our data
                    print("about to set values for keys")
                    
                    entity.setValue(level.worldWidth, forKey: "worldWidth")
                    entity.setValue(level.worldHeight, forKey: "worldHeight")
                    entity.setValue(level.levelNumber, forKey:"levelNumber")
                    entity.setValue(level.unitLocations, forKey: "unitPositions")
                    
                }
                
                
                
//                let entity = NSEntityDescription.insertNewObjectForEntityForName("WorldSettings", inManagedObjectContext: moc) as! WorldSettings
//                // add our data
//                print("about to set values for keys")
//                
//                entity.setValue(1.0, forKey: "worldWidth")
//                entity.setValue(1.0, forKey: "worldHeight")
//                let gameValues = GameValues()
//                let unitPositions = gameValues.unitLocations
//                print("\(unitPositions)")
//                entity.setValue(unitPositions, forKey: "unitPositions")

            } else  {
                print("Database has data")
//                while(fetchedWorldSettingsList.count > 1) {
//                    print("**************Error world settings has more than one entity Error******************")
//                    fetchedWorldSettingsList.removeFirst()
//                }
            }
            do{
                try moc.save()
            } catch {
                fatalError("Failure to save context in fetch: \(error)")
            }
            print("fetchedWorldSettings.count: \(fetchedWorldSettingsList.count)")
        } catch {
            fatalError("Failed to fetch worldSettings: \(error)")
        }
    }
}



