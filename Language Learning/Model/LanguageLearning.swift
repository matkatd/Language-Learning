//
//  LanguageLearning.swift
//  Language Learning
//
//  Created by David T on 10/17/24.
//

import Foundation

struct LanguageLearning {
    // MARK: - Properties
    
    var progress: [Progress]

    var topics: [Topic]
    
    init(languageLearningFactory: [Topic]) {
        self.topics = languageLearningFactory
        progress = LanguageLearning.readProgressRecords()
    }
    
    // MARK: - Methods
    mutating func flipCard(card: Card, selectedTopic: Topic) {
        if let chosenTopicIndex = topics.firstIndex(where: { $0.title == selectedTopic.title }) {
            if let chosenIndex = topics[chosenTopicIndex].cards.firstIndex(of: card) {
                topics[chosenTopicIndex].cards[chosenIndex].isFaceUp.toggle()
            }
        }
    }
    
    mutating func submitAnswer(question: QuizItem, selectedTopic: Topic) {
        if let chosenTopicIndex = topics.firstIndex(where: { $0.title == selectedTopic.title }) {
            if let chosenIndex = topics[chosenTopicIndex].quiz.firstIndex(of: question) {
                topics[chosenTopicIndex].quiz[chosenIndex].hasBeenSubmitted = true
                topics[chosenTopicIndex].quiz[chosenIndex].activeQuestion = false
                if topics[chosenTopicIndex].quiz[chosenIndex].selectedOption == topics[chosenTopicIndex].quiz[chosenIndex].correctAnswer {
                    topics[chosenTopicIndex].quiz[chosenIndex].choseCorrectAnswer = true
                }
            }
        }
    }
    
    mutating func selectAnswer(question: QuizItem, answer: String, selectedTopic: Topic) {
        if let chosenTopicIndex = topics.firstIndex(where: { $0.title == selectedTopic.title }) {
            if let chosenIndex = topics[chosenTopicIndex].quiz.firstIndex(of: question) {
                topics[chosenTopicIndex].quiz[chosenIndex].activeQuestion = true
                topics[chosenTopicIndex].quiz[chosenIndex].selectedOption = answer
            }
        }
    }
    
    func getScore(selectedTopic: Topic) -> Int {
        if let chosenTopicIndex = topics.firstIndex(where: { $0.title == selectedTopic.title }) {
            return topics[chosenTopicIndex].quiz.reduce(0) { $0 + $1.score }
        }
        return 0
    }
    
    mutating func toggleLessonRead(for title: String) {
        if let index = progress.firstIndex(where: { $0.topicTitle == title }) {
            progress[index].lessonRead.toggle()
            UserDefaults.standard.set(progress[index].lessonRead, forKey: key(for: title, type: Key.lessonRead))
        } else {
            progress.append(Progress(topicTitle: title))
            toggleLessonRead(for: title)
        }
    }
    
    mutating func toggleVocabularyStudied(for title: String) {
        if let index = progress.firstIndex(where: { $0.topicTitle == title }) {
            progress[index].vocabularyStudied.toggle()
            UserDefaults.standard.set(progress[index].vocabularyStudied, forKey: key(for: title, type: Key.vocabularyStudied))
        } else {
            progress.append(Progress(topicTitle: title))
            toggleVocabularyStudied(for: title)
        }
    }
    
    mutating func toggleQuizPassed(for title: String) {
        if let index = progress.firstIndex(where: { $0.topicTitle == title }) {
            progress[index].quizPassed.toggle()
            UserDefaults.standard.set(progress[index].quizPassed, forKey: key(for: title, type: Key.quizPassed))
        } else {
            progress.append(Progress(topicTitle: title))
            toggleQuizPassed(for: title)
        }
    }
    
    mutating func setHighScore(for title: String, score: Int) {
        if let index = progress.firstIndex(where: { $0.topicTitle == title }) {
            progress[index].quizHighScore = score
            UserDefaults.standard.set(progress[index].quizHighScore, forKey: key(for: title, type: Key.highScore))
        } else {
            progress.append(Progress(topicTitle: title))
            setHighScore(for: title, score: score)
        }
    }
    
