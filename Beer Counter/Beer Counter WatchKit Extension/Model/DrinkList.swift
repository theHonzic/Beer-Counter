//
//  Drink.swift
//  Beer Counter WatchKit Extension
//
//  Created by Jan Janovec on 29.07.2022.
//

import SwiftUI
import Foundation

class Drink: Hashable{
    static func == (lhs: Drink, rhs: Drink) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    
    
    var name: String
    var selected: Bool
    var image: Image?
    var emoji: String?
    
    init(name: String, selected: Bool, image: Image){
        self.name = name
        self.selected = selected
        self.image = image
    }
    init(name: String, selected: Bool, emoji: String){
        self.name = name
        self.selected = selected
        self.emoji = emoji
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

class Drinks{
    var drinkList: [Drink] = [
        Drink(name: "Beer", selected: false, emoji: "🍺"),
        Drink(name: "Wine", selected: false, emoji: "🍷"),
        Drink(name: "Rum", selected: false, emoji: "🥃"),
        Drink(name: "Vodka", selected: false, emoji: "🍸"),
        Drink(name: "Gin", selected: false, emoji: "🍸"),
        Drink(name: "Slivovice", selected: false, emoji: "🍸"),
        Drink(name: "Brandy", selected: false, emoji: "🥃"),
        Drink(name: "Whiskey", selected: false, emoji: "🥃"),
        Drink(name: "Cognac", selected: false, emoji: "🥃"),
        Drink(name: "Champagne", selected: false, emoji: "🥂"),
        Drink(name: "Tequilla", selected: false, emoji: "🍸"),
        Drink(name: "Absinthe", selected: false, emoji: "☠️"),
        Drink(name: "Jagermeister", selected: false, emoji: "🦌"),
        Drink(name: "Spritz", selected: false, emoji: "🍹"),
        Drink(name: "Sake", selected: false, emoji: "🍶")



    ]
}
