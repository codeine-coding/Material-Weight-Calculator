//
//  RoundTubeWeightVC.swift
//  MaterialWeightCalculator
//
//  Created by Allen Whearry on 6/6/18.
//  Copyright © 2018 Allen Whearry. All rights reserved.
//

import UIKit

class RoundTubeWeightVC: UIViewController {

    // vars
    var selectedMaterial: String?
    var selectedMaterialFactor: Double?
    
    // outlets
    @IBOutlet weak var materialTextField: UITextField!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var outterDiameterTxt: UITextField!
    @IBOutlet weak var wallTxt: UITextField!
    @IBOutlet weak var lengthTxt: UITextField!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var poundsLabel: UILabel!
    @IBOutlet weak var calculateBtn: UIButton!
    @IBOutlet weak var clearFieldsBtn: UIButton!
    @IBOutlet weak var roundTubeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
        // Do any additional setup after loading the view.
    }
    
    func setupPicker() {
        let materialPicker = UIPickerView()
        materialPicker.delegate = self
        materialTextField.inputView = materialPicker
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
        
        materialTextField.inputAccessoryView = toolbar
        outterDiameterTxt.inputAccessoryView = toolbar
        wallTxt.inputAccessoryView = toolbar
        lengthTxt.inputAccessoryView = toolbar
        
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func calculateBtnPressed(_ sender: Any) {
        if (outterDiameterTxt.text  == "") && (wallTxt.text == "") && (lengthTxt.text == "") && selectedMaterialFactor != nil {
            weightLabel.text = "no weights supplied"
        } else {
            let calculatedValue = calculateRoundTube(factor: selectedMaterialFactor!,
                                                     outsideDiameter: outterDiameterTxt.text!,
                                                     wall: wallTxt.text!,
                                                     length: lengthTxt.text!)
            weightLabel.text = String(calculatedValue)
        }
        roundTubeImage.isHidden = true
        poundsLabel.isHidden = false
        weightLabel.isHidden = false
        clearFieldsBtn.isHidden = false
        clearFieldsBtn.isEnabled = true
        
    }
    @IBAction func clearFieldsBtnPressed(_ sender: Any) {
        materialTextField.text = ""
        outterDiameterTxt.text = ""
        wallTxt.text = ""
        lengthTxt.text = ""
        weightLabel.isHidden = true
        poundsLabel.isHidden = true
        calculateBtn.isEnabled = false
        clearFieldsBtn.isHidden = true
        roundTubeImage.isHidden = false
    }


}
extension RoundTubeWeightVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return MaterialService.instance.getMaterials().count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMaterial = MaterialService.instance.getMaterials()[row].title
        selectedMaterialFactor = MaterialService.instance.getMaterials()[row].factor
        materialTextField.text = selectedMaterial
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
