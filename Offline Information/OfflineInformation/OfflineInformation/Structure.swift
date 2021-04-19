//
//  Structure.swift
//  OfflineInformation
//
//  Created by Sharvil Arjunwadkar on 15/01/21.
//

import Foundation

struct UserStructure: Identifiable, Codable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    let tags: [String]
    let friends: [FriendStructure]
//    var formattedDate: String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
//        if let date = formatter.date(from: registered){
//            return String("\(date)")
//        }
//        return registered
//    }
}

struct FriendStructure: Identifiable, Codable {
    var id: String
    var name: String
}
//struct UserSt: Codable, Identifiable{
//    struct FriendSt: Codable, Identifiable{
//        var id: String
//        var name: String
//    }
//
//
//    var id: String
//    var isActive: Bool
//    var name: String
//    var age: Int
//    var company: String
//    var email: String
//    var address: String
//    var about: String
//
//}
