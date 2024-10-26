//
//  TrueFalse.swift
//  Language Learning
//
//  Created by David T on 10/22/24.
//

import SwiftUI

struct TrueFalse: View {
    let question: LanguageLearning.QuizItem
    
    var body: some View {
        SelectButton(text: "True", question: question, isCorrectAnswer: question.correctAnswer == "True")
        SelectButton(text: "False", question: question, isCorrectAnswer: question.correctAnswer == "False")
    }
}

