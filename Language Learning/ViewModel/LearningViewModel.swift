//
//  LearningViewModel.swift
//  Language Learning
//
//  Created by David T on 10/17/24.
//

import SwiftUI

@Observable class LearningViewModel: ObservableObject {
    // MARK: - Properties
    private var learningModel: LanguageLearning = createLearningModel()
    
    private var lessonPlan: LessonPlan = SpanishLessonPlan()
    
    
    static func createLearningModel() -> LanguageLearning {
        var topics: [LanguageLearning.Topic] = []
        // Iterate over each case in LanguageTopics and create a new Topic in the list
        for topic in LanguageTopics.allCases {
            topics.append(
                LanguageLearning.Topic(
                    title: topic.rawValue,
                    lessonText: lessonTextByTopic[topic] ?? "",
                    cards: createDeck(with: vocabularyByTopic[topic] ?? [:]),
                    quiz: quizzesByTopic[topic] ?? []
                ))
        }
        
        return LanguageLearning(languageLearningFactory: topics)
    }
    
    private static func createDeck(with vocabulary: VocabDictionary) -> [LanguageLearning.Card] {
        var cards: [LanguageLearning.Card] = []
        for (word, definition) in vocabulary {
            cards.append(LanguageLearning.Card(isFaceUp: false, word: word, definition: definition))
        }
        return cards.shuffled()
    }
    
    
    // MARK: - Computed Properties
   
    
    // MARK: - User Intents
    func flipCard(card: LanguageLearning.Card, topic: LanguageLearning.Topic) {
        withAnimation(.easeIn(duration: Constants.animationDuration)) {
            learningModel.flipCard(card: card, selectedTopic: topic)
        }
    }
    
    func submitAnswer(question: LanguageLearning.QuizItem, topic: LanguageLearning.Topic) {
        withAnimation(.linear) {
            learningModel.submitAnswer(question: question, selectedTopic: topic)
        }
    }
    
    func selectAnswer(question: LanguageLearning.QuizItem, answer: String, topic: LanguageLearning.Topic) {
        withAnimation(.linear) {
            learningModel.selectAnswer(question: question, answer: answer, selectedTopic: topic)
        }
    }

    
    
    // MARK: - Model Access
    var topics: [Language.Topic] {
        lessonPlan.topics
    }
    
    var languageName: String {
        lessonPlan.languageName
    }
    
//    var topics: [LanguageLearning.Topic] {
//        learningModel.topics
//    }

    
    func progress(for title: String) -> Language.Progress {
        if let progressRecord = lessonPlan.progress.first(where: { $0.topicTitle == title }) {
            return progressRecord
        }
        let progressRecord = Language.Progress(topicTitle: title)
        
        lessonPlan.progress.append(progressRecord)
        
        return progressRecord
    }
    
    func vocabList(for title: String) -> [LanguageLearning.Card] {
        if let vocabList = learningModel.topics.first(where: { $0.title == title })?.cards {
            return vocabList
        }
        return []
    }
    
    
    func topic(for title: String) -> LanguageLearning.Topic? {
        if let topic = learningModel.topics.first(where: { $0.title == title }) {
            return topic
        }
        return nil
    }
    
    func quiz(for title: String) -> [LanguageLearning.QuizItem] {
        if let quiz = learningModel.topics.first(where: { $0.title == title })?.quiz {
            return quiz
        }
        return []
    }
    
    func toggleLessonRead(for title: String) {
        lessonPlan.toggleLessonRead(for: title)
    }
    
    func toggleVocabularyStudied(for title: String) {
        lessonPlan.toggleVocabularyStudied(for: title)
    }
    
    func toggleQuizPassed(for title: String) {
        lessonPlan.toggleQuizPassed(for: title)
    }
    
    func setHighScore(for title: String, score: Int) {
        lessonPlan.setHighScore(for: title, score: score)
    }
    
    // MARK: - Constants
    
    private struct Constants {
        static let animationDuration = 20.0
    }
    
}
