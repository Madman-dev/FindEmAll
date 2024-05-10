//
//  StartingVC.swift
//  FindEmAll
//
//  Created by Porori on 2/28/24.
//

import UIKit

class StartingVC: AnimatingVC {
    
    let titleLabel = PKTitleLabel(textAlignment: .center, fontSize: 30)
    let enterGameButton = PKButton(color: .white)
    let pokedexButton = PKButton(color: PKColor.PokeBlack)
    var feedbackGenerator: UIImpactFeedbackGenerator? = nil
    private let height = (UIScreen.main.bounds.height/2) - 15
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureTitleView()
        configureButton()
        configurePokedex()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAnimatingView()
    }
    
    //MARK: - UILayout
    private func configureLayout() {
        view.backgroundColor = PKColor.PokeBlack
        view.addSubviews(titleLabel, enterGameButton, pokedexButton)
    }
    
    private func configureTitleView() {
        titleLabel.text = "Find'em All"
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200)
        ])
    }
    
    private func configureButton() {
        enterGameButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        enterGameButton.addBorder(color: PKColor.PokeBlack)
        
        NSLayoutConstraint.activate([
            enterGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterGameButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            enterGameButton.heightAnchor.constraint(equalToConstant: 101),
            enterGameButton.widthAnchor.constraint(equalToConstant: 101)
        ])
    }
    
    private func configurePokedex() {
        pokedexButton.addTarget(self, action: #selector(pokedexButtonTapped), for: .touchUpInside)
        pokedexButton.addBorder(color: .white)
        
        NSLayoutConstraint.activate([
            pokedexButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokedexButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            pokedexButton.heightAnchor.constraint(equalToConstant: 101),
            pokedexButton.widthAnchor.constraint(equalToConstant: 101)
        ])
    }
    
    //MARK: - Methods
    func prepareFeedback() {
        feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        feedbackGenerator?.prepare()
    }
    
    @objc func actionButtonTapped(_ sender: UIButton) {
        self.prepareFeedback()
        let destinationVC = QuizVC()
        sender.animatedWhenTapped {
            self.feedbackGenerator?.impactOccurred()
            self.dismissAndAnimateTo(VC: destinationVC)
        }
    }
    
    @objc func pokedexButtonTapped(sender: UIButton) {
        let destinationVC = PokedexVC()
        sender.animatedWhenTapped {
            self.dismissAndAnimateTo(VC: destinationVC)
        }
    }
    
    deinit {
        print("StartingVC가 내려갔습니다")
    }
}
