//
//  DetailView.swift
//  Beer Counter WatchKit Extension
//
//  Created by Jan Janovec on 30.07.2022.
//

import SwiftUI

struct DetailView: View {
    @Binding var drink: DrinkConsumed
    var index: Int
    @Binding var list: [DrinkConsumed]
    
    var body: some View {
        VStack{
            Spacer()
            if findDrinkToDrinkConsumed(drink: drink.name).image != nil {
                findImageToDrink(drink: drink.name)
            } else if findDrinkToDrinkConsumed(drink: drink.name).emoji != nil {
                Text("\(findEmojiToDrink(drink:drink.name))")
                    .font(.system(size: 80))
            }
            Spacer()
            HStack(spacing: 8){
                Button(action: {
                    if drink.count <= 0{
                        
                    }else {
                        drink.count = drink.count - 1
                        
                        list[index].count = drink.count
                        
                        do {
                            
                            let data = try JSONEncoder().encode(list)
                            let url = getDocumentDocumentary().appendingPathComponent("drinksList")
                            try data.write(to: url)
                        } catch {
                            print("Saving failed.")
                        }
                        
                    }
                }){
                    Image(systemName: "minus.circle")
                }
                .buttonStyle(BorderedButtonStyle(tint: .red))
                Spacer()
                Text("\(drink.count)")
                    .font(.system(size: 40))
                Spacer()
                Button(action: {
                    drink.count = drink.count + 1
                    
                    list[index].count = drink.count
                    
                    do {
                        
                        let data = try JSONEncoder().encode(list)
                        let url = getDocumentDocumentary().appendingPathComponent("drinksList")
                        try data.write(to: url)
                    } catch {
                        print("Saving failed.")
                    }
                    
                }){
                    Image(systemName: "plus.circle")
                }
                .buttonStyle(BorderedButtonStyle(tint: .green))            }
        }
        .navigationBarTitle("\(drink.name)")
    }
    
    private func findDrinkToDrinkConsumed(drink: String) -> Drink{
        var item: Drink = Drink(name: "", selected: false, emoji: "")
        for i in Drinks().drinkList {
            if i.name == drink {
                item = i
            }
        }
        return item
    }
    
    private func findImageToDrink(drink: String) -> Image{
        var image: Image = Image("")
        image = findDrinkToDrinkConsumed(drink: drink).image!
        return image
    }
    
    private func findEmojiToDrink(drink: String) -> String{
        var emoji: String = ""
        emoji = findDrinkToDrinkConsumed(drink: drink).emoji!
        return emoji
    }
    
    func getDocumentDocumentary() -> URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}

