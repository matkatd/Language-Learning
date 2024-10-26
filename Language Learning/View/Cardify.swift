//
//  Cardify.swift
//  Language Learning
//
//  Created by David T on 10/17/24.
//

import SwiftUI

struct Cardify: Animatable, ViewModifier {
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { rotation }
        set {
            print(newValue)
            rotation = newValue
        }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var rotation: Double
    
    func body(content: Content) -> some View {
        let gradient = Gradient(colors: [
            Color(.learningBlue),
            Color(.lightLearningBlue)
        ])
        
        GeometryReader { geometry in
            ZStack {
                if isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(.white)
                        .shadow(color: .gray, radius: 5, x: 0, y: 5)
                    content
                        .opacity(isFaceUp ? 1 : 0)  // Show content when face-up
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                        .shadow(color: .gray, radius: 5, x: 0, y: 5)
                    
                    content
                        .rotation3DEffect(.degrees(180), axis: (0, 1, 0)) // Fix upside-down issue
                        .opacity(!isFaceUp ? 1 : 0) // Show content when face-down
                }
            }
            .rotation3DEffect(Angle(degrees: rotation), axis: (0, 1, 0))
        }
        
    }
    
    // MARK: - Drawing Constants
    private func cornerRadius(for size: CGSize) -> Double {
        min(size.width, size.height) / 5
    }
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}




