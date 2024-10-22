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
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var rotation: Double
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                if isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(.white)
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).stroke()
                    content
                        .opacity(rotation < 90 ? 1 : 0)  // Show content when face-up
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(.gray)
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).stroke()
                    content
                        .rotation3DEffect(.degrees(180), axis: (0, 1, 0)) // Fix upside-down issue
                        .opacity(rotation >= 90 ? 1 : 0) // Show content when face-down
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




