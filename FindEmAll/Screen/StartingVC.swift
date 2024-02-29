//
//  StartingVC.swift
//  FindEmAll
//
//  Created by Porori on 2/28/24.
//

import UIKit

class StartingVC: UIViewController {
    
    let titleView = TitleLabel(text: "이렇게?", textAlignment: .center, fontSize: 30)
    let upAnimatingView = AnimatingView(color: .purple)
    let downAnimatingView = AnimatingView(color: .purple)
    let actionButton = PokeButton(color: .blue, image: "pencil")
    var isAnimatingComplete: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureAnimatingViews()
        configureTitleView()
        configureButton()
    }
    
    private func configure() {
        view.backgroundColor = .darkGray
    }
    
    private func configureAnimatingViews() {
        view.addSubview(upAnimatingView)
        view.addSubview(downAnimatingView)
        
        NSLayoutConstraint.activate([
            upAnimatingView.topAnchor.constraint(equalTo: view.topAnchor),
            upAnimatingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            upAnimatingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            upAnimatingView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            downAnimatingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            downAnimatingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            downAnimatingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            downAnimatingView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureTitleView() {
        let padding: CGFloat = 200
        view.addSubview(titleView)
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -padding)
        ])
    }
    
    private func configureButton() {
        view.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 100),
            actionButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func actionButtonTapped() {
        print("버튼이 눌렸습니다")
        let destinationVC = QuizVC()
        destinationVC.modalTransitionStyle = .crossDissolve
        destinationVC.modalPresentationStyle = .fullScreen
        
        // moving the views at once
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        upAnimatingView.move(to: .up) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        downAnimatingView.move(to: .down) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.present(destinationVC, animated: true)
        }
    }
}
