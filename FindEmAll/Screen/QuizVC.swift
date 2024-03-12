//
//  QuizVC.swift
//  FindEmAll
//
//  Created by Porori on 2/29/24.
//

import UIKit

class QuizVC: UIViewController {
    
    let topAnimatingView = AnimatingView(color: .red)
    let bottomAnimatingView = AnimatingView(color: .gray)
    let actionButton = PokeButton(color: .white)
    let questionLabel = TitleLabel(textAlignment: .center, fontSize: 24)
    let firstInfo = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureAnimatingViews()
        configureButton()
        fetchData()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        loadingView()
        actionButton.scale(size: .smaller)
        
        configureQuestionLabel()
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchPokemon() { [weak self] pokemon, errorMessage in
            guard let self = self else { return }
            
            if let error = errorMessage {
                print("호출 에러 문제 발생",error)
                return
            }
            
            guard let pokemon = pokemon else {
                print("Error Occurs here")
                return
            }
            
            print(pokemon.moves[0].move.name)
            print(pokemon.sprites.frontDefault)
        }
    }
    
    private func configureQuestionLabel() {
        view.addSubview(questionLabel)
        questionLabel.text = "Questions will be placed like so"
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            questionLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
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
