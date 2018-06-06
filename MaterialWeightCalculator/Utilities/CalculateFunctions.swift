//
//  utils.swift
//  MaterialWeightCalculator
//
//  Created by Allen Whearry on 5/21/18.
//  Copyright © 2018 Allen Whearry. All rights reserved.
//

import Foundation


/// Function to return the calculated weight of sheet/bar material.
///
/// - Parameters:
///   - factor: Value multiplied against the volume of material.
///   - thickness: Gauge or height of material in inches.
///   - width: How wide material is in inches.
///   - length: How long material is in inches.
/// - Returns: Weight in pounds with four decimal point precision.
/// - Throws: An error of type CalculationError.
func calculateSheet(factor: Double, thickness: String, width: String, length: String) throws -> Double {
    guard let thickness = Double(thickness), let width = Double(width), let length = Double(length) else {
        throw CalculationError.invalidInput
    }
    guard thickness != 0, width != 0, length != 0 else {
        throw CalculationError.zeroValue
    }
    let volume = thickness * width * length
    return (factor * volume).roundMax4DecimalPlaces
}

/// Function to return the calculated weight of a round rod.
///
/// - Parameters:
///   - factor: Value multiplied against the volume of material.
///   - diameter: diameter of rod in inches
///   - length: How long material is in inches
/// - Returns: Weight in pounds with four decimal point precision.
/// - Throws: An error of type CalculationError.
func calculateRoundRod(factor: Double, diameter: String, length: String ) throws -> Double {
    guard let diameter = Double(diameter), let length = Double(length) else {
        throw CalculationError.invalidInput
    }
    guard diameter != 0, length != 0 else {
        throw CalculationError.zeroValue
    }
    let PI = Double.pi
    let radius = diameter / 2
    let volume = PI * pow(radius, 2) * length
    return (factor * volume).roundMax4DecimalPlaces
}

/// Function to return the calculated weight of a round tube
///
/// - Parameters:
///   - factor: Value multiplied against the volume of material.
///   - outsideDiameter: Diameter of outer circle of material.
///   - wall: Thickness of actual material between outside diameter and inside diamter.
///   - length: How long material is in inches
/// - Returns: Weight in pounds with four decimal point precision.
/// - Throws: An error of type CalculationError.
func calculateRoundTube(factor: Double, outsideDiameter: String, wall: String, length: String) throws -> Double {
    guard let outsideDiameter = Double(outsideDiameter), let wall = Double(wall), let length = Double(length) else {
        throw CalculationError.invalidInput
    }
    guard outsideDiameter != 0, wall != 0, length != 0 else {
        throw CalculationError.zeroValue
    }
    guard outsideDiameter > wall else {
        throw CalculationError.wallGreaterThanOutterField(outterField: "outter diameter")
    }
    
    let id = String(outsideDiameter - (wall * 2.0))
    let odVal = try! calculateRoundRod(factor: factor, diameter: String(outsideDiameter), length: String(length))
    let idVal = try! calculateRoundRod(factor: factor, diameter: id, length: String(length))
    return (odVal - idVal).roundMax4DecimalPlaces
    
}


/// Function to return the calculated weight of a square rod.
///
/// - Parameters:
///   - factor: Value multiplied against the volume of material.
///   - width: How wide material is in inches.
///   - length: How long material is in inches.
/// - Returns: Weight in pounds with four decimal point precision.
func calculateSquareRod(factor: Double, width: Double, length: Double) -> Double {
    return (factor * (width * 2) * length).roundMax4DecimalPlaces
}


/// Function to return the calculated weight of a Square tube
///
/// - Parameters:
///   - factor: Value multiplied against the volume of material.
///   - outsideSquareWidth: Width of outer squaree of material.
///   - wall: Thickness of actual material between outside square and inside square.
///   - length: How long material is in inches
/// - Returns: Weight in pounds with four decimal point precision.
/// - Throws: An error of type CalculationError.
func calculateSquareTube(factor: Double, outsideSquareWidth: String, wall: String, length: String) throws -> Double {
    guard let outsideSquareWidth = Double(outsideSquareWidth), let wall = Double(wall), let length = Double(length) else {
        throw CalculationError.invalidInput
    }
    guard outsideSquareWidth != 0, wall != 0, length != 0 else {
        throw CalculationError.zeroValue
    }
    guard outsideSquareWidth > wall else {
        throw CalculationError.wallGreaterThanOutterField(outterField: "outer square width")
    }
    let id = outsideSquareWidth - (wall * 2.0)
    let osWidth = calculateSquareRod(factor: factor, width: outsideSquareWidth, length: length)
    let isWidth = calculateSquareRod(factor: factor, width: id, length: length)
    return (osWidth - isWidth).roundMax4DecimalPlaces
}
