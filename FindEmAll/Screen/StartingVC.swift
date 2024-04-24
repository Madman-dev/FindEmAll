//
//  StartingVC.swift
//  FindEmAll
//
//  Created by Porori on 2/28/24.
//

import UIKit

class StartingVC: UIViewController {
    
    let titleLabel = PokeTitleLabel(textAlignment: .center, fontSize: 30)
    let topAnimatingView = AnimatingView(color: PokeColor.PokeRed)
    let bottomAnimatingView = AnimatingView(color: PokeColor.PokeGrey)
    let enterGameButton = PokeButton(color: .white)
    let pokedexButton = PokeButton(color: .green)
    var feedbackGenerator: UIImpactFeedbackGenerator? = nil
    private let height = (UIScreen.main.bounds.height/2) - 15
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureAnimatingViews()
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
        view.backgroundColor = PokeColor.PokeBlack
        view.addSubviews(topAnimatingView, bottomAnimatingView, titleLabel, enterGameButton, pokedexButton)
    }
    
    private func configureAnimatingViews() {
        NSLayoutConstraint.activate([
            topAnimatingView.topAnchor.constraint(equalTo: view.topAnchor),
            topAnimatingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topAnimatingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnimatingView.heightAnchor.constraint(equalToConstant: height),
            
            bottomAnimatingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomAnimatingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomAnimatingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnimatingView.heightAnchor.constraint(equalToConstant: height)
        ])
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
        enterGameButton.addBorder(color: PokeColor.PokeBlack)
        
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
        sender.tapAnimation {
            self.feedbackGenerator?.impactOccurred()
            self.dismissAndAnimateTo(VC: destinationVC)
        }
    }
    
    @objc func pokedexButtonTapped(sender: UIButton) {
        let destinationVC = PokedexVC()
        sender.tapAnimation {
            self.dismissAndAnimateTo(VC: destinationVC)
        }
    }
    
    private func loadAnimatingView() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        topAnimatingView.animate(position: .down) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        bottomAnimatingView.animate(position: .up) {
            dispatchGroup.leave()
        }
    }
    
    private func dismissAndAnimateTo(VC destination: UIViewController) {
        // moving the views at once
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        topAnimatingView.animate(position: .up) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        bottomAnimatingView.animate(position: .down) {
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
