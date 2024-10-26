////
////  FlashcardReview.swift
////  Language Learning
////
////  Created by David T on 10/15/24.
////
//
//import SwiftUI
//
//class FlashcardReview: ObservableObject {
//
//    // MARK: - Properties
//    @Published private var flashcards: Flashcards = FlashcardReview.createDeck()
//    
//    static func createDeck() -> Flashcards {
//        Flashcards(cards: [])
//    }
//    
//    init(vocabulary: VocabDictionary) {
//        createDeck(with: vocabulary)
//    }
//    
//    private func createDeck(with vocabulary: VocabDictionary) {
//        var cards: [Flashcards.Card] = []
//        for (word, definition) in vocabulary {
//            cards.append(Flashcards.Card(isFaceUp: false, word: word, definition: definition))
//        }
//        self.flashcards = Flashcards(cards: cards.shuffled())
//    }
//    
//    // MARK: - User Intents
//    func flipCard(card: Flashcards.Card) {
//        withAnimation(.easeIn(duration: Constants.animationDuration)) {
//            flashcards.flipCard(card: card)
//        }
//    }
//    
//    // MARK: - Model Access
//    var vocabList: Array<Flashcards.Card>  {
//        flashcards.cards
//    }
//    
//    // MARK: - Constants
//    
//    private struct Constants {
//        static let animationDuration = 20.0
//    }
//}
