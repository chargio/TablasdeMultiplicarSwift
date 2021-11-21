//
//  Questionnaire.swift
//  TablasdeMultiplicar
//
//  Created by Sergio Ocón Cárdenas on 4/11/21.
//

import SwiftUI
import Combine





struct ScoreRow: View {
    @ObservedObject var questionnaire: Questionnaire
    
    var body: some View {
        HStack(alignment: .top) {
            NumberCircle(text: "Quedan", numberText: questionnaire.remaining, color: Color("InfoColor"))
            Spacer()
            NumberCircle(text: "Bien", numberText: questionnaire.correct, color: Color("CorrectColor"))
            NumberCircle(text: "Mal", numberText: questionnaire.incorrect, color: Color("IncorrectColor"))
          
            
        }.padding()
    }
}

struct NextQuestion: View {
    @ObservedObject var questionnaire: Questionnaire
    
    var body: some View {
        HStack {
            if let q = questionnaire.currentQuestion {
                Text(q.question)
                    .bold()
                    .font(.title)
            } else {
                Text("Buen trabajo")
            }
        }
    }
}



struct QuestionnaireView: View {
    @ObservedObject var questionnaire: Questionnaire
    @State var responseStr:String = ""
    var response: Int { Int(responseStr) ?? 0}
    
    var body: some View {
        VStack{
            Spacer()
            ScoreRow( questionnaire: questionnaire)
            Spacer()
            NextQuestion(questionnaire: questionnaire)
            
            HStack {
                Spacer()
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
                        .padding()
                        .multilineTextAlignment(.center)
                }
                else{
                    TextField("", text: .constant("Buen trabajo"))
                        .padding()
                }
                Spacer()
            }
            
            Spacer()
            Button(action: {
                questionnaire.answerQuestion(response)
                responseStr = ""
            }){Text("Responder")}
            .buttonStyle(.bordered)
            Spacer()
            
        }
    }
}



struct Questionnaire_Previews: PreviewProvider {
    static let questionnaire: Questionnaire = Questionnaire(    [
        MultiplicationQuestion(7,6),
        MultiplicationQuestion(7,3),
        MultiplicationQuestion(7,4),
        MultiplicationQuestion(7,5),
        MultiplicationQuestion(7,9),
        MultiplicationQuestion(7,1),
    ], correct: 7)
    
    static var previews: some View {
        QuestionnaireView(questionnaire:  questionnaire)
        QuestionnaireView(questionnaire:  questionnaire)
            .preferredColorScheme(.dark)
        QuestionnaireView(questionnaire:  questionnaire)
            .previewInterfaceOrientation(.landscapeLeft)
        
    }
}
