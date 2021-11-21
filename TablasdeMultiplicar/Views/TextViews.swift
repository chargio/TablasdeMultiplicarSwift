//
//  TextViews.swift
//  TablasdeMultiplicar
//
//  Created by Sergio Ocón Cárdenas on 4/11/21.
//

import SwiftUI

struct NumberCircle: View {
    var text: String
    var numberText: Int
    var color: Color  = .accentColor
    
    var body: some View {
        VStack(alignment: .center, spacing: .leastNonzeroMagnitude) {
            Text(text)
                .bold()
                .font(.title2)
            Text(String(numberText))
                .bold()
                .font(.title2)
                .padding()
                .foregroundColor(.white)
                .background(color)
                .clipShape(Circle())
                .frame(width: 80, height: 80)
        }.transition(.scale)
        .padding()
            
    }
}


struct Preview_Preview: View {
    var body: some View {
        HStack {
            NumberCircle(text: "Quedan:", numberText: 7, color: Color("InfoColor"))
            NumberCircle(text: "Quedan:", numberText: 7, color: Color("CorrectColor"))
            NumberCircle(text: "Quedan:", numberText: 7, color: Color("IncorrectColor"))

        }
    }
    
}

struct TextViews_Previews: PreviewProvider {
    static var previews: some View {
        Preview_Preview()
        Preview_Preview()
            .preferredColorScheme(.dark)
        
    }
}
