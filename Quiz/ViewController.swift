//
//  ViewController.swift
//  Quiz
//
//  Created by nagata atsuki on 2024/10/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // インスタンス生成
        let quizManager = QuizManager()
        // 最初のクイズの問題文を確認
        print(quizManager.currentQuiz.text)
        // クイズに○回答する
        quizManager.answerQuiz(answer: true)
        // スコアを確認
        print(quizManager.score)
        // 次のクイズを取得
        quizManager.nextQuiz()
        // 次のクイズの問題文を確認
        print(quizManager.currentQuiz.text)
    }

    // 画面遷移時に呼ばれるメソッド
    override func prepare(for seque: UIStoryboardSegue, sender: Any?) {
        
        // セグエの遷移先がQuizViewControllerの場合
        if let quizViewController =
            seque.destination as? QuizViewController {
            
            // QuizViewControllerのnameTextプロパティにnameTextFieldに入力された値を代入
            if let text = self.nameTextField.text {
                quizViewController.nameText = text
            }
        }
    }
    
    @IBAction func pressButton(_ sender: Any) {
    }
    
}

