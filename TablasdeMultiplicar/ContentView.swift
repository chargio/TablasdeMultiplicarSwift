//
//  ContentView.swift
//  TablasdeMultiplicar
//
//  Created by Sergio Ocón Cárdenas on 29/10/21.
//

import SwiftUI


struct TableRow {
    var number: Int
    var selected: Bool
}


struct TableRowView: View {
    
    @Binding var number: Int
    @Binding var selected: Bool
    
    var body: some View {
        Toggle(String(number), isOn: $selected)
            .toggleStyle(.button)
    }
}

struct ContentView: View {
    
    @State var tableList = [
        TableRow(number: 1, selected: false),
        TableRow(number: 2, selected: false),
        TableRow(number: 3, selected: false),
        TableRow(number: 4, selected: false),
        TableRow(number: 5, selected: false),
        TableRow(number: 6, selected: false),
        TableRow(number: 7, selected: false),
        TableRow(number: 8, selected: false),
        TableRow(number: 9, selected: false),
        TableRow(number: 10, selected: false)
    ]
    
    var body: some View {
        VStack {
           
            List($tableList, id: \.number) { $table in
                TableRowView(number: $table.number, selected: $table.selected)
                    .frame(width: 40)
            }

            Button(action: {}) {
                Text("Empezar")
            }
            .padding()        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().preferredColorScheme(.dark)
        ContentView().previewInterfaceOrientation(.landscapeLeft)
    }
}
