//
//  MaterialService.swift
//  MaterialWeightCalculator
//
//  Created by Allen Whearry on 5/20/18.
//  Copyright © 2018 Allen Whearry. All rights reserved.
//

import Foundation

class MaterialService {
    static let instance = MaterialService()
    
    let materials = [
        Material(title: "", factor: 0.0),
        Material(title: "Nylon", factor: 0.041),
        Material(title: "Acrylic", factor: 0.0436),
        Material(title: "Polycarbonate", factor: 0.0436),
        Material(title: "PETG", factor: 0.0465),
        Material(title: "HIPS", factor: 0.039),
        Material(title: "Mylar/Melinax Film", factor: 0.05),
        Material(title: "Calendard Vinyl", factor: 0.051),
        Material(title: "ABS", factor: 0.0376),
        Material(title: "APVC", factor: 0.05),
        Material(title: "Acetal", factor: 0.051),
        Material(title: "Expanded/Foam PVC (FPVC)", factor: 0.028),
        Material(title: "UHMW", factor: 0.034),
        Material(title: "HDPE", factor: 0.036),
        Material(title: "LDPE", factor: 0.034),
        Material(title: "PVC", factor: 0.051),
        Material(title: "Polypropylene", factor: 0.033),
        Material(title: "Urethane", factor: 0.043),
        Material(title: "PEI (Ultem)", factor: 0.046),
        Material(title: "Noryl", factor: 0.0407),
        Material(title: "PVDF", factor: 0.063),
        Material(title: "Phenolic C or CE", factor: 0.0515),
        Material(title: "Phenolic L or LE", factor: 0.051),
        Material(title: "Phenolic X or XX", factor: 0.049),
        Material(title: "PTFE", factor: 0.076),
        Material(title: "Acetate", factor: 0.04881)
    ]
    
    func getMaterials() -> [Material] {
        return materials.sorted(by: {$0.title < $1.title})
    }
}
