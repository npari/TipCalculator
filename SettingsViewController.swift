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
    
    //Labels in Settings Page
    
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var templateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Load the default options in Settings Page on view load
        loadDefaultSettingScreen()
    }
    
    /*******************************************************
     * Methods to load the default options in Settings Page
     *******************************************************/
    func loadDefaultSettingScreen() {
        setDefaultTip()
        setDefaultPeople()
        setDefaultTheme()
    }
    
    //Default Settings for Tippy
    //Setting default tip percentage
    func setDefaultTip() {
        let defaults = UserDefaults.standard
        let selectedDefaultTipPosition = defaults.integer(forKey: "defaultTipPercentageKey")
        defaultTipPercentageControl.selectedSegmentIndex = selectedDefaultTipPosition
    }
    
    //Setting the default number of people in Setting Screen as set by user
    func setDefaultPeople() {
        let defaults = UserDefaults.standard
        let selectedNumberOfPeople = defaults.double(forKey: "numOfPeopleKey")
        numOfPeopleField.text = String(format: "%.0f", selectedNumberOfPeople)
        changePeopleNumControl.value = selectedNumberOfPeople
    }
    
    //Setting the theme based on default theme set in the app delegate
    func setDefaultTheme() {
        let defaults = UserDefaults.standard
        let selectedTippyThemeVal = defaults.integer(forKey: "defaultTippyThemeKey")
        themeControl.selectedSegmentIndex = selectedTippyThemeVal
        updateTheme(selectedTippyThemePosition: selectedTippyThemeVal)
    }

    //This function is used to update the theme based on selection by the user
    func updateTheme(selectedTippyThemePosition: Int) {
        if(selectedTippyThemePosition == 1) {
            //Set light color theme
            loadLightTheme()
            
        } else if(selectedTippyThemePosition == 0) {
            //Set dark color theme
            loadDarkTheme()
        }
    }
    
    //This function is used to load the dark theme
    func loadDarkTheme() {
        //Main view
        self.view.backgroundColor = UIColor.darkGray
    }
    
    //This function is used to load the light theme
    func loadLightTheme() {
        //Main view
        self.view.backgroundColor = UIColor.white
    }

    /*******************************************************
     * Methods to handle various options in Settings Page
     *******************************************************/
    
    //Handle setting of tip percentage
    @IBAction func setDefaultTipPercentage(_ sender: AnyObject) {
        
        let selectedDefaultTipPosition = defaultTipPercentageControl.selectedSegmentIndex
        let defaults = UserDefaults.standard
        defaults.set(selectedDefaultTipPosition, forKey: "defaultTipPercentageKey")
        defaults.synchronize()
    }
    
    //Handle setting of number of people
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

    //Handle setting of Tippy theme
    @IBAction func changeTippyTemplate(_ sender: AnyObject) {
        
        let selectedTippyThemePosition = themeControl.selectedSegmentIndex
        let defaults = UserDefaults.standard
        defaults.set(selectedTippyThemePosition, forKey:"defaultTippyThemeKey")
        defaults.synchronize()
        
        //Reloading Settings page with new theme selection
        loadDefaultSettingScreen()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
    
    
