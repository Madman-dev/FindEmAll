//
//  StartingVC.swift
//  FindEmAll
//
//  Created by Porori on 2/28/24.
//

import UIKit

class StartingVC: UIViewController {
    
    let titleView = TitleLabel(textAlignment: .center, fontSize: 30)
    let topAnimatingView = AnimatingView(color: .purple)
    let bottomAnimatingView = AnimatingView(color: .green)
    let actionButton = PokeButton(color: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureAnimatingViews()
        configureTitleView()
        configureButton()
    }
    
    private func layoutUI() {
        view.backgroundColor = .darkGray
        view.addSubviews(topAnimatingView, bottomAnimatingView, titleView, actionButton)
    }
    
    private func configureAnimatingViews() {
        NSLayoutConstraint.activate([
            topAnimatingView.topAnchor.constraint(equalTo: view.topAnchor),
            topAnimatingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topAnimatingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnimatingView.heightAnchor.constraint(equalToConstant: 410),
            
            bottomAnimatingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomAnimatingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomAnimatingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnimatingView.heightAnchor.constraint(equalToConstant: 410)
        ])
    }
    
    private func configureTitleView() {
        titleView.text = "Welcome Aboard"
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200)
        ])
    }
    
    private func configureButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func actionButtonTapped() {
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
