//
//  ResultsViewController.swift
//  Tip Calculator
//
//  Created by Richard Basdeo on 11/14/20.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var totalTabLabel: UILabel!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    
    //variables to be set by previous view
    var totalBill = "0.0"
    var totalPerPerson = "0.0"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        totalTabLabel.text = "$ \(totalBill)"
        totalPerPersonLabel.text = "$ \(totalPerPerson)"
    }
    
    //go back to previous view contoller
    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
