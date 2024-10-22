//
//  ContentView.swift
//  Language Learning
//
//  Created by David T on 10/10/24.
//

import SwiftUI


struct ContentView: View {
    let languageLearningViewModel: LearningViewModel
    
    
    var body: some View {
        NavigationStack {
            List(languageLearningViewModel.topics, id: \.self) { topic in
                TopicCell(topic: topic)
            }
            .navigationTitle("Learn Spanish!")
            .listStyle(.plain)
        }
    }
}

struct TopicCell: View {
    let topic: LanguageLearning.Topic
    var body: some View {
        HStack {
            NavigationLink {
                TopicLessonView(topic: topic)
            } label: {
                Text(topic.title)
            }
        }
    }
}

struct TopicLessonView: View {
    let topic: LanguageLearning.Topic

    var body: some View {
        VStack {
            Text("\(topic.lessonText)")

            NavigationLink {
                FlashcardsScreen(topicForReview: topic)
            } label: {
                Text("Practice with Flashcards")
            }
                
            NavigationLink {
                QuizScreen(topic: topic )
            } label: {
                Text("Take the Quiz")
            }
        }
        .navigationTitle("\(topic.title)")
    }
}



#Preview {
    ContentView(languageLearningViewModel: LearningViewModel())
}
