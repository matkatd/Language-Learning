//
//  TopicLessonView.swift
//  Language Learning
//
//  Created by David T on 10/24/24.
//

import SwiftUI

struct TopicLessonView: View {
    let topic: LanguageLearning.Topic
    @EnvironmentObject var learningController: LearningViewModel

    var body: some View {
        VStack {
            Text("\(topic.lessonText)")
            Spacer()
            VStack {
                NavigationLink {
                    FlashcardsScreen(topic: topic)
                } label: {
                    Text("Practice with Flashcards")
                        .padding()
                        .foregroundStyle(.white)
                }
                    .background(Color(.lightLearningBlue))
                    .cornerRadius(8)
                    
                NavigationLink {
                    QuizScreen(topic: topic)
                } label: {
                    Text("Take the Quiz")
                        .padding()
                        .foregroundStyle(.white)
                        
                }
                    .background(Color(.lightLearningBlue))
                    .cornerRadius(8)
            }
        }
        .navigationTitle("\(topic.title)")
        .padding()
    }
        
}
