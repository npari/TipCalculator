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

    @IBOutlet weak var numberOfPeopleField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
