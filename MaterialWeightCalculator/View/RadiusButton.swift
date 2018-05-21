//
//  RadiusButton.swift
//  MaterialWeightCalculator
//
//  Created by Allen Whearry on 5/20/18.
//  Copyright © 2018 Allen Whearry. All rights reserved.
//

import UIKit

@IBDesignable
class RadiusButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 10.00 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    override func awakeFromNib() {
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }

}
