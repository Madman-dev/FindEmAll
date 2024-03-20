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
    let pokedexButton = PokeButton(color: .green)
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureAnimatingViews()
        configureTitleView()
        configureButton()
        configurePokeDex()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
//        loadingView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAnimatingView()
    }
    
    //MARK: - UILayout
    private func layoutUI() {
        view.backgroundColor = .black
        view.addSubviews(topAnimatingView, bottomAnimatingView, titleView, actionButton, pokedexButton)
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
            actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 101),
            actionButton.widthAnchor.constraint(equalToConstant: 101)
        ])
    }
    
    private func configurePokeDex() {
        pokedexButton.addTarget(self, action: #selector(pokedexButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            pokedexButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokedexButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    //MARK: - Methods
    @objc func actionButtonTapped() {
        let destinationVC = QuizVC()
        dismissAndAnimateTo(VC: destinationVC)
    }
    
    @objc func pokedexButtonTapped() {
        let destinationVC = PokedexVC()
        dismissAndAnimateTo(VC: destinationVC)
    }
    
    private func loadAnimatingView() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        topAnimatingView.animate(to: .down) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        bottomAnimatingView.animate(to: .up) {
            dispatchGroup.leave()
        }
    }
    
    private func dismissAndAnimateTo(VC destination: UIViewController) {
        // moving the views at once
        let dispatchGroup = DispatchGroup()
        actionButton.scale(size: .bigger)
        
        dispatchGroup.enter()
        topAnimatingView.animate(to: .up) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        bottomAnimatingView.animate(to: .down) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.navigationController?.pushViewController(destination, animated: false)
        }
    }
    
    deinit {
        print("StartingVC가 내려갔습니다")
    }
}
