//
//  User.swift
//  SwiftUIInPractice
//
//  Created by Adkhamjon Rakhimov on 25/11/24.
//


struct UserArray: Codable {
    let users:[User]
    let total, skip, limit: Int
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let email, phone, username, password: String
    let image: String
    let height: Double
    let weight: Double
}
