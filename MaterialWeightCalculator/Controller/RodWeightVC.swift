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
    @IBOutlet weak var clearFieldsBtn: RadiusButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
        // Do any additional setup after loading the view.
    }
    
    func setupPicker() {
        let materialPicker = UIPickerView()
        materialPicker.delegate = self
        rodMaterialSelect.inputView = materialPicker
        setupToolbar()
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(SheetWeightVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
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
        if (diameterTxt.text  == "") && (lengthTxt.text == "") && selectedMaterialFactor != nil {
            weightLabel.text = "no weights supplied"
        } else {
            let calculatedValue = calculateRoundRod(factor: selectedMaterialFactor!,
                                                    diameter: diameterTxt.text!,
                                                    length: lengthTxt.text!)
            weightLabel.text = String(calculatedValue)
        }
        poundsLabel.isHidden = false
        weightLabel.isHidden = false
        clearFieldsBtn.isHidden = false
        clearFieldsBtn.isEnabled = true
        
    }
    @IBAction func clearFieldsBtnPressed(_ sender: Any) {
        rodMaterialSelect.text = ""
        diameterTxt.text = ""
        lengthTxt.text = ""
        weightLabel.isHidden = true
        poundsLabel.isHidden = true
        calculateBtn.isEnabled = false
        clearFieldsBtn.isHidden = true
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
         calculateBtn.isEnabled = true
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
