//
//  ViewController.swift
//  Tip_Calculator
//
//  Created by Eduardo Antonini on 7/3/20.
//  Copyright © 2020 Eduardo Antonini. All rights reserved.
//

import UIKit

class Main_Screen: UIViewController {

    @IBOutlet weak var tip_label: UILabel!
    @IBOutlet weak var total_label: UILabel!
    @IBOutlet weak var current_tip_rate: UILabel!
    @IBOutlet weak var party_size: UILabel!
    @IBOutlet weak var tpp_label: UILabel!
    @IBOutlet weak var amount_per_person: UILabel!
    @IBOutlet weak var bill_field: UITextField!
    @IBOutlet weak var tip_rate_slider: UISlider!
    @IBOutlet weak var people_slider: UISlider!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // the line below referenced from: https://stackoverflow.com/questions/26076054/changing-placeholder-text-color-with-swift
        bill_field.attributedPlaceholder = NSAttributedString(string: "$0.00", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        // -------------------------------------------------------------
        
        adjust_tipping_label()
        context_sensitivity(0)
    }
    
    // Tap Gesture Recognizer
    @IBAction func on_tap(_ sender: Any) {
        // send keyboard away
        view.endEditing(true)
    }
    
    @IBAction func calculate_tip(_ sender: Any) {
            
        // get the bill amount
        // set 0 as default value if entered value isn't valid
        let bill = get_bill()
        
        // update the tip and total
        // use formatting function (much like C)
        // need to indicate we're embedding a decimal by using "%f"
        // need to format it with two decimal places by using ".2"
        tip_label.text = String(format: "$%.2f", bill.Tip)
        total_label.text = String(format: "$%.2f", bill.Total)
        context_sensitivity(bill.Total)
    }
    
    @IBAction func slid_the_slide(_ sender: Any) {
        adjust_tipping_label()
    }
    
    @IBAction func adjust_party_size(_ sender: Any) {
        party_size.text = party_size_text(get_num_people())
        context_sensitivity(get_bill().Total)
    }
    
    func adjust_tipping_label() {
        let rate = Int(round(tip_rate_slider.value))
        current_tip_rate.text = "\(rate)%"
    }
    
    func get_num_people() -> Int {
        return Int(round(people_slider.value))
    }
    
    func party_size_text(_ size: Int) -> String {
        return size == 1 ? "1 person" : "\(size) people"
    }
    
    func context_sensitivity(_ bill: Double) {
        
        let num_people = get_num_people()
        
        if num_people == 1 {
            tpp_label.text = ""
            amount_per_person.text = ""
        }
        
        else {
            let shared_bill = bill / Double(num_people)
            tpp_label.text = "Total Per Patron"
            amount_per_person.text = String(format: "$%.2f", shared_bill)
        }
    }
    
    func get_bill() -> (Tip: Double, Total: Double) {
        
        // get the bill amount
        // set 0 as default value if entered value isn't valid
        let bill = Double(bill_field.text!) ?? 0
        
        let rate = Double(round(tip_rate_slider.value)) / 100
        
        // calculate the tip and total
        let tip = bill * rate, total = bill + tip
        return (tip, total)
    }

    @IBAction func go_to_settings(_ sender: Any) {
        performSegue(withIdentifier: "gear_icon", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! Settings_Screen
        dest.max_party = Double(self.people_slider.maximumValue)
        dest.max_rate = Double(self.tip_rate_slider.maximumValue)
    }
}
