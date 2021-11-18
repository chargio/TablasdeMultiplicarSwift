//
//  Questionnaire.swift
//  TablasdeMultiplicar
//
//  Created by Sergio Ocón Cárdenas on 4/11/21.
//

import SwiftUI
import Combine

struct TopRow: View {
    @Binding var showingQuestionnaire: Bool
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                showingQuestionnaire = false
            }){
                Image(systemName: "xmark.circle")
                    .font(.title)
            }
        }.padding()
    }
}


struct ScoreRow: View {
    @ObservedObject var questionnaire: Questionnaire
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                Text("Quedan:")
                    .bold()
                Text(String(questionnaire.remaining))
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .clipShape(Circle())
            }
            Spacer()
            VStack {
                Text("Bien")
                    .bold()
                Text(String(questionnaire.correct))
                    .padding()
                    .foregroundColor(.white)
                    .background(.green)
                    .clipShape(Circle())
            }
            VStack {
                Text("Mal")
                    .bold()
                Text(String(questionnaire.incorrect))
                    .padding()
                    .foregroundColor(.white)
                    .background(.red)
                    .clipShape(Circle())
            }
            
            
        }.padding()
    }
}

struct NextQuestion: View {
    @ObservedObject var questionnaire: Questionnaire
    
    var body: some View {
        HStack {
            if let q = questionnaire.currentQuestion {
                Text(q.question)
            } else {
                Text("Buen trabajo")
            }
        }
    }
}



struct QuestionnaireView: View {
    @Binding var showingQuestionnaire: Bool
    @ObservedObject var questionnaire: Questionnaire
    @State var responseStr:String = ""
    var response: Int { Int(responseStr) ?? 0}
    
    var body: some View {
        VStack{
            TopRow(showingQuestionnaire: $showingQuestionnaire)
            ScoreRow( questionnaire: questionnaire)
            Spacer()
            NextQuestion(questionnaire: questionnaire)
            
            
            if let q = questionnaire.currentQuestion {
                TextField(q.question, text: $responseStr)
                    .keyboardType(.asciiCapableNumberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onReceive(Just(responseStr)) { value in
                        let filtered = "\(value)".filter {"0123456789".contains($0)}
                        if filtered != value {
                            self.responseStr = "\(filtered)"
                        }
                    }
            }
            else{
                TextField("", text: .constant("Buen trabajo"))
            }
            
            Spacer()
            Button(action: {
                questionnaire.answerQuestion(response)
                responseStr = ""
            }){Text("Responder")}
            Spacer()
        }
    }
}

let questionnaire: Questionnaire = Questionnaire(    [
    MultiplicationQuestion(7,6),
    MultiplicationQuestion(7,3),
    MultiplicationQuestion(7,4),
    MultiplicationQuestion(7,5),
    MultiplicationQuestion(7,9),
    MultiplicationQuestion(7,1),
], correct: 7)

struct Questionnaire_Previews: PreviewProvider {
    
    static var previews: some View {
        QuestionnaireView(showingQuestionnaire: .constant(true), questionnaire:  questionnaire)
        QuestionnaireView(showingQuestionnaire: .constant(true), questionnaire:  questionnaire)
            .preferredColorScheme(.dark)
        QuestionnaireView(showingQuestionnaire: .constant(true), questionnaire:  questionnaire)
            .previewInterfaceOrientation(.landscapeLeft)
        
    }
}
