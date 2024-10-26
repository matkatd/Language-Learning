//
//  LanguageModel.swift
//  Language Learning
//
//  Created by David T on 10/26/24.
//

import Foundation

protocol LessonPlan {
    var languageName: String { get }
    var topics: [Language.Topic] { get }
    var progress: [Language.Progress] { get set }
    
    mutating func toggleLessonRead(for title: String)
    mutating func toggleVocabularyStudied(for title: String)
    mutating func toggleQuizPassed(for title: String)
    mutating func setHighScore(for title: String, score: Int)
}

struct Language {
    struct Card: Identifiable, Hashable {
        fileprivate(set) var isFaceUp = false
        fileprivate(set) var word: String
        fileprivate(set) var definition: String
        fileprivate(set) var id = UUID()
        var content: String {
            isFaceUp ? definition : word
        }
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
    
    struct Progress {
        let topicTitle: String
        var lessonRead = false
        var vocabularyStudied = false
        var quizPassed = false
        var quizHighScore: Int?
    }
    
    struct QuizItem: Hashable, Identifiable {
        fileprivate(set) var id = UUID()
        var question: String
        var answers: [String]?
        var correctAnswer: String
        var questionType: Language.QuestionType
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

extension Language.Topic {
    func shuffledVocabulary() -> [Language.Card] {
        return cards.shuffled() // Shuffle the dictionary's key-value pairs
    }
}

extension Language.Progress: Identifiable {
    var id: String { topicTitle }
}

private func key(for title: String, type: String) -> String {
    "\(title).\(type)"
}

struct SpanishLessonPlan: LessonPlan {
    // MARK: - Read-only properties
    
    let languageName: String = "Spanish"
    var topics = Data.spanishTopics
    
    // MARK: - Mutable Properties
    
    var progress: [Language.Progress] = SpanishLessonPlan.readProgressRecords()
    
    // MARK: - Helpers
    
    mutating func toggleLessonRead(for title: String) {
        if let index = progress.firstIndex(where: { $0.topicTitle == title }) {
            progress[index].lessonRead.toggle()
            UserDefaults.standard.set(progress[index].lessonRead, forKey: key(for: title, type: Key.lessonRead))
        } else {
            progress.append(Language.Progress(topicTitle: title))
            toggleLessonRead(for: title)
        }
    }
    
    mutating func toggleVocabularyStudied(for title: String) {
        if let index = progress.firstIndex(where: { $0.topicTitle == title }) {
            progress[index].vocabularyStudied.toggle()
            UserDefaults.standard.set(progress[index].vocabularyStudied, forKey: key(for: title, type: Key.vocabularyStudied))
        } else {
            progress.append(Language.Progress(topicTitle: title))
            toggleVocabularyStudied(for: title)
        }
    }
    
    mutating func toggleQuizPassed(for title: String) {
        if let index = progress.firstIndex(where: { $0.topicTitle == title }) {
            progress[index].quizPassed.toggle()
            UserDefaults.standard.set(progress[index].quizPassed, forKey: key(for: title, type: Key.quizPassed))
        } else {
            progress.append(Language.Progress(topicTitle: title))
            toggleQuizPassed(for: title)
        }
    }
    
    mutating func setHighScore(for title: String, score: Int) {
        if let index = progress.firstIndex(where: { $0.topicTitle == title }) {
            progress[index].quizHighScore = score
            UserDefaults.standard.set(progress[index].quizHighScore, forKey: key(for: title, type: Key.highScore))
        } else {
            progress.append(Language.Progress(topicTitle: title))
            setHighScore(for: title, score: score)
        }
    }
    
    mutating func flipCard(card: Language.Card, selectedTopic: Language.Topic) {
        if let chosenTopicIndex = topics.firstIndex(where: { $0.title == selectedTopic.title }) {
            if let chosenIndex = topics[chosenTopicIndex].cards.firstIndex(of: card) {
                topics[chosenTopicIndex].cards[chosenIndex].isFaceUp.toggle()
            }
        }
    }
    
