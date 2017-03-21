//
//  ViewController.swift
//  TipCalculator
//
//  Created by Pari, Nithya on 2/24/17.
//  Copyright © 2017 Pari, Nithya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       /* Making bill amount field the first responder with keyboard on,
        * after the view has loaded
        */
        billField.becomeFirstResponder()
        
        //Storing the current locale curreny in defaul on app load
        storeCurrentLocaleCurrency()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    // This method calculates tip whenever bill amount changes
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        let selectedNumberOfPeople = 1
        recalculateTip(numberOfPeople: selectedNumberOfPeople)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        //As soon as the main page loads, following will be done
        let defaults = UserDefaults.standard
        
        //Resetting the bill amount based on time > 10 mins
        resetBillAmount()
        
        //Setting the theme based on default theme
        loadDefaultTheme()
        
        //Setting the tip % based on default tip %
        loadDefaultTip()
        
        //Recalculate the tip based on new tip selection from settings
        let selectedNumberOfPeople = defaults.integer(forKey: "numOfPeopleKey")
        recalculateTip(numberOfPeople: selectedNumberOfPeople)
    }
    
    func loadDefaultTip() {
        let defaults = UserDefaults.standard
        
        //Extracting the default tip amount from Settings
        let selectedDefaultTipPosition = defaults.integer(forKey: "defaultTipPercentageKey")
        print(selectedDefaultTipPosition)
        
        //Setting the default tip amount in Tippy main screen
        tipControl.selectedSegmentIndex = selectedDefaultTipPosition
    }
    
    func resetBillAmount() {
        let defaults = UserDefaults.standard
        
        let shouldResetBill = defaults.bool(forKey: "resetBillAmountKey")
        if(shouldResetBill) {
            billField.text=""
            //Setting the resetBillAmountKey as false again
            defaults.set(false, forKey: "resetBillAmountKey")
        } else {
            billField.text = defaults.string(forKey: "billFieldText")
        }
    }
    
    func recalculateTip(numberOfPeople: Int) {
        let defaults = UserDefaults.standard
        let tipPercentages = [0.18, 0.20, 0.25]
        let billAmount = Double(billField.text!) ?? 0
        let tipAmount = billAmount * tipPercentages[tipControl.selectedSegmentIndex]
        
        //Storing the bill amount in defaults
        defaults.set(billField.text, forKey: "billFieldText")
        
        //Getting the current currency from defaults
        let currentCurrency = defaults.string(forKey: "currentCurrencyKey")
        
        //Calculating tip per person
        if (numberOfPeople > 1) {
            let tipPerPerson = (tipAmount/Double(numberOfPeople))
             tipLabel.text = String(format: currentCurrency!+" %.2f", tipPerPerson)
            
        } else {
            tipLabel.text = String(format: currentCurrency!+" %.2f", tipAmount)
        }
        
        //Calculating and setting the total amount based on bill and tip
        let totalAmount = billAmount + tipAmount
        totalLabel.text = String(format: currentCurrency!+" %.2f", totalAmount)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        
        //Animate fields in main page
        animateTipAndTotal()
        
    }
    
    func animateTipAndTotal() {
        //Animate the tip and total fields
        self.tipLabel.alpha = 0
        self.totalLabel.alpha = 0
        UIView.animate(withDuration: 0.6, animations: {
            self.tipLabel.alpha = 1
            self.totalLabel.alpha = 1
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    //This method stores the currency corresponding to the current locale
    func storeCurrentLocaleCurrency() {
        
        //Getting the current locale of the mobile device
        let currentLocale = Locale.current
        
        //Getting the currency corresponding to the locale
        let currentCurrency = currentLocale.currencyCode
        
        print(currentLocale)
        print(currentCurrency)
        
        //Storing default currency
        let defaults = UserDefaults.standard
        defaults.set(currentCurrency, forKey: "currentCurrencyKey")
    }
    
    /*****************************************************
    * Methods related to updating the theme in Main page
    ******************************************************/
    
    //This method loads the default theme based on Settings
    func loadDefaultTheme() {
        //As soon as the main page loads, following will be done
        let defaults = UserDefaults.standard
        
        //Setting the theme based on default theme
        let selectedTippyThemeVal = defaults.integer(forKey: "defaultTippyThemeKey")
        updateTheme(selectedTippyThemePosition: selectedTippyThemeVal)
    }

    //This method updates the theme based on user selection
    func updateTheme(selectedTippyThemePosition: Int) {
        if(selectedTippyThemePosition == 1) {
            loadLightTheme()
        } else if(selectedTippyThemePosition == 0) {
            loadDarkTheme()
        }
    }
    
    //This method loads the dark colored theme
    func loadDarkTheme() {
        self.view.backgroundColor = UIColor.darkGray
    }
    
    //This method loads the light colored theme
    func loadLightTheme() {
        self.view.backgroundColor = UIColor.white
    }

    
}

