//
//  FillInTheBlank.swift
//  Language Learning
//
//  Created by David T on 10/22/24.
//


import SwiftUI

struct FillInTheBlank: View {
    let question: LanguageLearning.QuizItem
    
    @State private var currentFillInAnswer: String = ""
    
    var body: some View {
        TextField("fill in the blank", text: $currentFillInAnswer)
    }
}
