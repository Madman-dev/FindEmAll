//
//  StartingVC.swift
//  FindEmAll
//
//  Created by Porori on 2/28/24.
//

import UIKit

class StartingVC: UIViewController {
    
    let titleView = TitleLabel(text: "이렇게?", textAlignment: .center, fontSize: 30)
    let topAnimatingView = AnimatingView(color: .purple)
    let bottomAnimatingView = AnimatingView(color: .green)
    let actionButton = PokeButton(color: .white)
    // var isAnimatingComplete: Bool = false
    
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
        view.addSubview(topAnimatingView)
        view.addSubview(bottomAnimatingView)
        
        NSLayoutConstraint.activate([
            topAnimatingView.topAnchor.constraint(equalTo: view.topAnchor),
            topAnimatingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topAnimatingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnimatingView.heightAnchor.constraint(equalToConstant: 410)
        ])
        
        NSLayoutConstraint.activate([
            bottomAnimatingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomAnimatingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomAnimatingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnimatingView.heightAnchor.constraint(equalToConstant: 410)
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
            actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func actionButtonTapped() {
        print("버튼이 눌렸습니다")
        let destinationVC = QuizVC()
        destinationVC.modalTransitionStyle = .crossDissolve
        destinationVC.modalPresentationStyle = .fullScreen
        
        // moving the views at once
        let dispatchGroup = DispatchGroup()
        actionButton.scale(size: .bigger)
        
        dispatchGroup.enter()
        topAnimatingView.move(to: .up) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        bottomAnimatingView.move(to: .down) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.present(destinationVC, animated: true)
        }
    }
}
