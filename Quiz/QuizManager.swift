//
//  QuizManager.swift
//  Quiz
//
//  Created by nagata atsuki on 2024/10/07.
//

import UIKit

class QuizManager {
    var quizzes: [Quiz]
    var currentIndex: Int
    var score: Int
    
    enum Status {
        case inAnswer
        case done
    }
    var status: Status
    
    init() {
        quizzes = []
        // 問題文、正解、画像名でクイズを作成
        quizzes.append(Quiz(text: "人間を超でっかいネコだと思っている?", correctAnswer: true, imageName: "cat"))
        quizzes.append(Quiz(text: "イヌは食べ物のおいしさを味よりも匂いで判断している?", correctAnswer: true, imageName: "dog"))
        quizzes.append(Quiz(text: "トラのシマシマ模様は皮膚まで繋がっていない?", correctAnswer: false, imageName: "tiger"))
        quizzes.append(Quiz(text: "クマは走る時に全部の足がバラバラに動いている?", correctAnswer: true, imageName: "bear"))
        quizzes.append(Quiz(text: "パンダのいちばんの好物は笹である?", correctAnswer: false, imageName: "panda"))
        
        currentIndex = 0
        score = 0
        status = .inAnswer
    }
}
