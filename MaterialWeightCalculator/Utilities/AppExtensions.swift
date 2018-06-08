//
//  ApplicationExtensions.swift
//  MaterialWeightCalculator
//
//  Created by Allen Whearry on 6/6/18.
//  Copyright © 2018 Allen Whearry. All rights reserved.
//

import UIKit

extension Double {
    
    var roundMax4DecimalPlaces: Double {
        return Darwin.round(self * 1000.0) / 1000
    }
}

extension UIViewController {
    /// Function to add error styling to a label.
    ///
    /// - Parameters:
    ///   - label: Label to be converter to an error label.
    ///   - hiddenLabel: Label that should be hidden when error message displays.
    ///   - errorMessge: Error message to display on label.
    func errorLabel(for label: UILabel, hiddenLabel: UILabel, errorMessge: String) {
        label.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        label.text = errorMessge
        hiddenLabel.isHidden = true
    }
}


