//
//  Structure.swift
//  InfoApp
//
//  Created by Sharvil Arjunwadkar on 14/01/21.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    var registered: String
    let tags: [String]
    let friends: [Friend]
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        if let date = formatter.date(from: registered){
            return String("\(date)")
        }
        return registered
    }
}

struct Friend: Identifiable, Codable {
    let id: String
    let name: String
}

