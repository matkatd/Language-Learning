//
//  TrueFalse.swift
//  Language Learning
//
//  Created by David T on 10/22/24.
//

import SwiftUI

struct TrueFalse: View {
    let question: LanguageLearning.QuizItem
    let topic: LanguageLearning.Topic
    
    var body: some View {
        SelectButton(text: "True", topic: topic, question: question, isCorrectAnswer: question.correctAnswer == "True")
        SelectButton(text: "False", topic: topic, question: question, isCorrectAnswer: question.correctAnswer == "False")
    }
}

