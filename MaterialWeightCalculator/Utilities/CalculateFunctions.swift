//
//  utils.swift
//  MaterialWeightCalculator
//
//  Created by Allen Whearry on 5/21/18.
//  Copyright © 2018 Allen Whearry. All rights reserved.
//

import Foundation


func calculateSheet(factor: Double, thickness: String, width: String, length: String) -> Double {
    let calculatedValue = round((factor * Double(thickness)! * Double(width)! * Double(length)!) * 1000) / 1000
    return calculatedValue
}

func calculateRoundRod(factor: Double, diameter: String, length: String ) -> Double {
    let PI = Double.pi
    let radius = Double(diameter)! / 2
    let length = Double(length)!
    let volume = PI * pow(radius, 2) * length
    let calclatedValue = round((factor * volume) * 1000) / 1000
    
    return calclatedValue
}


func calculateSquareRod(factor: Double, width: String, length: String) -> Double {
    let calculatedValue = round((factor * (Double(width)! * 2) * Double(length)!) * 1000) / 1000
    return calculatedValue
}

func calculateRoundTube(factor: Double, outsideDiameter: String, wall: String?, insideDiameter: String?, length: String) -> Double {
    if wall == "" && insideDiameter != "" {
        let odVal = calculateRoundRod(factor: factor, diameter: outsideDiameter, length: length)
        let idVal = calculateRoundRod(factor: factor, diameter: insideDiameter!, length: length)
        return odVal - idVal
    } else {
        let id = String(Double(outsideDiameter)! - (Double(wall!)! * 2.0))
        let odVal = calculateRoundRod(factor: factor, diameter: outsideDiameter, length: length)
        let idVal = calculateRoundRod(factor: factor, diameter: id, length: length)
        return odVal - idVal
    }
    
}

func calculateSquareTube(factor: Double, outsideSquareWidth: String, wall: String?, insideSquareWidth: String?, length: String) -> Double {
    if wall == "" && insideSquareWidth != "" {
        let osWidth = calculateSquareRod(factor: factor, width: outsideSquareWidth, length: length)
        let isWidth = calculateSquareRod(factor: factor, width: insideSquareWidth!, length: length)
        return osWidth - isWidth
    } else {
        let id = String(Double(outsideSquareWidth)! - (Double(wall!)! * 2.0))
        let osWidth = calculateSquareRod(factor: factor, width: outsideSquareWidth, length: length)
        let isWidth = calculateSquareRod(factor: factor, width: id, length: length)
        return osWidth - isWidth
    }
}