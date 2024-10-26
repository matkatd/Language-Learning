//
//  Language_LearningApp.swift
//  Language Learning
//
//  Created by David T on 10/10/24.
//

import SwiftUI

@main
struct Language_LearningApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(learningController: LearningViewModel())
        }
    }
}
