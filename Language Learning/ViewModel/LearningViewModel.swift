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
        
        return LanguageLearning(languageLearningFactory: topics)
    }
    
    private func createDeck(with vocabulary: VocabDictionary) -> [LanguageLearning.Card] {
        var cards: [LanguageLearning.Card] = []
        for (word, definition) in vocabulary {
            cards.append(LanguageLearning.Card(isFaceUp: false, word: word, definition: definition))
        }
        return cards.shuffled()
    }
    
    
    // MARK: - Computed Properties
   
    
    // MARK: - User Intents
    func flipCard(card: LanguageLearning.Card) {
        withAnimation(.easeIn(duration: Constants.animationDuration)) {
            learningModel.flipCard(card: card)
        }
    }
    
    
    
    func submitAnswer(question: LanguageLearning.QuizItem) {
        withAnimation(.linear) {
            learningModel.submitAnswer(question: question)
        }
    }
    
    func selectAnswer(question: LanguageLearning.QuizItem, answer: String) {
        withAnimation(.linear) {
            learningModel.selectAnswer(question: question, answer: answer)
        }
    }
    
    
    func setSelectedTopic(topic: LanguageLearning.Topic ) {
        learningModel.selectedTopic = topic
        learningModel.cards = createDeck(with: topic.vocabulary)
    }
    
    
    // MARK: - Model Access
    
    var topics: [LanguageLearning.Topic] {
        learningModel.topics
    }
    
    var selectedTopic: LanguageLearning.Topic? {
        learningModel.selectedTopic
    }
    
    var vocabList: Array<LanguageLearning.Card>  {
        learningModel.cards
    }
    
    
    // MARK: - Constants
    
    private struct Constants {
        static let animationDuration = 20.0
    }
    
}
