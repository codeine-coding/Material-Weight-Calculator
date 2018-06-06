//
//  ApplicationExtensions.swift
//  MaterialWeightCalculator
//
//  Created by Allen Whearry on 6/6/18.
//  Copyright © 2018 Allen Whearry. All rights reserved.
//

import Foundation

extension Double {
    
    var round4DecimalPlaces: Double {
        return Darwin.round(self * 1000.0) / 1000
    }
}
