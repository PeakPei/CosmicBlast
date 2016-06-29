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
    
    
    func fetchSavedWorldSettings() -> WorldSettings? {
        let worldSettingsFetch = NSFetchRequest(entityName: "WorldSettings")
        do {
            var fetchedWorldSettingsList = try moc.executeFetchRequest(worldSettingsFetch) as! [WorldSettings]
            while(fetchedWorldSettingsList.count > 1) {
                print("**************Error world settings has more than one entity Error******************")
                fetchedWorldSettingsList.removeFirst()
            }
            do{
                try moc.save()
            } catch {
                fatalError("Failure to save context in fetch: \(error)")
            }
            let loadedWorldSettings = fetchedWorldSettingsList.last!
            print("fetchedWorldSettings.count: \(fetchedWorldSettingsList.count)")
            return loadedWorldSettings
        } catch {
            fatalError("Failed to fetch worldSettings: \(error)")

        }
    }
    
    
    
    func maybeInitializeWorldSettings() {
        let worldSettingsFetch = NSFetchRequest(entityName: "WorldSettings")
        do {
            var fetchedWorldSettingsList = try moc.executeFetchRequest(worldSettingsFetch) as! [WorldSettings]
            if (fetchedWorldSettingsList.count < 1){
                let entity = NSEntityDescription.insertNewObjectForEntityForName("WorldSettings", inManagedObjectContext: moc) as! WorldSettings
                // add our data
                entity.setValue(0.0, forKey: "worldWidth")
                entity.setValue(0.0, forKey: "worldHeight")
            } else  {
                while(fetchedWorldSettingsList.count > 1) {
                    print("**************Error world settings has more than one entity Error******************")
                    fetchedWorldSettingsList.removeFirst()
                }
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



