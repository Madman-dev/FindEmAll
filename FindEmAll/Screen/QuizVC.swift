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
    let textField = Textfield(withSpace: true)
    let stackView = UIStackView()
    var infoViews = [UIView]()
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
        loadingView()
        actionButton.scale(size: .smaller)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        configureStackView()
        populateViews()
        configureTextfield()
    }
    
    private func layoutUI() {
        view.backgroundColor = .black
        view.addSubviews(topAnimatingView, bottomAnimatingView, actionButton, questionLabel, textField)
                
        configureAnimatingViews()
        configureButton()
        fetchData()
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
    
    private func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        configureViewInfoViews()
    }
    
    private func configureViewInfoViews() {
        infoViews = [firstInfo, secondInfo, thirdInfo, fourthInfo]
        
        for infoView in infoViews {
            stackView.addArrangedSubview(infoView)
            
            NSLayoutConstraint.activate([
                infoView.heightAnchor.constraint(equalToConstant: 80)
            ])
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
    
    private func configureQuestionLabel() {
        questionLabel.text = "Questions will be placed like so"
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            questionLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureButton() {
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureAnimatingViews() {
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
    
    private func configureTextfield() {
        textField.delegate = self
        
        NSLayoutConstraint.activate([
            textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50)
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

extension QuizVC: UITextFieldDelegate {
    
}
