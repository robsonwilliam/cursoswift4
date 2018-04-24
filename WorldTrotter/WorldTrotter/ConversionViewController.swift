//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by T1aluno10 on 24/04/18.
//  Copyright © 2018 T1aluno10. All rights reserved.
//

//import Foundation
import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField:UITextField){
        /* - apenas imita o campo value
        if let text = textField.text, !text.isEmpty{
            celsiusLabel.text = textField.text
        } else {
            celsiusLabel.text = "???"
        }
        */
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender:UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
    var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>?{
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    func updateCelsiusLabel(){
        if let celsiusValue = celsiusValue {
            //celsiusLabel.text = "\(celsiusValue.value)" //sem formatacao
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else{
            celsiusLabel.text = "???"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view.")
        updateCelsiusLabel()
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()


    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        //print("Current text:  \(textField.text)")
        //print("Replacement text: \(string)")
        
        //return true
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            let charactersused = NSCharacterSet( charactersIn: "0123456789-.")
            
            if string.rangeOfCharacter(from: charactersused.inverted) != nil {
                return false
            } else {
                return true
            }
        }
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        let currentHour = Calendar.current.component(.hour, from: Date())
        let lightColor = UIColor.init(red:0.961,  green:0.957,  blue:0.945, alpha:1)
        let darkColor = UIColor.init(red:0.184,  green:0.184,  blue:0.188, alpha:1)
        
        switch currentHour {
            
        case 0...6, 20...23:
            view.backgroundColor = darkColor
            break
            
        default:
            view.backgroundColor = lightColor
            
        }
    }
    
}
