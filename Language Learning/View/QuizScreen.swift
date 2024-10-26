//
//  QuizScreen.swift
//  Language Learning
//
//  Created by David T on 10/19/24.
//

import SwiftUI

struct QuizScreen: View {
    
    @EnvironmentObject var learningController: LearningViewModel
    
    let topic: LanguageLearning.Topic
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Array((learningController.quiz(for: topic.title).enumerated())), id: \.element) { index, question in
                VStack {
                    Form {
                        Section {
                            Text("\(question.question)")
                                .font(.title)
                        }
                        Section {
                            switch question.questionType {
                            case .multipleChoice:
                                MultipleChoice(question: question, topic: topic)
                            case .trueFalse:
                                TrueFalse(question: question, topic: topic)
                            case .fillInTheBlank:
                                FillInTheBlank(question: question, topic: topic)
                            }
                        }
                        quizButton(question: question, topic: topic, selectedTab: $selectedTab)
                        
                    }
                    
                }
                .tag(index)
            }
        }
        
        
    }
}

struct quizButton: View {
    var question: LanguageLearning.QuizItem
    let topic: LanguageLearning.Topic
    @Binding var selectedTab: Int
    
    @EnvironmentObject var learningController: LearningViewModel
    
    var body: some View {
        Section {
            if (selectedTab == (learningController.quiz(for: topic.title).count) - 1) && question.hasBeenSubmitted {
                Button(action: {}) {
                    Text("View Results")
                }
            } else {
                Button(action: {
                    if question.hasBeenSubmitted {
                        moveToNextQuestion()
                    } else {
                        withAnimation(.linear) {
                            learningController.submitAnswer(question: question, topic: topic)
                        }
                    }
                }) {
                    Text(question.hasBeenSubmitted ? "Next Question" : "Submit")
                }
            }
            if (question.hasBeenSubmitted && question.choseCorrectAnswer) {
                Text("You Chose Correctly!")
                    .foregroundStyle(.green)
            } else if (question.hasBeenSubmitted && !question.choseCorrectAnswer) {
                Text("Wrong Choice!")
                    .foregroundStyle(Color(.learningRed))
            }
        }
    }
    
    func moveToNextQuestion() {
        // Move to the next question if it exists
        if selectedTab < (learningController.quiz(for: topic.title).count) - 1 {
            selectedTab += 1
        }
    }
}


#Preview {
    QuizScreen(topic: LanguageLearning.Topic(title: "test", lessonText: "lalalalalalalalalalalalal alalalalalalalalal lalalalalalalalalal",  quiz: [
        LanguageLearning.QuizItem(
            question: "Translate to Spanish: See you later.",
            answers: nil,
            correctAnswer: "Hasta luego",
            questionType: .fillInTheBlank
        ),
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
        
    ]))
}


