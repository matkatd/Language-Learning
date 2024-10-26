//
//  MultipleChoice.swift
//  Language Learning
//
//  Created by David T on 10/22/24.
//

import SwiftUI

struct MultipleChoice: View {
    let question: LanguageLearning.QuizItem
    let topic: LanguageLearning.Topic
    
    var body: some View {
        if let answers = question.answers {
            ForEach(Array(answers.enumerated()), id: \.element) { index, answer in
                HStack {
                    SelectButton(text: "\(answer)", topic: topic,
                                 question: question, isCorrectAnswer: question.correctAnswer == answer)
                }
            }
        } else {
            Text("No answers available")
                
        }
    }

}

