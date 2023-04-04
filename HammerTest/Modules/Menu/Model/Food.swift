//
//  Food.swift
//  HammerTest
//
//  Created by Paul Ive on 03.04.23.
//

import Foundation

struct FoodElement: Codable {
    let id: Int
    let type, name, description: String
    let price: Double
}
