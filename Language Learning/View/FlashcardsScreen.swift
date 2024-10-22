//
//  FlashcardsScreen.swift
//  Language Learning
//
//  Created by David T on 10/15/24.
//


import SwiftUI



struct FlashcardsScreen: View {
    let topicForReview: LanguageLearning.Topic
    
    @StateObject var flashcardReview: FlashcardReview
    
    @State private var selectedTab = 0
    
    init(topicForReview: LanguageLearning.Topic) {
        self.topicForReview = topicForReview
        // Initialize flashcardReview with the topic's vocabulary
        _flashcardReview = StateObject(wrappedValue: FlashcardReview(vocabulary: topicForReview.vocabulary))
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Array(flashcardReview.vocabList.enumerated()), id: \.element) { index, card in
                CardView(card: card)
                    .transition(AnyTransition.offset(randomOffsetScreenLocation))
                    .onTapGesture {
                        flashcardReview.flipCard(card: card)
                    }
                    
                    .tag(index)
                    
            }
        }
        .padding()
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
    
    
    // MARK: - Private Helpers
    private var randomOffsetScreenLocation: CGSize {
        let radius = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 1.5
        let factor: Double = Int.random(in: 0...1) > 0 ? 1.0 : -1.0
        
        return CGSize(width: factor * radius, height: factor * radius)
    }
}

struct CardView: View {
    let card: Flashcards.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text(card.content)
                    .font(systemFont(for: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
            .frame(width: geometry.size.width / 1.5, height: geometry.size.height / 1.5, alignment: .center)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            .foregroundStyle(.primary)
            
        }
        .aspectRatio(Constants.aspectRatio, contentMode: .fit)
    }
    private func systemFont(for size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * Constants.fontScaleFactor)
    }
    
    // MARK: - Drawing Constants
    private struct Constants {
        static let aspectRatio: Double = 5.0 / 7.0
        static let fontScaleFactor = 0.15
        static let paddingScaleFactor = 0.04
    }
    
}


#Preview {
    FlashcardsScreen(topicForReview: LanguageLearning.Topic(title: "test", lessonText: "lalalalalalalalalalalalal alalalalalalalalal lalalalalalalalalal", vocabulary: ["hola": "hello", "adios": "goodbye"], quiz: []))
}
