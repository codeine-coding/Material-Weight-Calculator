//
//  DimensionTextField.swift
//  MaterialWeightCalculator
//
//  Created by Allen Whearry on 6/10/18.
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
        self.textColor = #colorLiteral(red: 0.3313614726, green: 0.1370666325, blue: 0.4729859829, alpha: 1)
        // text field clears on edit
        self.clearsOnBeginEditing = true
    }
    
    
}
