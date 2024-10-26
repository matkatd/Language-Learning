//
//  ContentView.swift
//  Language Learning
//
//  Created by David T on 10/10/24.
//

import SwiftUI


struct ContentView: View {
    @StateObject var learningController: LearningViewModel
    
    var body: some View {
        NavigationStack {
            List(learningController.topics, id: \.self) { topic in
                TopicCell(topic: topic)
            }
            .navigationTitle("Learn Spanish!")
            .listStyle(.plain)
        }
        .environment(learningController)
    }
}

struct TopicCell: View {
    @EnvironmentObject var learningController: LearningViewModel
    
    let topic: LanguageLearning.Topic
    var body: some View {
        HStack {
            NavigationLink {
                TopicLessonView(topic: topic)
            } label: {
                VStack(alignment: .leading) {
                    Text(topic.title)
                        .font(.headline)
                    Text("Lesson read: \(learningController.progress(for: topic.title).lessonRead)")
                        .font(.subheadline)
                }
            }
        }
    }
}


#Preview {
    ContentView(learningController: LearningViewModel())
}
