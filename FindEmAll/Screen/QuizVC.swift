//
//  QuizVC.swift
//  FindEmAll
//
//  Created by Porori on 2/29/24.
//

import UIKit

class QuizVC: UIViewController {
    
    let topAnimatingView = AnimatingView(color: .red)
    let bottomAnimatingView = AnimatingView(color: .blue)
    let actionButton = PokeButton(color: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        configureAnimatingViews()
        configureButton()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        loadingView()
        actionButton.scale(size: .smaller)
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
    
    private func configureButton() {
        view.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func loadingView() {
        // moving the views at once
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        topAnimatingView.move(to: .down) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        bottomAnimatingView.move(to: .up) {
            dispatchGroup.leave()
        }
    }
}