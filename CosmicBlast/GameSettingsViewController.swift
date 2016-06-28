//
//  GameSettingsViewController.swift
//  CosmicBlast
//
//  Created by Teddy Kitchen on 6/21/16.
//  Copyright © 2016 Teddy Kitchen. All rights reserved.
//
import UIKit

class GameSettingsViewController: UIViewController, UITextFieldDelegate {
    
    //@IBOutlet weak var worldHeight: UITextField!
    
    //@IBOutlet weak var worldWidth: UITextField!
    
    @IBOutlet weak var worldWidth: UISlider!
    
    
    @IBOutlet weak var worldHeight: UISlider!
    
    @IBAction func save(sender: UIButton) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if worldHeight != nil {
            worldHeight.value = 0.5
        }
        if worldWidth != nil {
            worldWidth.value = 0.5
        }
        initializeTextFields()
    }
    
    
    func initializeTextFields() {
        //worldHeight.delegate = self
        //worldHeight.keyboardType = UIKeyboardType.DecimalPad
        
        //worldWidth.delegate = self
        //worldWidth.keyboardType = UIKeyboardType.DecimalPad
    }
    
    
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string.characters.count == 0 {
            return true
        }
        // Check to see if the text field's contents still fit the constraints
        // with the new content added to it.
        // If the contents still fit the constraints, allow the change
        // by returning true; otherwise disallow the change by returning false.
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
        print("SHOULD CHANGE CHARACTERS IN RANGE CALLED")
        switch textField {
        case worldWidth:
            
            print("prospectiveTextIsNumeric\(prospectiveText.isNumeric())")
            return prospectiveText.isNumeric() &&
                prospectiveText.characters.count <= 5
        case worldHeight:
            return prospectiveText.isNumeric() &&
                prospectiveText.characters.count <= 5
        default:
            return true
        }

    }

    
    
    
    
    
    
    
    func updateUI() {
        self.view.setNeedsDisplay()
    }
    
}
