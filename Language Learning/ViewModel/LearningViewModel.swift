//
//  LearningViewModel.swift
//  Language Learning
//
//  Created by David T on 10/17/24.
//

import Foundation

@Observable class LearningViewModel {
    // MARK: - Properties
    private var learningModel: LanguageLearning = createLearningModel()
    
    static func createLearningModel() -> LanguageLearning {
        var topics: [LanguageLearning.Topic] = []
        // Iterate over each case in LanguageTopics and create a new Topic in the list
        for topic in LanguageTopics.allCases {
            topics.append(
            LanguageLearning.Topic(
                title: topic.rawValue,
                lessonText: lessonTextByTopic[topic] ?? "",
                vocabulary: vocabularyByTopic[topic] ?? [:],
                quiz: quizzesByTopic[topic] ?? []))
        }
        return LanguageLearning(topics: topics)
    }
    
    // MARK: - Model Access
    
    var topics: [LanguageLearning.Topic] {
        learningModel.topics
    }
    
    
}