    // MARK: - Helpers
    
    private static func readProgressRecords() -> [Progress] {
        var progressRecords = [Progress]()
        
        LanguageTopics.allCases.forEach { topic in
            var progressRecord = Progress(topicTitle: topic.rawValue)
            
            progressRecord.lessonRead = UserDefaults.standard.bool(
                forKey: key(for: topic.rawValue, type: Key.lessonRead)
            )
            
            progressRecord.vocabularyStudied = UserDefaults.standard.bool(
                forKey: key(for: topic.rawValue, type: Key.vocabularyStudied)
            )
            
            progressRecord.quizPassed = UserDefaults.standard.bool(
                forKey: key(for: topic.rawValue, type: Key.quizPassed)
            )
            
            progressRecord.quizHighScore = UserDefaults.standard.integer(
                forKey: key(for: topic.rawValue, type: Key.highScore)
            )
        
            progressRecords.append(progressRecord)
        }

        return progressRecords
    }
    
    // MARK: - Inner structs
    
    struct Card: Identifiable, Hashable {
        fileprivate(set) var isFaceUp = false
        fileprivate(set) var word: String
        fileprivate(set) var definition: String
        fileprivate(set) var id = UUID()
        var content: String {
            isFaceUp ? definition : word
        }
    }
    
    struct Progress {
        let topicTitle: String
        var lessonRead = false
        var vocabularyStudied = false
        var quizPassed = false
        var quizHighScore: Int?
    }
    

    
    struct Topic: Hashable, Identifiable {
        let id = UUID()
        var title: String
        var lessonText: String
        var cards: Array<Card> = []
        var quiz: [QuizItem]
    }
    
    enum QuestionType {
        case trueFalse
        case multipleChoice
        case fillInTheBlank
    }
    
    struct QuizItem: Hashable, Identifiable {
        fileprivate(set) var id = UUID()
        var question: String
        var answers: [String]?
        var correctAnswer: String
        var questionType: QuestionType
        fileprivate(set) var bonusTimeLimit: TimeInterval = Score.maxBonusTime
        fileprivate(set) var activeQuestion: Bool = false {
            willSet (newValue) {
                if newValue {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        fileprivate(set) var selectedOption: String?
        fileprivate(set) var hasBeenSubmitted: Bool = false
        fileprivate(set) var choseCorrectAnswer: Bool = false
        fileprivate(set) var startTime: Date?
        fileprivate(set) var usedTime: TimeInterval = 0
        
        // MARK: - Computed Properties
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - usedTime)
        }
        
        var isConsumingBonusTime: Bool {
            activeQuestion && bonusTimeRemaining > 0
        }
        
        var score: Int {
            if choseCorrectAnswer {
                return Score.basePoints + bonusScore
            }
            
            return 0
        }
        
        var bonusRemainingPercent: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0)
            ? bonusTimeRemaining / bonusTimeLimit
            : 0
        }
        
        private var bonusScore: Int {
            Int(bonusTimeRemaining / 2)
        }
        
        private var faceUpTime: TimeInterval {
            if let startTime {
                usedTime + Date().timeIntervalSince(startTime)
            } else {
                usedTime
            }
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime  {
                startTime = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            usedTime = faceUpTime
            startTime = nil
        }
        
        
    }
}

// MARK: - Constants

private struct Score {
    static let basePoints = 10
    static let bonusFactor = 10.0
    static let maxBonusTime = 20.0
}

private struct Key {
    static let lessonRead = "lesson"
    static let vocabularyStudied = "vocab"
    static let quizPassed = "quiz"
    static let highScore = "score"
}

private func key(for title: String, type: String) -> String {
    "\(title).\(type)"
}

//
//
//extension LanguageLearning.Topic {
//    func shuffledVocabulary() -> [LanguageLearning.Card] {
//        return cards.shuffled() // Shuffle the dictionary's key-value pairs
//    }
//}
//
//extension LanguageLearning.Progress: Identifiable {
//    var id: String { topicTitle }
//}
