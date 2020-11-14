//
//  AppBrain.swift
//  Tip Calculator
//
//  Created by Richard Basdeo on 11/13/20.
//

import Foundation
struct AppBrain {
    
    //value to update stepper value
    //initial value will be one person
    var stepperValue = 1.0
    
    //initial bill will 0 and initial tab person is 0
    var billTotal = 0.0
    var tabPerPerson = 0.0
    
    //this array is for the picker
    //picker get values from this array
    let pickerArray = ["5%", "10%", "15%", "20%", "25%", "30%", "35%", "40%", "45%"]
    
    //this array is the percentages converted to doubles to be used to calcualte bill
    let actualPercentage = [0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45]
    
    
    //update the total diner label
    //take stepper current value
    //convert it to a string and return it so the label can use it
    mutating func updateStepperValue (newValue: Double) -> String {
        
        stepperValue = newValue
        let stringStepper = String(format: "%.0f", stepperValue)
        return stringStepper
        
    }
    
    //mutating becuase will be modifying a property
    //calculate total bill
    //returning a string so data can be sent to results view controller label
    mutating func calculateTotalBill (totalBill: Double, tipPercentage: Double) -> String{
        
        let percentageAmount = totalBill * tipPercentage
        billTotal = totalBill + percentageAmount
        
        return String(format: "%.2f", billTotal)
        
        
    }
    
    //mutating because will be modifying a property
    //calculate total per person
    //returning string so label can be updated in results view controller
    mutating func calculateTabPerPerson(totalAmountOfDiners: Double) -> String {
        
        tabPerPerson = billTotal / totalAmountOfDiners
        return String(format: "%.2f", tabPerPerson)
    }
}
