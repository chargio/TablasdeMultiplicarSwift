//
//  ContentView.swift
//  TablasdeMultiplicar
//
//  Created by Sergio Ocón Cárdenas on 29/10/21.
//

import SwiftUI


struct TableRowView: View {
    
    @Binding var number: Int
    @Binding var selected: Bool
    
    var body: some View {
        Toggle(String(number), isOn: $selected)
            .clipShape(Circle())
            .frame(width: 70)
            .toggleStyle(.button)
    }
}


struct ContentView: View {
    @State var tableList = TablesList.tables
    @ObservedObject var questionnaire = Questionnaire()
    
    @State var showingQuestionnaire: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                
                Text("¿Qué tablas quieres practicar?")
                    .font(.title)
                    .bold()
                let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .center) {
                        ForEach($tableList, id: \.number) { $table in
                            TableRowView(number: $table.number, selected: $table.selected)
                        }
                    }.font(.title2)
                }
                Spacer()
                Button(action:{
                    let tables = tableList.filter{$0.selected == true}.map{$0.number}
                    
                    var questions: [MultiplicationQuestion] = []
                    
                    for i in 1...10 {
                        for j in tables {
                            questions.append(MultiplicationQuestion(i,j))
                        }
                    }
                    questionnaire.questions = questions.shuffled()
                    showingQuestionnaire = true
                    
                }) {
                    Text("Empezar")
                    
                }
                .padding()
                .background(.red)
                .foregroundColor(.white)
                .font(.title)
                Spacer()
            }.multilineTextAlignment(.center)
                .sheet(isPresented: $showingQuestionnaire) {
                    QuestionnaireView(showingQuestionnaire: $showingQuestionnaire, questionnaire: questionnaire)
                }.navigationTitle(Text("Mis tablas"))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().preferredColorScheme(.dark)
        ContentView().previewInterfaceOrientation(.landscapeLeft)
    }
}
