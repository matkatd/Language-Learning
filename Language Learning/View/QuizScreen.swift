//
//  QuizScreen.swift
//  Language Learning
//
//  Created by David T on 10/19/24.
//

import SwiftUI

struct QuizScreen: View {
    
    @EnvironmentObject var learningController: LearningViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Array((learningController.selectedTopic?.quiz.enumerated())!), id: \.element) { index, question in
                VStack {
                    Form {
                        Section {
                            Text("\(question.question)")
                                .font(.title)
                        }
                        Section {
                            switch question.questionType {
                            case .multipleChoice:
                                MultipleChoice(question: question
                                )
                            case .trueFalse:
                                TrueFalse(question: question
                                )
                            case .fillInTheBlank:
                                FillInTheBlank(question: question
                                )
                            }
                        }
                        Section {
                            if (selectedTab == (learningController.selectedTopic?.quiz.count ?? 0) - 1) && question.hasBeenSubmitted {
                                Button(action: {}) {
                                    Text("View Results")
                                }
                            } else {
                                Button(action: {
                                    if question.hasBeenSubmitted {
                                        moveToNextQuestion()
                                    } else {
                                        withAnimation(.linear) {
                                            learningController.submitAnswer(question: question)
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
                }
                .tag(index)
            }
        }
    }
    
    func moveToNextQuestion() {
        // Move to the next question if it exists
        if selectedTab < (learningController.selectedTopic?.quiz.count ?? 0) - 1 {
            selectedTab += 1
        }
    }
}




#Preview {
    QuizScreen()
}

//topic: LanguageLearning.Topic(title: "test", lessonText: "lalalalalalalalalalalalal alalalalalalalalal lalalalalalalalalal", vocabulary: ["hola": "hello", "adios": "goodbye"], quiz: [
//LanguageLearning.QuizItem(
//    question: "Translate to Spanish: See you later.",
//    answers: nil,
//    correctAnswer: "Hasta luego",
//    questionType: .fillInTheBlank
//),
//LanguageLearning.QuizItem(
//    question: "What does 'Hola' mean?",
//    answers: ["Goodbye", "Good morning", "Hello", "See you later"],
//    correctAnswer: "Hello",
//    questionType: .multipleChoice
//),
//LanguageLearning.QuizItem(
//    question: "'Adiós' means goodbye.",
//    answers: nil,
//    correctAnswer: "True",
//    questionType: .trueFalse
//),
//
//])
