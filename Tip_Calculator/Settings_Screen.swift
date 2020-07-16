//
//  Settings_Screen.swift
//  Tip_Calculator
//
//  Created by Eduardo Antonini on 7/5/20.
//  Copyright © 2020 Eduardo Antonini. All rights reserved.
//

import UIKit

class Settings_Screen: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var tipping_rate: UILabel!
    @IBOutlet weak var party_size: UILabel!
    @IBOutlet weak var rate_stepper: UIStepper!
    @IBOutlet weak var size_stepper: UIStepper!
    
    var max_rate: Double = 0, max_party: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // the line below was referenced from:
        // https://stackoverflow.com/questions/34955987/pass-data-through-navigation-back-button/34956162
        navigationController?.delegate = self
        
        rate_stepper.value = max_rate
        size_stepper.value = max_party
        tipping_rate.text = "\(get_rate_value())%"
        party_size.text = "\(get_size_value()) people"
    }
    
    @IBAction func change_in_rate(_ sender: UIStepper) {
        max_rate = rate_stepper.value
        tipping_rate.text = "\(get_rate_value())%"
    }
    
    @IBAction func change_in_size(_ sender: UIStepper) {
        max_party = size_stepper.value
        party_size.text = "\(get_size_value()) people"
    }
    
    func get_rate_value () -> Int {
        return Int(rate_stepper.value)
    }
    
    func get_size_value () -> Int {
        return Int(size_stepper.value)
    }
    
    // the function below is called when user presses the "< Back" button; referenced from:
    // https://stackoverflow.com/questions/34955987/pass-data-through-navigation-back-button/34956162
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        (viewController as? Main_Screen)?.tip_rate_slider.maximumValue = Float(self.max_rate)
        (viewController as? Main_Screen)?.people_slider.maximumValue = Float(self.max_party)
        (viewController as? Main_Screen)?.adjust_tipping_label()
        (viewController as? Main_Screen)?.adjust_party_size(0)
        (viewController as? Main_Screen)?.calculate_tip(0)
    }
}
