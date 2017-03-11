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
        
        recalculateTip()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        //Extracting the default tip amount from Settings
        let defaults = UserDefaults.standard
        let selectedDefaultTipPosition = defaults.integer(forKey: "defaultTipPercentageKey")
        print(selectedDefaultTipPosition)
        
        //Setting the default tip amount in Tippy main screen
        tipControl.selectedSegmentIndex = selectedDefaultTipPosition
        
        //Recalculate the tip based on new tip selection from settings
        recalculateTip()
        
    }
    
    func recalculateTip() {
        let tipPercentages = [0.18, 0.20, 0.25]
        let billAmount = Double(billField.text!) ?? 0
        let tipAmount = billAmount * tipPercentages[tipControl.selectedSegmentIndex]
        let totalAmount = billAmount + tipAmount
        
        tipLabel.text = String(format: "$%.2f", tipAmount)
        totalLabel.text = String(format: "$%.2f", totalAmount)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
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

