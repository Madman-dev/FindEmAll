//
//  PokedexVC.swift
//  FindEmAll
//
//  Created by Porori on 3/19/24.
//

import UIKit

class PokedexVC: UIViewController {
    let topAnimatingView = AnimatingView(color: .black)
    let bottomAnimatingView = AnimatingView(color: .blue)
    let returnButton = PokeButton(color: .yellow)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadAnimatingView()
        configureReturnButton()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        configureAnimatingViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissAndAnimateOut()
    }
    
    private func configure() {
        view.addSubviews(bottomAnimatingView, returnButton)
        view.backgroundColor = .red
        // hiding navigation back button - below iOS 15
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func configureAnimatingViews() {
        NSLayoutConstraint.activate([
            bottomAnimatingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomAnimatingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomAnimatingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnimatingView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 150)
        ])
    }
    
    private func configureReturnButton() {
        returnButton.layer.borderWidth = 0
        returnButton.setImage(UIImage(systemName: "lasso"), for: .normal)
        returnButton.imageView?.contentMode = .scaleToFill
        
        returnButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            returnButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            returnButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
    
    @objc func backButtonTapped() {
        print("뒤돌아가기 버튼이 눌렸습니다.")
        dismissView()
    }
    
    private func loadAnimatingView() {
        // pokedex는 어떻게 등장하더라?
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        dispatchGroup.enter()
        bottomAnimatingView.animateFull(to: .up) {
            dispatchGroup.leave()
        }
    }
    
    private func dismissAndAnimateOut() {
        bottomAnimatingView.animate(to: .down) {
            return
        }
    }
    
    private func dismissView() {
        bottomAnimatingView.animateFull(to: .down) {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    deinit {
        print("Pokedex 화면이 내려갔습니다")
    }
}
