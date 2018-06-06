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

func calculateRoundTube(factor: Double, outsideDiameter: String, wall: String, length: String) -> Double {
    let id = String(Double(outsideDiameter)! - (Double(wall)! * 2.0))
    let odVal = calculateRoundRod(factor: factor, diameter: outsideDiameter, length: length)
    let idVal = calculateRoundRod(factor: factor, diameter: id, length: length)
    let calculatedValue =  round((odVal - idVal) * 1000) / 1000
    return calculatedValue
    
}

func calculateSquareTube(factor: Double, outsideSquareWidth: String, wall: String, length: String) -> Double {
    let id = String(Double(outsideSquareWidth)! - (Double(wall)! * 2.0))
    let osWidth = calculateSquareRod(factor: factor, width: outsideSquareWidth, length: length)
    let isWidth = calculateSquareRod(factor: factor, width: id, length: length)
    let calculatedValue = round((osWidth - isWidth) * 1000) / 1000
    return calculatedValue
}
