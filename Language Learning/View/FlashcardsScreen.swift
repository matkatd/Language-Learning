//
//  FlashcardsScreen.swift
//  Language Learning
//
//  Created by David T on 10/15/24.
//


import SwiftUI



struct FlashcardsScreen: View {
    @EnvironmentObject var learningController: LearningViewModel
    let topic: LanguageLearning.Topic
    @State private var selectedTab = 0
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Array(learningController.vocabList(for: topic.title).enumerated()), id: \.element) { index, card in
                CardView(card: card)
                    .onTapGesture {
                        learningController.flipCard(card: card, topic: topic)
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
    let card: LanguageLearning.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text(card.content)
                    .font(systemFont(for: geometry.size))
                    .lineLimit(nil)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .padding()
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
        static let aspectRatio: Double = 7.0 / 5.0
        static let fontScaleFactor = 0.20
        static let paddingScaleFactor = 0.01
    }
    
}


#Preview {
    FlashcardsScreen(topic: LanguageLearning.Topic(title: "test", lessonText: "lalalalalalalalalalalalal alalalalalalalalal lalalalalalalalalal", quiz: []))
    //topicForReview: LanguageLearning.Topic(title: "test", lessonText: "lalalalalalalalalalalalal alalalalalalalalal lalalalalalalalalal", vocabulary: ["hola": "hello", "adios": "goodbye"], quiz: [])
}
