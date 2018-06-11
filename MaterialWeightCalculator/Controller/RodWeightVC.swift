//
//  RodWeightVC.swift
//  MaterialWeightCalculator
//
//  Created by Allen Whearry on 5/31/18.
//  Copyright © 2018 Allen Whearry. All rights reserved.
//

import UIKit

class RodWeightVC: UIViewController {
    
    // vars
    var selectedMaterial: String?
    var selectedMaterialFactor: Double?
    
    // outlets
    @IBOutlet weak var rodMaterialSelect: UITextField!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var diameterTxt: UITextField!
    @IBOutlet weak var lengthTxt: UITextField!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var poundsLabel: UILabel!
    @IBOutlet weak var calculateBtn: UIButton!
    @IBOutlet weak var clearFieldsBtn: UIButton!
    @IBOutlet weak var rodImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
        // Do any additional setup after loading the view.
    }
    
    func setupPicker() {
        let materialPicker = UIPickerView()
        materialPicker.delegate = self
        materialPicker.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        rodMaterialSelect.inputView = materialPicker
        setupToolbar()
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(SheetWeightVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = #colorLiteral(red: 0.3313614726, green: 0.1370666325, blue: 0.4729859829, alpha: 1)
        toolbar.backgroundColor = #colorLiteral(red: 0.3313614726, green: 0.1370666325, blue: 0.4729859829, alpha: 1)
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SheetWeightVC.dismissKeyboard))
        
        toolbar.setItems([doneBtn], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        rodMaterialSelect.inputAccessoryView = toolbar
        diameterTxt.inputAccessoryView = toolbar
        lengthTxt.inputAccessoryView = toolbar
        
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func calculateBtnPressed(_ sender: Any) {
        clearFieldsBtn.isHidden = false
        clearFieldsBtn.isEnabled = true
        rodImage.isHidden = true
        weightLabel.isHidden = false
        if selectedMaterialFactor == nil {
            errorLabel(for: weightLabel, hiddenLabel: poundsLabel, errorMessge: ErrorMessage.noMaterialSelectedErrorMessage)
        } else {
            do {
                weightLabel.textColor = #colorLiteral(red: 0.7092668414, green: 0.3661284447, blue: 0.6820954084, alpha: 1)
            let calculatedValue = try calculateRoundRod(factor: selectedMaterialFactor!,
                                                    diameter: diameterTxt.text!,
                                                    length: lengthTxt.text!)
                weightLabel.text = String(calculatedValue)
                poundsLabel.isHidden = false
            } catch CalculationError.invalidInput {
                errorLabel(for: weightLabel, hiddenLabel: poundsLabel, errorMessge: ErrorMessage.invalidInputErrorMessage)
            } catch CalculationError.zeroValue {
                errorLabel(for: weightLabel, hiddenLabel: poundsLabel, errorMessge: ErrorMessage.zeroValueErrorMessage)
            } catch {
                errorLabel(for: weightLabel, hiddenLabel: poundsLabel, errorMessge: ErrorMessage.unexpectedErrorMessage)
            }
        } 
        
    }
    @IBAction func clearFieldsBtnPressed(_ sender: Any) {
        rodMaterialSelect.text = ""
        diameterTxt.text = ""
        lengthTxt.text = ""
        weightLabel.isHidden = true
        poundsLabel.isHidden = true
        clearFieldsBtn.isHidden = true
        rodImage.isHidden = false
    }


}

extension RodWeightVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return MaterialService.instance.getMaterials().count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMaterial = MaterialService.instance.getMaterials()[row].title
        selectedMaterialFactor = MaterialService.instance.getMaterials()[row].factor
         rodMaterialSelect.text = selectedMaterial
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textAlignment = .center
        label.text = MaterialService.instance.getMaterials()[row].title
        
        return label
    }
    
}
