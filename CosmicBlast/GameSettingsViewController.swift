//
//  GameSettingsViewController.swift
//  CosmicBlast
//
//  Created by Teddy Kitchen on 6/21/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//
import UIKit
import CoreData

class GameSettingsViewController: UIViewController, UITextFieldDelegate {
    
    //@IBOutlet weak var worldHeight: UITextField!
    
    //@IBOutlet weak var worldWidth: UITextField!
    

    @IBOutlet weak var worldWidthSlider: UISlider!
    
    @IBOutlet weak var worldHeightSlider: UISlider!

    
    @IBAction func save(_ sender: UIButton) {
        do {
            try saveWorldSize()
        } catch {
            fatalError("Failure to saveWorldSize: \(error)")
        }
    }
    
    let moc = DataController().managedObjectContext
    
    func saveWorldSize() throws {
        
       
        if let worldSettings = fetch() {
            worldSettings.setValue(worldWidthSlider.value, forKey: "worldWidth")
            worldSettings.setValue(worldHeightSlider.value, forKey: "worldHeight")
        }
        do {
            try moc.save()
        }catch{
            fatalError("failure to save managed object context \(error)")
        }
        
        
        
//        do {
//            let fetchedWorldSettings = try moc.executeFetchRequest(worldSettingsFetch) as! [WorldSettings]
//            entity.valueForKey(<#T##key: String##String#>)
//            
//            
//            entity.setValue(worldWidthSlider.value, forKey: "worldWidth")
//            entity.setValue(worldHeightSlider.value, forKey: "worldHeight")
//            try moc.save()
//        } catch {
//            fatalError("Failure to save context: \(error)")
//        }
////        let entity = NSEntityDescription.insertNewObjectForEntityForName("WorldSettings", inManagedObjectContext: moc) as! WorldSettings
//        entity.setValue(worldWidthSlider.value, forKey: "worldWidth")
//        entity.setValue(worldHeightSlider.value, forKey: "worldHeight")
//        // we save our entity
//
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
    }
    
    
    func fetch() -> WorldSettings? {
        
        let worldSettingsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "WorldSettings")
        do {
            var fetchedWorldSettingsList = try moc.fetch(worldSettingsFetch) as! [WorldSettings]
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
            
            

            

            
            
            //fetchedWorldSettings.last
            //print(fetchedWorldSettings.first!.worldWidth!)
        
            return loadedWorldSettings
        } catch {
            fatalError("Failed to fetch person: \(error)")
        }
    }
    
    
    func initializeUI() {
        if let worldValues = fetch() {
            if worldHeightSlider != nil {
                if let worldHeight = worldValues.worldHeight {
                    worldHeightSlider.value = Float(worldHeight)
                }
            }
            if worldWidthSlider != nil {
                if let worldWidth = worldValues.worldWidth {
                    worldWidthSlider.value = Float(worldWidth)
                }
            }
        } else {
            worldHeightSlider.value = 0.5
            worldWidthSlider.value = 0.5
        }
    }

    func updateUI() {
        self.view.setNeedsDisplay()
    }
    
    
    
    
    func initializeTextFields() {
        //worldHeight.delegate = self
        //worldHeight.keyboardType = UIKeyboardType.DecimalPad
        
        //worldWidth.delegate = self
        //worldWidth.keyboardType = UIKeyboardType.DecimalPad
    }
    
    
    
    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        if string.characters.count == 0 {
//            return true
//        }
//        // Check to see if the text field's contents still fit the constraints
//        // with the new content added to it.
//        // If the contents still fit the constraints, allow the change
//        // by returning true; otherwise disallow the change by returning false.
//        let currentText = textField.text ?? ""
//        let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
//        print("SHOULD CHANGE CHARACTERS IN RANGE CALLED")
//        switch textField {
//        case worldWidthSlider:
//            
//            print("prospectiveTextIsNumeric\(prospectiveText.isNumeric())")
//            return prospectiveText.isNumeric() &&
//                prospectiveText.characters.count <= 5
//        case worldHeightSlider:
//            return prospectiveText.isNumeric() &&
//                prospectiveText.characters.count <= 5
//        default:
//            return true
//        }
//
//    }

    
    
    
    
    
    
    

}
