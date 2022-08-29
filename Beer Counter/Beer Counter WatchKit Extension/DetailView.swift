//
//  DetailView.swift
//  Beer Counter WatchKit Extension
//
//  Created by Jan Janovec on 30.07.2022.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var drink: DrinkConsumed
    @Binding var list: [DrinkConsumed]
    @Binding var offList: [Drink]
    
    var body: some View {
        VStack{
            Spacer()
            if findDrinkToDrinkConsumed(drink: drink.name).image != nil {
                findImageToDrink(drink: drink.name)
            } else if findDrinkToDrinkConsumed(drink: drink.name).emoji != nil {
                Text("\(findEmojiToDrink(drink: drink.name))")
                    .font(.system(size: 80))
            } else {
                findImageToDrink(drink: drink.name)
            }
            Spacer()
            //Buttons
            HStack(spacing: 8){
                //Minus button
                Button(action: {
                    if drink.count <= 0{
                        
                    }else {
                        drink.count = drink.count - 1
                        var position: Int = 0
                        
                        for i in list{
                            if i.name == drink.name {
                                break
                            }
                            position += 1
                        }
                        
                        list[position].count = drink.count
                        unuseDrink(drink: findDrinkToDrinkConsumed(drink: drink.name))
                        
                        if drink.count <= 0 {
                            list.remove(at: position)
                        }
                        
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
                //Count
                Spacer()
                Text("\(drink.count)")
                    .font(.system(size: 40))
                Spacer()
                //Plus button
                Button(action: {
                    drink.count = drink.count + 1
                    var position: Int = 0
                    
                    for i in list{
                        if i.name == drink.name {
                            break
                        }
                        position += 1
                    }
                    
                    list[position].count = drink.count
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
    
    private func unuseDrink(drink: Drink){
        for var item in offList {
            if item.name == drink.name {
                item.selected = false
            }
        }
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

