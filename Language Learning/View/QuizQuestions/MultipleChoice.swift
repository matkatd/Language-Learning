//
//  MultipleChoice.swift
//  Language Learning
//
//  Created by David T on 10/22/24.
//

import SwiftUI

struct MultipleChoice: View {
    let question: LanguageLearning.QuizItem
    
    @State private var selectedOption: String = ""
    
    var body: some View {
        if let answers = question.answers {
            ForEach(Array(answers.enumerated()), id: \.element) { index, answer in
                HStack {

                    RadioButton(text: "\(labelForIndex(index)). \(answer)", selectedOption: $selectedOption)
                }
            }
        } else {
            Text("No answers available")
                
        }
    }
    
    // Helper function to convert index to a letter (a, b, c, ...)
    func labelForIndex(_ index: Int) -> String {
        let alphabet = "abcdefghijklmnopqrstuvwxyz"
        guard index < alphabet.count else { return "" }
        return String(alphabet[alphabet.index(alphabet.startIndex, offsetBy: index)])
    }
}

struct RadioButton: View {
    let text: String
    @Binding var selectedOption: String

    var body: some View {
        Button(action: {
            selectedOption = text
        }) {
            HStack {
                Text(text)
                    .foregroundColor(.black)
                Spacer()
                Circle()
                    .stroke(selectedOption == text ? Color.blue : Color.gray, lineWidth: 2)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .fill(selectedOption == text ? Color.blue : Color.clear)
                            .frame(width: 12, height: 12)
                    )
            }
            .padding()  // Optional: Add some padding to make the button area larger
        }
        .buttonStyle(PlainButtonStyle()) // Remove default button styling
    }
}
