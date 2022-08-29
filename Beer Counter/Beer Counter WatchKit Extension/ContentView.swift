//
//  ContentView.swift
//  Beer Counter WatchKit Extension
//
//  Created by Jan Janovec on 29.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var list: [DrinkConsumed] = [DrinkConsumed]()
    @State private var isNewDrinkSheetPresented: Bool = false
    @State private var showingAlert = false
    @State private var offeredList = Drinks().drinkList
    
    var body: some View {
        
        VStack(alignment:.center, spacing: 9){
            //No drinks
            if list.isEmpty {
                Button(action: {
                    isNewDrinkSheetPresented = true
                }){
                    Image(systemName: "plus.circle")
                        .font(.system(size: 50))
                }
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
                .sheet(isPresented: $isNewDrinkSheetPresented){
                    PickNewDrinkView(drinksList: $list, sheetPresented: $isNewDrinkSheetPresented, offList: $offeredList)
                }
                Text("No drinks yet.")
            //Drinks
            }else{
                List {
                    ForEach(0..<list.count, id: \.self){ i in
                        if list[i].count > 0 {
                            NavigationLink(destination: DetailView(drink: $list[i], list: $list, offList: $offeredList)){
                                HStack{
                                    Text("\(findEmojiToDrink(drink: list[i].name)) \(list[i].name)")
                                    Spacer()
                                    Text(String(list[i].count))
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                //Buttons
                HStack{
                    //Add drink button
                    Button(action: {
                        isNewDrinkSheetPresented = true
                    }){
                        Image(systemName: "plus.circle")
                    }
                    .buttonStyle(BorderedButtonStyle(tint: .accentColor))
                    .sheet(isPresented: $isNewDrinkSheetPresented){
                        PickNewDrinkView(drinksList: $list, sheetPresented: $isNewDrinkSheetPresented, offList: $offeredList)
                    }
                    //Reset drinks
                    Button(action: {
                        showingAlert = true
                    }){
                        Image(systemName: "arrow.counterclockwise.circle")
                    }
                    .alert("Reset counting?", isPresented: $showingAlert){
                        //Confirm reset
                        Button(action:{
                            list.removeAll()
                            showingAlert = false
                            
                            do {
                                let data = try JSONEncoder().encode(list)
                                let url = getDocumentDocumentary().appendingPathComponent("drinksList")
                                try data.write(to: url)
                            } catch {
                                print("Saving failed.")
                            }
                            
                            for item in offeredList {
                                item.selected = false
                            }
                        }){
                            Text("Yes")
                        }
                        .buttonStyle(BorderedButtonStyle(tint: .red))
                        //Cancel reset
                        Button(action: {
                            showingAlert = false
                        }){
                            Text("Cancel")
                        }
                    }
                    .buttonStyle(BorderedButtonStyle(tint: .red))
                    .onAppear(perform: {load()})
                    .navigationTitle("Beer counter")
                }
            }
        }
        .navigationTitle("Beer counter")
        .onAppear(perform: {load()})
    }
    //Load data
    private func load(){
        DispatchQueue.main.async {
            do {
                let url = getDocumentDocumentary().appendingPathComponent("drinksList")
                let data = try Data(contentsOf: url)
                list = try JSONDecoder().decode([DrinkConsumed].self, from: data)
            } catch {
                print("Could not load the data.")
            }
        }
    }
    
    func getDocumentDocumentary() -> URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    private func findEmojiToDrink(drink: String) -> String{
        var emoji: String = ""
        emoji = findDrinkToDrinkConsumed(drink: drink).emoji!
        return emoji
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
}
