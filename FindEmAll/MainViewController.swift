//
//  MainViewController.swift
//  FindEmAll
//
//  Created by Jack Lee on 2023/12/15.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var pokeballTop: UIView!
    @IBOutlet var pokeballBottom: UIView!
    @IBOutlet var button: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetUI()
    }
    
    func resetUI() {
        button.layer.cornerRadius = 20
    }
    
    @IBAction func startButtonTapped() {
        print("버튼이 눌렸어요")
    }
    
}

