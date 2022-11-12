//
//  CommentModel.swift
//  LivreOr
//
//  Created by apprenant1 on 24/10/2022.
//

import Foundation

//struct LivreOR: Codable {
//    var message: [Message]
//}
struct MessageData: Codable{
//    var row: Row
    var message: [Message]
}

struct Message: Codable, Identifiable {
    let id: Int
    let content: String
//    let createdAt: String?
}