    mutating func submitAnswer(question: Language.QuizItem, selectedTopic: Language.Topic) {
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
    
    mutating func selectAnswer(question: Language.QuizItem, answer: String, selectedTopic: Language.Topic) {
        if let chosenTopicIndex = topics.firstIndex(where: { $0.title == selectedTopic.title }) {
            if let chosenIndex = topics[chosenTopicIndex].quiz.firstIndex(of: question) {
                topics[chosenTopicIndex].quiz[chosenIndex].activeQuestion = true
                topics[chosenTopicIndex].quiz[chosenIndex].selectedOption = answer
            }
        }
    }
    
    func getScore(selectedTopic: Language.Topic) -> Int {
        if let chosenTopicIndex = topics.firstIndex(where: { $0.title == selectedTopic.title }) {
            return topics[chosenTopicIndex].quiz.reduce(0) { $0 + $1.score }
        }
        return 0
    }
    
    private static func readProgressRecords() -> [Language.Progress] {
        var progressRecords = [Language.Progress]()
        
        LanguageTopics.allCases.forEach { topic in
            var progressRecord = Language.Progress(topicTitle: topic.rawValue)
            
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
}

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

private struct Data {
    static let spanishTopics: [Language.Topic] = [
        Language.Topic(
            title: LanguageTopics.basicGreetingsAndFarewells.rawValue,
            lessonText: """
    In Spanish, greetings and farewells are essential for everyday communication. Common greetings include 'Hola' (Hello), 'Buenos días' (Good morning), and 'Buenas tardes' (Good afternoon). To say goodbye, you can use 'Adiós' (Goodbye), 'Hasta luego' (See you later), or 'Nos vemos' (See you). Learning these phrases will help you make a good first impression in Spanish-speaking environments.
    """,
            cards: [
                Language.Card(word: "Hola", definition: "Hello"),
                Language.Card(word: "Adiós", definition: "Goodbye"),
                Language.Card(word: "Buenos días", definition: "Good morning"),
                Language.Card(word: "Buenas tardes", definition: "Good afternoon"),
                Language.Card(word: "Buenas noches", definition: "Good night"),
                Language.Card(word: "¿Cómo estás?", definition: "How are you?"),
                Language.Card(word: "Estoy bien", definition: "I am fine"),
                Language.Card(word: "Hasta luego", definition: "See you later")
            ] ,
            quiz: [
                Language.QuizItem(
                    question: "What does 'Hola' mean?",
                    answers: ["Goodbye", "Good morning", "Hello", "See you later"],
                    correctAnswer: "Hello",
                    questionType: .multipleChoice
                ),
                Language.QuizItem(
                    question: "'Adiós' means goodbye.",
                    answers: nil,
                    correctAnswer: "True",
                    questionType: .trueFalse
                ),
                Language.QuizItem(
                    question: "Translate to Spanish: See you later.",
                    answers: nil,
                    correctAnswer: "Hasta luego",
                    questionType: .fillInTheBlank
                )
            ]),
        Language.Topic(
            title: LanguageTopics.commonPhrases.rawValue,
            lessonText: """
    Spanish has many common phrases that will help you in everyday interactions. For example, '¿Cómo estás?' means 'How are you?', and 'Estoy bien' means 'I’m fine'. 'Por favor' (Please) and 'Gracias' (Thank you) are crucial for polite conversation. Mastering these expressions will make you sound more natural when communicating.
    """,
            cards: [
                Language.Card(word: "Por favor", definition: "Please"),
                Language.Card(word: "Gracias", definition: "Thank you"),
                Language.Card(word: "De nada", definition: "You're welcome"),
                Language.Card(word: "Lo siento", definition: "I'm sorry"),
                Language.Card(word: "¿Cuánto cuesta?", definition: "How much does it cost?"),
                Language.Card(word: "¿Dónde está...?", definition: "Where is...?"),
                Language.Card(word: "Me gustaría", definition: "I would like")
            ],
            quiz: [
                Language.QuizItem(
                    question: "What is the Spanish phrase for 'How are you?'?",
                    answers: ["¿Qué tal?", "¿Cómo estás?", "¿Cómo te llamas?", "¿Dónde estás?"],
                    correctAnswer: "¿Cómo estás?",
                    questionType: .multipleChoice
                ),
                Language.QuizItem(
                    question: "'Por favor' means thank you.",
                    answers: nil,
                    correctAnswer: "False",
                    questionType: .trueFalse
                ),
                Language.QuizItem(
                    question: "Translate to Spanish: Thank you.",
                    answers: nil,
                    correctAnswer: "Gracias",
                    questionType: .fillInTheBlank
                )
            ]),
        Language.Topic(
            title: LanguageTopics.numbers.rawValue,
            lessonText: """
    Numbers in Spanish are straightforward. 'Uno' (1), 'Dos' (2), and 'Tres' (3) are easy to remember. When counting higher, combine tens and ones, such as 'Veintiuno' (21) and 'Treinta y cinco' (35). Knowing numbers is useful for shopping, telling time, and talking about dates.
    """,
            cards: [
                Language.Card(word: "Uno", definition: "1"),
                Language.Card(word: "Dos", definition: "2"),
                Language.Card(word: "Tres", definition: "3"),
                Language.Card(word: "Cuatro", definition: "4"),
                Language.Card(word: "Cinco", definition: "5"),
                Language.Card(word: "Seis", definition: "6"),
                Language.Card(word: "Siete", definition: "7"),
                Language.Card(word: "Ocho", definition: "8"),
                Language.Card(word: "Nueve", definition: "9"),
                Language.Card(word: "Diez", definition: "10")
            ],
            quiz: [
                Language.QuizItem(
                    question: "What is the number 3 in Spanish?",
                    answers: ["Uno", "Dos", "Tres", "Cuatro"],
                    correctAnswer: "Tres",
                    questionType: .multipleChoice
                ),
                Language.QuizItem(
                    question: "'Veintiuno' means twenty-one.",
                    answers: nil,
                    correctAnswer: "True",
                    questionType: .trueFalse
                ),
                Language.QuizItem(
                    question: "Translate to Spanish: Five.",
                    answers: nil,
                    correctAnswer: "Cinco",
                    questionType: .fillInTheBlank
                )
            ]),
        Language.Topic(
            title: LanguageTopics.colors.rawValue,
            lessonText: """
    Colors are frequently used in descriptions and conversations in Spanish. 'Rojo' means red, 'Azul' means blue, and 'Verde' means green. Understanding color words helps when talking about objects, clothing, and even food. It’s a colorful way to expand your vocabulary!
    """,
            cards: [
                Language.Card(word: "Rojo", definition: "Red"),
                Language.Card(word: "Azul", definition: "Blue"),
                Language.Card(word: "Verde", definition: "Green"),
                Language.Card(word: "Amarillo", definition: "Yellow"),
                Language.Card(word: "Negro", definition: "Black"),
                Language.Card(word: "Blanco", definition: "White"),
                Language.Card(word: "Naranja", definition: "Orange"),
                Language.Card(word: "Rosa", definition: "Pink")
            ],
            quiz: [
                Language.QuizItem(
                    question: "What does 'Rojo' mean?",
                    answers: ["Blue", "Green", "Red", "Yellow"],
                    correctAnswer: "Red",
                    questionType: .multipleChoice
                ),
                Language.QuizItem(
                    question: "'Azul' means blue.",
                    answers: nil,
                    correctAnswer: "True",
                    questionType: .trueFalse
                ),
                Language.QuizItem(
                    question: "Translate to Spanish: Green.",
                    answers: nil,
                    correctAnswer: "Verde",
                    questionType: .fillInTheBlank
                )
            ]
        ),
        Language.Topic(
            title: LanguageTopics.commonVerbs.rawValue,
            lessonText: """
    Verbs are the backbone of Spanish sentences. Common verbs include 'Ser' (to be), 'Tener' (to have), and 'Hacer' (to do). These verbs appear in many contexts, so learning their conjugations will allow you to express a wide variety of actions.
    """,
            cards:[
                Language.Card(word: "Ser", definition: "To be"),
                Language.Card(word: "Estar", definition: "To be"),
                Language.Card(word: "Tener", definition: "To have"),
                Language.Card(word: "Hacer", definition: "To do/make"),
                Language.Card(word: "Ir", definition: "To go"),
                Language.Card(word: "Comer", definition: "To eat"),
                Language.Card(word: "Beber", definition: "To drink"),
                Language.Card(word: "Hablar", definition: "To speak")
            ],
            quiz: [
                Language.QuizItem(
                    question: "What does the verb 'Tener' mean?",
                    answers: ["To do", "To have", "To go", "To make"],
                    correctAnswer: "To have",
                    questionType: .multipleChoice
                ),
                Language.QuizItem(
                    question: "'Ser' means 'to be'.",
                    answers: nil,
                    correctAnswer: "True",
                    questionType: .trueFalse
                ),
                Language.QuizItem(
                    question: "Translate to Spanish: To do.",
                    answers: nil,
                    correctAnswer: "Hacer",
                    questionType: .fillInTheBlank
                )
            ])
    ]
}




