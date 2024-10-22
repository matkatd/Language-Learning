//
//  PersistentProgress.swift
//  Language Learning
//
//  Created by David T on 10/17/24.
//

import Foundation

typealias ItemProgress = [String: Bool]
typealias TopicProgress = [String: ItemProgress]


struct PersistentProgress {
    
    private static func defaultProgress() -> TopicProgress {
        var defaultProgress: TopicProgress = [:]
        
        for topic in LanguageTopics.allCases {
            defaultProgress[topic.rawValue] = [
                "read": false,
                "write": false,
                "passed": false
            ]
        }
        return defaultProgress
    }
    
    private static func readProgress() -> TopicProgress {
        UserDefaults.standard.dictionary(forKey: Key.progress) as? TopicProgress ?? TopicProgress()
    }
    
    var progress = PersistentProgress.readProgress() {
        didSet {
            UserDefaults.standard.set(progress, forKey: Key.progress)
        }
    }
    
    private struct Key {
        static let progress = "Progress"
        static let highScores = "HighScores"
    }
}
