//
//  PickNewDrinkView.swift
//  Beer Counter WatchKit Extension
//
//  Created by Jan Janovec on 29.07.2022.
//

import SwiftUI

struct PickNewDrinkView: View {
    @Binding var drinksList: [DrinkConsumed]
    @Binding var sheetPresented: Bool
    
    @Binding var offList: [Drink]
    
    var body: some View {
        
        List{
            ForEach(offList, id: \.self) { drink in
                if drink.selected == false {
                    Button(action: {
                        addDrink(drink: drink)
                        sheetPresented = false
                    }){
                        Text("\(drink.name)")
                        
                    }
                }
            }
        }
    }
    
    private func addDrink(drink: Drink){
        
        
        let item = DrinkConsumed(id: UUID(), count: 1, name: drink.name)
        drinksList.append(item)
        
        for var item in offList {
            if item.name == drink.name {
                item.selected = true
            }
        }
        
        do {
            
            let data = try JSONEncoder().encode(drinksList)
            let url = getDocumentDocumentary().appendingPathComponent("drinksList")
            try data.write(to: url)
        } catch {
            print("Saving failed.")
        }
    }
    
    private func load(){
        DispatchQueue.main.async {
            do {
                let url = getDocumentDocumentary().appendingPathComponent("drinksList")
                let data = try Data(contentsOf: url)
                drinksList = try JSONDecoder().decode([DrinkConsumed].self, from: data)
            } catch {
                print("Could not load the data.")
            }
        }
    }
    
    
    
    func getDocumentDocumentary() -> URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}
