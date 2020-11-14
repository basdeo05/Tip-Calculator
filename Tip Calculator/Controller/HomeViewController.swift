//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Richard Basdeo on 11/13/20.
//

import UIKit

class HomeViewController: UIViewController {
    
    //labels
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var totalDinersLabel: UILabel!
    
    //picker
    @IBOutlet weak var percentagePicker: UIPickerView!
    
    //conects this view to the model
    var appBrain = AppBrain()
    
    //get access to my constants
    let k = K()
    
    
    //know which row was selected
    //allows me to get percentage from app brain
    //set to 0 because if user does not change picker will be on 0 row
    var rowSelected = 0
    
    //variables used to set variables in results view contoller
    var totalBill = ""
    var tabPerPerson = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        percentagePicker.dataSource = self
        percentagePicker.delegate = self
        billAmountTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        billAmountTextField.attributedPlaceholder = NSAttributedString(string: "Enter Bill Amount", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    
    //step pressed function
    //update label
    //let app brain worry about turning double value to string
    @IBAction func changeDinersAmountPressed(_ sender: UIStepper) {
        
        totalDinersLabel.text = appBrain.updateStepperValue(newValue: sender.value)
        billAmountTextField.endEditing(true)
        
    }
    
    
    
    //calculate pressed button
    //let app brain to worry about calcuating the bill
    //set public variables to be used in prepare segue function
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        
        //if somehow the user did not enter anyting let tab be 0
        let userTab = Double(billAmountTextField.text!) ?? 0.0
        
        totalBill = appBrain.calculateTotalBill(totalBill: userTab, tipPercentage: appBrain.actualPercentage[rowSelected])
        
        //if somehow the label is nil let it be 0
        let numberOfDiners = Double(totalDinersLabel.text!) ?? 0.0
        tabPerPerson = appBrain.calculateTabPerPerson(totalAmountOfDiners: numberOfDiners)
        
        performSegue(withIdentifier: k.Segue, sender: self)
        
    }
    
    //set the values of the results view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == k.Segue{
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalBill = totalBill
            destinationVC.totalPerPerson = tabPerPerson
            
        }
    }
}



extension HomeViewController: UIPickerViewDataSource {
    
    //I only want one column
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    
    
    //Number of items depend on how many percentages I wanna include so far 9 items
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return appBrain.pickerArray.count
    }
    
    
}

extension HomeViewController: UIPickerViewDelegate {
    
    //what the row name will be
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return appBrain.pickerArray[row]
    }
    
    
    //what to do when a row is selected
    //set public variable
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rowSelected = row
    }
}

//If user touched toe text field
//Make sure there is a tab before allowing user to dismiss keyboard
extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if (billAmountTextField.text != "") {
            return true
        }
        else {
            billAmountTextField.placeholder = "Please enter a bill amount"
            return false
        }
    }
}


//stack overflow:
//Close iOS Keyboard by touching anywhere using Swift
//https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
extension HomeViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


