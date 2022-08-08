//
//  ContentView.swift
//  TimeConverter
//
//  Created by Nathan Ireland on 8/6/22.
//

import SwiftUI

struct ContentView: View {
    @State private var hoursAmount = 1.0
    @State private var conversionUnit = "Min"
    
    @FocusState private var amountIsFocused: Bool
    
    var conversionAmount: Double {
        var finalAmount = 0.0
        
        switch conversionUnit {
        case "Min":
            finalAmount = hoursAmount * 60.0
        case "Secs":
            finalAmount = (hoursAmount * 60.0) * 60
        case "Days":
            finalAmount = hoursAmount / 24
        case "Weeks":
            finalAmount = (hoursAmount / 24) / 7
        default:
            finalAmount = 0
        }
        
        return finalAmount
    }
    
    let conversionUnits = ["Weeks", "Days", "Min", "Secs"]
    
    var body: some View {
        VStack {
            NavigationView{
                Form{
                    Section {
                        TextField("Hours", value: $hoursAmount, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    } header: {
                        Text("Number of Hours")
                    }
                    
                    Section {
                        Picker("Tip percentage", selection: $conversionUnit) {
                            ForEach(conversionUnits, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    
                    Section {
                        Text(conversionAmount, format: .number)
                    } footer: {
                        Text("\(conversionUnit)")
                    }
                }
                .navigationTitle("Time Converter")
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        Button("Done"){
                            amountIsFocused = false
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
