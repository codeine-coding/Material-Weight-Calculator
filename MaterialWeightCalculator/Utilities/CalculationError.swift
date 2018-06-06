//
//  CalculationErrors.swift
//  MaterialWeightCalculator
//
//  Created by Allen Whearry on 6/6/18.
//  Copyright © 2018 Allen Whearry. All rights reserved.
//

import Foundation

enum CalculationError: Error {
    case missingFactorValue
    case zeroValue
    case invalidInput
    case wallGreaterThanOutterField(outterField: String)
}
