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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    /**
     * calculateTip method calculates the tip whenever
     * the bill amount changes or when the user selects
     *
    **/
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        let selectedNumberOfPeople = 1
        recalculateTip(numberOfPeople: selectedNumberOfPeople)
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        let defaults = UserDefaults.standard

        let shouldResetBill = defaults.bool(forKey: "resetBillAmountKey")
        if(shouldResetBill) {
            billField.text=""
        } else {
            billField.text = defaults.string(forKey: "billFieldText")
        }

        
        //Extracting the default tip amount from Settings
               let selectedDefaultTipPosition = defaults.integer(forKey: "defaultTipPercentageKey")
        print(selectedDefaultTipPosition)
        
        //Setting the default tip amount in Tippy main screen
        tipControl.selectedSegmentIndex = selectedDefaultTipPosition
        
        //Check if number of people is > 1
        let selectedNumberOfPeople = defaults.integer(forKey: "numOfPeopleKey")
        
        //Recalculate the tip based on new tip selection from settings
        recalculateTip(numberOfPeople: selectedNumberOfPeople)
    }
    
    func recalculateTip(numberOfPeople: Int) {
        let tipPercentages = [0.18, 0.20, 0.25]
        let billAmount = Double(billField.text!) ?? 0
        let tipAmount = billAmount * tipPercentages[tipControl.selectedSegmentIndex]
        
        //Storing the bill amount in defaults
        let defaults = UserDefaults.standard
        defaults.set(billField.text, forKey: "billFieldText")
        
        
        //Checking if there is more than 1 person, to split the tip amount, based on data from Settings and seeting the tip value
        if (numberOfPeople > 1) {
            let tipPerPerson = (tipAmount/Double(numberOfPeople))
             tipLabel.text = String(format: "$%.2f", tipPerPerson)
            
        } else {
            tipLabel.text = String(format: "$%.2f", tipAmount)
        }
        
        //Setting the total amount based on the tip amount and the bill amount
        let totalAmount = billAmount + tipAmount
        totalLabel.text = String(format: "$%.2f", totalAmount)

    }
    
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        
        // Animation Block
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
    
}

