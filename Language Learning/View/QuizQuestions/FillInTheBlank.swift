//
//  FillInTheBlank.swift
//  Language Learning
//
//  Created by David T on 10/22/24.
//


import SwiftUI

struct FillInTheBlank: View {
    let question: LanguageLearning.QuizItem
    let topic: LanguageLearning.Topic
    
    @EnvironmentObject var learningController: LearningViewModel

    @State var selectedOption: String = "" {
        didSet (newValue) {
            learningController.selectAnswer(question: question, answer: newValue, topic: topic)
        }
    }
    
    var borderColor: Color {
        if !question.hasBeenSubmitted {
            return .primary
            } else {
                return question.choseCorrectAnswer ? .green : Color(.learningRed)
            }
        }
    
    var body: some View {
            TextField("fill in the blank", text: $selectedOption)
            .disabled(question.hasBeenSubmitted)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(borderColor, lineWidth: 1) 
                )
                .modifier(Shake(shakes: question.hasBeenSubmitted && !(question.choseCorrectAnswer) ? -2 : 0))
        

        
    }
}
