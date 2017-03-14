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
    @IBOutlet weak var themeControl: UISegmentedControl!
    
    
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
        
        //As soon as the Setting page loads, following will be done
        let defaults = UserDefaults.standard
        
        //Setting the theme based on default theme
        let selectedTippyThemeVal = defaults.integer(forKey: "defaultTippyThemeKey")
        themeControl.selectedSegmentIndex = selectedTippyThemeVal
        
        updateTheme(selectedTippyThemePosition: selectedTippyThemeVal)
        
        //Setting default tip percentage
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
    
    func updateTheme(selectedTippyThemePosition: Int) {
        if(selectedTippyThemePosition == 1) {
            //Set light color theme
            loadLightTheme()
            
        } else if(selectedTippyThemePosition == 0) {
            //Set dark color theme
            loadDarkTheme()
        }
    }
    
    func loadDarkTheme() {
        //Main view
        self.view.backgroundColor = UIColor.darkGray
    }
    
    func loadLightTheme() {
        //Main view
        self.view.backgroundColor = UIColor.white
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
    
    
    @IBAction func changeTippyTemplate(_ sender: AnyObject) {
        
        //Store the template selection in Defaults
        let selectedTippyThemePosition = themeControl.selectedSegmentIndex
        let defaults = UserDefaults.standard
        defaults.set(selectedTippyThemePosition, forKey:"defaultTippyThemeKey")
        defaults.synchronize()
        print("Theme selected:")
        print(selectedTippyThemePosition)
        
        //Save theme selection as default option
        
        //reloading template for settings
        loadSettingScreenWithValues()
        
        
    }
    
        
    }
    
    
