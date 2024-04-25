//
//  PokeInfoVC.swift
//  FindEmAll
//
//  Created by Porori on 2/29/24.
//

import UIKit

//class PokeInfoVC: UIViewController {
//    // PokeInfoVC는 모든 데이터를 담는 방식으로 전환
//    // PokeInfoView는 텍스트 레이블 한 줄만
//    let itemInfoView = PokeInfoView()
//    var pokemon: Pokemon!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureBackground()
//        configureLayout()
//    }
//    
//    init(pokemon: Pokemon) {
//        super.init(nibName: nil, bundle: nil)
//        self.pokemon = pokemon
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func configureBackground() {
//        view.layer.cornerRadius = 15
//        view.layer.borderWidth = 2
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.backgroundColor = UIColor.white.withAlphaComponent(0.9).cgColor
//    }
//    
//    private func configureLayout() {
//        view.addSubview(itemInfoView)
//        itemInfoView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            itemInfoView.topAnchor.constraint(equalTo: view.topAnchor),
//            itemInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            itemInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            itemInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//}
