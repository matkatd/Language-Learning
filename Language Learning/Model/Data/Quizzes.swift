//
//  Quizzes.swift
//  Language Learning
//
//  Created by David T on 10/17/24.
//

import Foundation

let basicGreetingsAndFarewellsQuiz = [
    LanguageLearning.QuizItem(
        question: "What does 'Hola' mean?",
        answers: ["Goodbye", "Good morning", "Hello", "See you later"],
        correctAnswer: "Hello",
        questionType: .multipleChoice
    ),
    LanguageLearning.QuizItem(
        question: "'Adiós' means goodbye.",
        answers: nil,
        correctAnswer: "True",
        questionType: .trueFalse
    ),
    LanguageLearning.QuizItem(
        question: "Translate to Spanish: See you later.",
        answers: nil,
        correctAnswer: "Hasta luego",
        questionType: .fillInTheBlank
    )
]

let commonPhrasesQuiz = [
    LanguageLearning.QuizItem(
        question: "What is the Spanish phrase for 'How are you?'?",
        answers: ["¿Qué tal?", "¿Cómo estás?", "¿Cómo te llamas?", "¿Dónde estás?"],
        correctAnswer: "¿Cómo estás?",
        questionType: .multipleChoice
    ),
    LanguageLearning.QuizItem(
        question: "'Por favor' means thank you.",
        answers: nil,
        correctAnswer: "False",
        questionType: .trueFalse
    ),
    LanguageLearning.QuizItem(
        question: "Translate to Spanish: Thank you.",
        answers: nil,
        correctAnswer: "Gracias",
        questionType: .fillInTheBlank
    )
]

let numbersQuiz = [
    LanguageLearning.QuizItem(
        question: "What is the number 3 in Spanish?",
        answers: ["Uno", "Dos", "Tres", "Cuatro"],
        correctAnswer: "Tres",
        questionType: .multipleChoice
    ),
    LanguageLearning.QuizItem(
        question: "'Veintiuno' means twenty-one.",
        answers: nil,
        correctAnswer: "True",
        questionType: .trueFalse
    ),
    LanguageLearning.QuizItem(
        question: "Translate to Spanish: Five.",
        answers: nil,
        correctAnswer: "Cinco",
        questionType: .fillInTheBlank
    )
]

let colorsQuiz = [
    LanguageLearning.QuizItem(
        question: "What does 'Rojo' mean?",
        answers: ["Blue", "Green", "Red", "Yellow"],
        correctAnswer: "Red",
        questionType: .multipleChoice
    ),
    LanguageLearning.QuizItem(
        question: "'Azul' means blue.",
        answers: nil,
        correctAnswer: "True",
        questionType: .trueFalse
    ),
    LanguageLearning.QuizItem(
        question: "Translate to Spanish: Green.",
        answers: nil,
        correctAnswer: "Verde",
        questionType: .fillInTheBlank
    )
]

let commonVerbsQuiz = [
    LanguageLearning.QuizItem(
        question: "What does the verb 'Tener' mean?",
        answers: ["To do", "To have", "To go", "To make"],
        correctAnswer: "To have",
        questionType: .multipleChoice
    ),
    LanguageLearning.QuizItem(
        question: "'Ser' means 'to be'.",
        answers: nil,
        correctAnswer: "True",
        questionType: .trueFalse
    ),
    LanguageLearning.QuizItem(
        question: "Translate to Spanish: To do.",
        answers: nil,
        correctAnswer: "Hacer",
        questionType: .fillInTheBlank
    )
]

let commonAdjectivesQuiz = [
    LanguageLearning.QuizItem(
        question: "What does 'Grande' mean?",
        answers: ["Big", "Small", "Fast", "Slow"],
        correctAnswer: "Big",
        questionType: .multipleChoice
    ),
    LanguageLearning.QuizItem(
        question: "'Rápido' means slow.",
        answers: nil,
        correctAnswer: "False",
        questionType: .trueFalse
    ),
    LanguageLearning.QuizItem(
        question: "Translate to Spanish: Small.",
        answers: nil,
        correctAnswer: "Pequeño",
        questionType: .fillInTheBlank
    )
]

let daysOfTheWeekQuiz = [
    LanguageLearning.QuizItem(
        question: "What is 'Lunes' in English?",
        answers: ["Monday", "Tuesday", "Wednesday", "Thursday"],
        correctAnswer: "Monday",
        questionType: .multipleChoice
    ),
    LanguageLearning.QuizItem(
        question: "'Domingo' means Sunday.",
        answers: nil,
        correctAnswer: "True",
        questionType: .trueFalse
    ),
    LanguageLearning.QuizItem(
        question: "Translate to Spanish: Tuesday.",
        answers: nil,
        correctAnswer: "Martes",
        questionType: .fillInTheBlank
    )
]

let familyMembersQuiz = [
    LanguageLearning.QuizItem(
        question: "What is the Spanish word for 'Father'?",
        answers: ["Madre", "Padre", "Hermano", "Tío"],
        correctAnswer: "Padre",
        questionType: .multipleChoice
    ),
    LanguageLearning.QuizItem(
        question: "'Hermana' means sister.",
        answers: nil,
        correctAnswer: "True",
        questionType: .trueFalse
    ),
    LanguageLearning.QuizItem(
        question: "Translate to Spanish: Brother.",
        answers: nil,
        correctAnswer: "Hermano",
        questionType: .fillInTheBlank
    )
]

let foodAndDrinkQuiz = [
    LanguageLearning.QuizItem(
        question: "What is 'Pan' in English?",
        answers: ["Water", "Bread", "Fruit", "Wine"],
        correctAnswer: "Bread",
        questionType: .multipleChoice
    ),
    LanguageLearning.QuizItem(
        question: "'Agua' means water.",
        answers: nil,
        correctAnswer: "True",
        questionType: .trueFalse
    ),
    LanguageLearning.QuizItem(
        question: "Translate to Spanish: Fruit.",
        answers: nil,
        correctAnswer: "Fruta",
        questionType: .fillInTheBlank
    )
]

let weatherVocabularyQuiz = [
    LanguageLearning.QuizItem(
        question: "What does 'Hace calor' mean?",
        answers: ["It's hot", "It's cold", "It's raining", "It's windy"],
        correctAnswer: "It's hot",
        questionType: .multipleChoice
    ),
    LanguageLearning.QuizItem(
        question: "'Hace frío' means it's cold.",
        answers: nil,
        correctAnswer: "True",
        questionType: .trueFalse
    ),
    LanguageLearning.QuizItem(
        question: "Translate to Spanish: It's raining.",
        answers: nil,
        correctAnswer: "Está lloviendo",
        questionType: .fillInTheBlank
    )
]
