//
//  Product.swift
//  SwiftUIInPractice
//
//  Created by Adkhamjon Rakhimov on 25/11/24.
//

import Foundation

struct ProductArray: Codable {
    let products:[Product]
    let total, skip, limit: Int
}

struct Product: Codable, Identifiable {
    let id: Int
    let title, description: String
    let category: String
    let brand: String?
    let images: [String]
    
    var firstImage: String {
        images.first ?? Constants.randomImage
    }
}

struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}
