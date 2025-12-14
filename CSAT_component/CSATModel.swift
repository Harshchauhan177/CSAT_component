//
//  CSATModel.swift
//  CSAT_component
//
//  Created by harsh chauhan on 14/12/25.
//

import Foundation

// MARK: - Model
struct CSATFeedback {
    var rating: Int
    var comment: String
    
    init(rating: Int = 0, comment: String = "") {
        self.rating = rating
        self.comment = comment
    }
}

enum CSATState {
    case initial
    case expanded
    case thankYou
}
