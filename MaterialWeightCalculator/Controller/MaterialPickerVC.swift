//
//  ViewController.swift
//  MaterialWeightCalculator
//
//  Created by Allen Whearry on 5/20/18.
//  Copyright © 2018 Allen Whearry. All rights reserved.
//

import UIKit

class MaterialPickerVC: UIViewController {

    @IBOutlet weak var materialTextField: UITextField!
    var selectedMaterial: String?
    var selectedMaterialFactor: Double?
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var thicknessTxt: UITextField!
    @IBOutlet weak var widthTxt: UITextField!
    @IBOutlet weak var lengthTxt: UITextField!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var calculateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
    }

    func setupPicker() {
        let materialPicker = UIPickerView()
        materialPicker.delegate = self
        materialTextField.inputView = materialPicker
        setupToolbar()
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(MaterialPickerVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(MaterialPickerVC.dismissKeyboard))
        
        toolbar.setItems([doneBtn], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        materialTextField.inputAccessoryView = toolbar
        thicknessTxt.inputAccessoryView = toolbar
        widthTxt.inputAccessoryView = toolbar
        lengthTxt.inputAccessoryView = toolbar
        
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func calculateBtnPressed(_ sender: Any) {
        if (thicknessTxt.text  == "") && (widthTxt.text == "") && (lengthTxt.text == "") && selectedMaterialFactor != nil {
            weightLabel.text = "no weights supplied"
        } else {
            guard let t = thicknessTxt.text else {return}
            guard let w = widthTxt.text else {return}
            guard let l = lengthTxt.text else {return}
            let calculatedValue = round((selectedMaterialFactor! * Double(t)! * Double(w)! * Double(l)!) * 1000) / 1000
            weightLabel.text = String(calculatedValue)
        }
        
    }
}

extension MaterialPickerVC: UIPickerViewDataSource, UIPickerViewDelegate {
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
