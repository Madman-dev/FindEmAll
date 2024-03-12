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
    let secondInfo = UIView()
    let thirdInfo = UIView()
    let fourthInfo = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        configureAnimatingViews()
        loadingView()
        actionButton.scale(size: .smaller)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        populateViews()
        fetchData()
    }
    
    private func layoutUI() {
        view.backgroundColor = .black
        view.addSubviews(topAnimatingView, bottomAnimatingView, actionButton, questionLabel, firstInfo, secondInfo, thirdInfo, fourthInfo)
        
        firstInfo.translatesAutoresizingMaskIntoConstraints = false
        secondInfo.translatesAutoresizingMaskIntoConstraints = false
        thirdInfo.translatesAutoresizingMaskIntoConstraints = false
        fourthInfo.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.text = "Questions will be placed like so"
                
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            questionLabel.heightAnchor.constraint(equalToConstant: 50),
            
            firstInfo.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 50),
            firstInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstInfo.heightAnchor.constraint(equalToConstant: 80),
            
            secondInfo.topAnchor.constraint(equalTo: firstInfo.bottomAnchor, constant: 10),
            secondInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            secondInfo.heightAnchor.constraint(equalToConstant: 80),
            
            thirdInfo.topAnchor.constraint(equalTo: secondInfo.bottomAnchor, constant: 10),
            thirdInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            thirdInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            thirdInfo.heightAnchor.constraint(equalToConstant: 80),
            
            fourthInfo.topAnchor.constraint(equalTo: thirdInfo.bottomAnchor, constant: 10),
            fourthInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fourthInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fourthInfo.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchPokemon() { pokemon, errorMessage in
            
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
    
    private func populateViews() {
        addChild(childVC: InfoVC(), to: self.firstInfo)
        addChild(childVC: InfoVC(), to: self.secondInfo)
        addChild(childVC: InfoVC(), to: self.thirdInfo)
        addChild(childVC: InfoVC(), to: self.fourthInfo)
    }
    
    private func addChild(childVC: UIViewController, to container: UIView) {
        addChild(childVC)
        container.addSubview(childVC.view)
        
        childVC.view.frame = container.bounds
        childVC.didMove(toParent: self)
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
