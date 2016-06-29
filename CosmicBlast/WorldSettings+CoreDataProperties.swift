//
//  WorldSettings+CoreDataProperties.swift
//  CosmicBlast
//
//  Created by Teddy Kitchen on 6/27/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension WorldSettings {

    @NSManaged var worldWidth: NSNumber?
    @NSManaged var worldHeight: NSNumber?

}
