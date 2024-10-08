//
//  QuizViewController.swift
//  Quiz
//
//  Created by nagata atsuki on 2024/10/05.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var nameText : String = ""
    
    @IBOutlet weak var quizCard: QuizCard!
    let manager: QuizManager = QuizManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.ß
        
        self.quizCard.style = .initial
        self.loadQuiz()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragQuizCard(_:)))
        self.quizCard.addGestureRecognizer(panGestureRecognizer)
    }
    
    func loadQuiz() {
        // クイズの問題文を表示
        self.quizCard.quizLabel.text = manager.currentQuiz.text
        // クイズの画像を表示
        self.quizCard.quizImageView.image = UIImage(named: manager.currentQuiz.imageName)
    }
    
    func answer() {
        // 移動するCGAffineTransformオブジェクト
        var translationTransform: CGAffineTransform
        // X軸方向の移動距離
        let screenWidth = UIScreen.main.bounds.width
        // Y軸方向の移動距離
        let y = UIScreen.main.bounds.height * 0.2
        
        // 回答によってtranslationTransformの内容を変える
        if self.quizCard.style == .right {
            // ○回答の時は右へ移動
            translationTransform = CGAffineTransform(translationX: screenWidth, y: y)
            self.manager.answerQuiz(answer: true)
        } else {
            // ×回答の時は左へ移動
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: y)
            self.manager.answerQuiz(answer: false)
        }
        
        // クイズのカードをアニメーションさせて移動する
        // 0.1秒遅延させて0.5秒でカードを移動する
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.curveLinear], animations: {
            // クイズのカードのtransformプロパティにtranslationTransformを設定
            self.quizCard.transform = translationTransform
        }, completion: { [unowned self] (finished) in
            if finished {
                self.showNextQuiz()
            }
        })
    }
    
    func showNextQuiz() {
        // 次のクイズを取得
        self.manager.nextQuiz()
        // transformプロパティに加えられた変更をリセットし、
        // クイズのカードをもとの位置に
        self.quizCard.transform = CGAffineTransform.identity
        // カードの状態を初期状態に
        self.quizCard.style = .initial
        // クイズを表示
        self.loadQuiz()
    }
    
    @objc func dragQuizCard(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            self.transformQuizCard(gesture: sender)
        case .ended:
            self.answer()
            break
        default:
            break
        }
    }
    
    func transformQuizCard(gesture: UIPanGestureRecognizer) {
        // 移動した距離を取得
        let translation = gesture.translation(in: self.quizCard)
        // 移動した距離を元にCGAffineTransformオブジェクトを作成
        let translationTransform = CGAffineTransform(
            translationX: translation.x, y: translation.y)
        // 画面の幅の半分に対する移動した距離の割合
        let translationPercent = translation.x/UIScreen.main.bounds.width/2
        // 割合に対して角度を算出
        let rotationAngle = CGFloat.pi/3 * translationPercent
        // 算出した角度でのCGAffineTransformオブジェクトを作成
        let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
        
        // 変換のオブジェクトを合成
        let transform = translationTransform.concatenating(rotationTransform)
        // quizCardに反映
        self.quizCard.transform = transform
        
        if translation.x > 0 {
            self.quizCard.style = .right
        } else {
            self.quizCard.style = .wrong
        }
    }

}
