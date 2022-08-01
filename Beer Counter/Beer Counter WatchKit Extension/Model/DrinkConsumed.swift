//
//  DrinkConsumed.swift
//  Beer Counter WatchKit Extension
//
//  Created by Jan Janovec on 29.07.2022.
//

import Foundation

struct DrinkConsumed: Identifiable, Codable {
    var id: UUID
    var count: Int
    var name: String
}
