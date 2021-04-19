//
//  Structure.swift
//  MeetUp
//
//  Created by Sharvil Arjunwadkar on 19/01/21.
//

import Foundation

struct Photo: Identifiable, Codable {
    let id = UUID()
    let name: String
    let description: String
    let imageId: String
}
