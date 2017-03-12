//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Pari, Nithya on 3/10/17.
//  Copyright © 2017 Pari, Nithya. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var defaultTipPercentageControl: UISegmentedControl!
    @IBOutlet weak var numOfPeopleField: UILabel!
    @IBOutlet weak var changePeopleNumControl: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadSettingScreenWithValues()
    }
    
    /**
     * loadSettingScreenWithValues will load the values into the Settings part based on what user
     * had previously set
    **/
    func loadSettingScreenWithValues() {
        
        let defaults = UserDefaults.standard
        
        //Setting the default tip percentage in Settings Screen as set by user
        let selectedDefaultTipPosition = defaults.integer(forKey: "defaultTipPercentageKey")
        print("Default Values set by user:")
        print(selectedDefaultTipPosition)
        defaultTipPercentageControl.selectedSegmentIndex = selectedDefaultTipPosition
        
        //Setting the default number of people in Setting Screen as set by user
        let selectedNumberOfPeople = defaults.double(forKey: "numOfPeopleKey")
        print(selectedNumberOfPeople)
        numOfPeopleField.text = String(format: "%.0f", selectedNumberOfPeople)
        changePeopleNumControl.value = selectedNumberOfPeople
        print(numOfPeopleField.text)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setNumberOfPeople(_ sender: UIStepper) {
        
        //Extracting the number of people from stepper
        let numOfPeopleFromStepper = changePeopleNumControl.value
        
        //Assigning the number of people to the text field
        numOfPeopleField.text = String(format: "%.0f", numOfPeopleFromStepper)
        
        //Set number of people as default to use in Main screen
        let defaults = UserDefaults.standard
        defaults.set(numOfPeopleFromStepper, forKey: "numOfPeopleKey")
        defaults.synchronize()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    /**
     * setDefaultTipPercentage method will save the default 
     * tip percentage to NSUserDefaults
    **/
    @IBAction func setDefaultTipPercentage(_ sender: AnyObject) {
        
        let selectedDefaultTipPosition = defaultTipPercentageControl.selectedSegmentIndex
        let defaults = UserDefaults.standard
        defaults.set(selectedDefaultTipPosition, forKey: "defaultTipPercentageKey")
        defaults.synchronize()
        print(selectedDefaultTipPosition)
        
    }
    
    
}
