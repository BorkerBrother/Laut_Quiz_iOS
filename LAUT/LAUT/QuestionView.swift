//
//  QuestionView.swift
//  LAUT
//
//  Created by Borker on 23.11.23.
//

import SwiftUI
import Foundation

struct Question : Identifiable{
    let id = UUID()
    let title: String
    let answer: String
    let options: [String]
    var selection: String?
}

struct QuestionView : View{
    @Binding var question: Question
    
    var body: some View{
        VStack(alignment: .leading, spacing: 20) {
            Text(question.title)
            
            ForEach(question.options, id: \.self ) {option in
                HStack {
                    Button {
                        question.selection = option
                        print(option)
                        print("Current selection: \(question.selection ?? "nil")")
                    } label: {
                        if question.selection == option {
                            Circle()
                                .shadow(radius: 3)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.blue) // Oder eine andere Standardfarbe
                        } else {
                            Circle()
                                .stroke()
                                .shadow(radius: 3)
                                .frame(width: 24, height: 24)
                        }
                    }

                    
                    Text(option)
                }
                
                
            }
        }
        .foregroundColor(Color(uiColor: .secondaryLabel))
        .padding(.horizontal,20)
        .frame(width: 330, height: 550, alignment: .leading)
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(20)
        .shadow(radius: 10)
    }
    
        
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(question: .constant(Question(title: "Sample Question", answer: "A", options: ["A", "B", "C", "D"], selection: nil)))
    }
}
