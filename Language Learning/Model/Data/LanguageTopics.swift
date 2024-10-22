//
//  TopicsEnum.swift
//  Language Learning
//
//  Created by David T on 10/15/24.
//

import Foundation

typealias CardContent = (key: String, value: String)

typealias VocabDictionary = [String: String]

enum LanguageTopics: String, CaseIterable {
    case basicGreetingsAndFarewells = "Basic Greetings and Farewells"
    case commonPhrases = "Common Phrases"
    case numbers = "Numbers"
    case colors = "Colors"
    case familyMembers = "Family Members"
    case foodAndDrink = "Food and Drink"
    case commonAdjectives = "Common Adjectives"
    case daysOfTheWeek = "Days of the Week"
    case weatherVocabulary = "Weather Vocabulary"
    case commonVerbs = "Common Verbs"
}

func getVocabList(topic: LanguageTopics) -> [String] {
    return vocabularyByTopic[topic]?.keys.shuffled() ?? []
}

let vocabularyByTopic: [LanguageTopics: VocabDictionary] = [
    .basicGreetingsAndFarewells: basicGreetingsAndFarewells,
    .commonPhrases: commonPhrases,
    .numbers: numbers,
    .colors: colors,
    .commonVerbs: commonVerbs,
    .commonAdjectives: commonAdjectives,
    .daysOfTheWeek: daysOfTheWeek,
    .familyMembers: familyMembers,
    .foodAndDrink: foodAndDrink,
    .weatherVocabulary: weatherVocabulary,
]

let quizzesByTopic: [LanguageTopics: [LanguageLearning.QuizItem]] = [
    .basicGreetingsAndFarewells: basicGreetingsAndFarewellsQuiz,
    .commonPhrases: commonPhrasesQuiz,
    .numbers: numbersQuiz,
    .colors: colorsQuiz,
    .commonVerbs: commonVerbsQuiz,
    .commonAdjectives: commonAdjectivesQuiz,
    .daysOfTheWeek: daysOfTheWeekQuiz,
    .familyMembers: familyMembersQuiz,
    .foodAndDrink: foodAndDrinkQuiz,
    .weatherVocabulary: weatherVocabularyQuiz
]

let lessonTextByTopic: [LanguageTopics: String] = [
    .basicGreetingsAndFarewells: """
    In Spanish, greetings and farewells are essential for everyday communication. Common greetings include 'Hola' (Hello), 'Buenos días' (Good morning), and 'Buenas tardes' (Good afternoon). To say goodbye, you can use 'Adiós' (Goodbye), 'Hasta luego' (See you later), or 'Nos vemos' (See you). Learning these phrases will help you make a good first impression in Spanish-speaking environments.
    """,
    .commonPhrases: """
    Spanish has many common phrases that will help you in everyday interactions. For example, '¿Cómo estás?' means 'How are you?', and 'Estoy bien' means 'I’m fine'. 'Por favor' (Please) and 'Gracias' (Thank you) are crucial for polite conversation. Mastering these expressions will make you sound more natural when communicating.
    """,
    .numbers: """
    Numbers in Spanish are straightforward. 'Uno' (1), 'Dos' (2), and 'Tres' (3) are easy to remember. When counting higher, combine tens and ones, such as 'Veintiuno' (21) and 'Treinta y cinco' (35). Knowing numbers is useful for shopping, telling time, and talking about dates.
    """,
    .colors: """
    Colors are frequently used in descriptions and conversations in Spanish. 'Rojo' means red, 'Azul' means blue, and 'Verde' means green. Understanding color words helps when talking about objects, clothing, and even food. It’s a colorful way to expand your vocabulary!
    """,
    .commonVerbs: """
    Verbs are the backbone of Spanish sentences. Common verbs include 'Ser' (to be), 'Tener' (to have), and 'Hacer' (to do). These verbs appear in many contexts, so learning their conjugations will allow you to express a wide variety of actions.
    """,
    .commonAdjectives: """
    Adjectives in Spanish help you describe people, places, and things. Words like 'Grande' (big), 'Pequeño' (small), and 'Rápido' (fast) are just a few examples. Adjectives change based on the gender and number of the nouns they describe, which is an important part of Spanish grammar.
    """,
    .daysOfTheWeek: """
    Learning the days of the week in Spanish is useful for scheduling and everyday conversation. 'Lunes' is Monday, 'Martes' is Tuesday, and so on through 'Domingo' for Sunday. Days of the week are not capitalized in Spanish, which is a small difference from English.
    """,
    .familyMembers: """
    Family is very important in Spanish-speaking cultures. Common terms include 'Madre' (Mother), 'Padre' (Father), 'Hermano' (Brother), and 'Hermana' (Sister). Knowing how to talk about family members will allow you to engage in more personal conversations.
    """,
    .foodAndDrink: """
    Food and drink vocabulary is essential when visiting a Spanish-speaking country. 'Agua' means water, 'Pan' means bread, and 'Fruta' means fruit. Being able to ask for specific dishes or ingredients can greatly enhance your travel experience and your understanding of the culture.
    """,
    .weatherVocabulary: """
    Weather is a common topic in any language. In Spanish, 'Hace calor' means it’s hot, and 'Hace frío' means it’s cold. Talking about the weather is a good way to start a conversation or to plan your day, especially when traveling.
    """
]






