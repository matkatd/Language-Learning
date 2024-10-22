//
//  QuizScreen.swift
//  Language Learning
//
//  Created by David T on 10/19/24.
//

import SwiftUI

struct QuizScreen: View {
    let topic: LanguageLearning.Topic
    
    
    
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Array(topic.quiz.enumerated()), id: \.element) { index, question in
                VStack {
                    Form {
                        Text("\(question.question)")
                            .font(.title)
                        switch question.questionType {
                        case .multipleChoice:
                            MultipleChoice(question: question)
                        case .trueFalse:
                            TrueFalse(question: question)
                        case .fillInTheBlank:
                            FillInTheBlank(question: question)
                        }
                    }
                }
                .tag(index)
            }
        }
        .padding()
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
    
    
}

#Preview {
    QuizScreen(topic: LanguageLearning.Topic(title: "test", lessonText: "lalalalalalalalalalalalal alalalalalalalalal lalalalalalalalalal", vocabulary: ["hola": "hello", "adios": "goodbye"], quiz: [
        LanguageLearning.QuizItem(
            question: "What does 'Hola' mean?",
            answers: ["Goodbye", "Good morning", "Hello", "See you later"],
            correctAnswer: "Hello",
            questionType: .multipleChoice
        ),
        LanguageLearning.QuizItem(
            question: "'Adiós' means goodbye.",
            answers: nil,
            correctAnswer: "True",
            questionType: .trueFalse
        ),
        LanguageLearning.QuizItem(
            question: "Translate to Spanish: See you later.",
            answers: nil,
            correctAnswer: "Hasta luego",
            questionType: .fillInTheBlank
        )
    ]))
}
