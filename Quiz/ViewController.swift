//
//  ViewController.swift
//  Quiz
//
//  Created by nagata atsuki on 2024/10/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        var str = ""
        str = "Hello Swift"
        self.label.text = str
    }

    @IBAction func pressButton(_ sender: Any) {
        self.label.text = "ボタンを押しました"
    }
    
}

