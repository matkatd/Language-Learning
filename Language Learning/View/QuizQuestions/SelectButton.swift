//
//  SelectButton.swift
//  Language Learning
//
//  Created by David T on 10/22/24.
//

import SwiftUI

struct SelectButton: View {
    let text: String
    let topic: LanguageLearning.Topic
    let question: LanguageLearning.QuizItem
    
    @EnvironmentObject var learningController: LearningViewModel
    
    var isCorrectAnswer: Bool
    
    var backgroundColor: Color {
        if !question.hasBeenSubmitted {
            return question.selectedOption == text ? Color(.lightLearningBlue) : Color.white
        } else if question.choseCorrectAnswer {
            return question.selectedOption == text ? .green : .white
        } else {
            return question.selectedOption == text ? Color(.learningRed) : .white
        }
    }
    
    var borderColor: Color {
        if question.hasBeenSubmitted && !question.choseCorrectAnswer && isCorrectAnswer {
            return .green
        } else {
            return .white
        }
    }

    var body: some View {
        Button(action: {
            learningController.selectAnswer(question: question, answer: text, topic: topic)
        }) {
            HStack {  
                Text(text)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: 1)
            )
            .modifier(Shake(shakes: question.hasBeenSubmitted && !question.choseCorrectAnswer && text == question.selectedOption ? -2 : 0))
            .background(backgroundColor)
            .cornerRadius(8)
        }
        .disabled(question.hasBeenSubmitted)
        .buttonStyle(PlainButtonStyle())
    }
}
