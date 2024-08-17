//
//  Product.swift
//  TestApp
//
//  Created by Tushar Ahmed on 17/8/24.
//

import Foundation

struct Product: Identifiable, Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let image: String
    let category: String
}
