//
//  DatabaseManager.swift
//  CosmicBlast
//
//  Created by Teddy Kitchen on 6/28/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//

import CoreData


class DatabaseManager: NSObject {
    let moc = DataController().managedObjectContext
    
    func maybeInitializeDatabase() {
        maybeInitializeWorldSettings()
    }
    
    
    
    //This will need to take a level as an argument
    func fetchSavedWorldSettings() -> WorldSettings? {
        let worldSettingsFetch = NSFetchRequest(entityName: "WorldSettings")
        do {
            var fetchedWorldSettingsList = try moc.executeFetchRequest(worldSettingsFetch) as! [WorldSettings]
            fetchedWorldSettingsList.sortInPlace({ $0.levelNumber?.intValue > $1.levelNumber?.intValue })
//            while(fetchedWorldSettingsList.count > 1) {
//                print("**************Error world settings has more than one entity Error******************")
//                fetchedWorldSettingsList.removeFirst()
//            }
//            do{
//                try moc.save()
//            } catch {
//                fatalError("Failure to save context in fetch: \(error)")
//            }
            let loadedWorldSettings = fetchedWorldSettingsList.last!
            print("fetchedWorldSettings.count: \(fetchedWorldSettingsList.count)")
            return loadedWorldSettings
        } catch {
            fatalError("Failed to fetch worldSettings: \(error)")
        }
    }
    
    
    
    func maybeInitializeWorldSettings() {
        print("maybeInitializeWorldSettingsCalled")
        let worldSettingsFetch = NSFetchRequest(entityName: "WorldSettings")
        do {
            let
            fetchedWorldSettingsList = try moc.executeFetchRequest(worldSettingsFetch) as! [WorldSettings]
            if (fetchedWorldSettingsList.count < 1){
                
                let levelData = LevelData()
                for level in levelData.levels {
                    let entity = NSEntityDescription.insertNewObjectForEntityForName("WorldSettings", inManagedObjectContext: moc) as! WorldSettings
                    // add our data
                    print("about to set values for keys")
                    
                    entity.setValue(level.worldWidth, forKey: "worldWidth")
                    entity.setValue(level.worldHeight, forKey: "worldHeight")
                
                    print("\(level.factoryLocations)")
                    entity.setValue(level.factoryLocations, forKey: "factoryPositions")
                    
                }
                
                
                
//                let entity = NSEntityDescription.insertNewObjectForEntityForName("WorldSettings", inManagedObjectContext: moc) as! WorldSettings
//                // add our data
//                print("about to set values for keys")
//                
//                entity.setValue(1.0, forKey: "worldWidth")
//                entity.setValue(1.0, forKey: "worldHeight")
//                let gameValues = GameValues()
//                let factoryPositions = gameValues.factoryLocations
//                print("\(factoryPositions)")
//                entity.setValue(factoryPositions, forKey: "factoryPositions")

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



