//
//  CalculationErrors.swift
//  MaterialWeightCalculator
//
//  Created by Allen Whearry on 6/6/18.
//  Copyright © 2018 Allen Whearry. All rights reserved.
//

import Foundation

/// Errors which may occur during calculation of material weight
///
/// - zeroValue: Zero is passed to any of calculations arguments
/// - invalidInput: Input provided cannot be cast to a Double
/// - wallGreaterThanOutterField: Tube material's wall thickness is greater than the ouuter diameter or square width.
enum CalculationError: Error {
    case zeroValue
    case invalidInput
    case wallGreaterThanOutterField(outterField: String)
}
