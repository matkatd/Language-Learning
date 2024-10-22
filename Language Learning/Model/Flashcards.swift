//
//  Flashcards.swift
//  Language Learning
//
//  Created by David T on 10/15/24.
//

import Foundation

struct Flashcards {
    // MARK: - Properties
    var cards: Array<Card>
    
    
    // MARK: - Methods
    mutating func flipCard(card: Card) {
        if let chosenIndex = cards.firstIndex(of: card) {
            cards[chosenIndex].isFaceUp.toggle()
        }
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
}


