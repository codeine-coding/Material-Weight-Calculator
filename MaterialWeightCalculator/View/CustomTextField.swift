//
//  CustomTextField.swift
//  MaterialWeightCalculator
//
//  Created by Allen Whearry on 5/20/18.
//  Copyright © 2018 Allen Whearry. All rights reserved.
//

import UIKit

@IBDesignable
class DimensionTextField: UITextField {

    @IBInspectable var cornerRadius: CGFloat = 10.00 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = #colorLiteral(red: 0.5725490196, green: 0.1529411765, blue: 0.5607843137, alpha: 1)
        self.layer.borderWidth = CGFloat(2.0)
        // text field clears on edit
        self.clearsOnBeginEditing = true
    }
    

}
