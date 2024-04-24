//
//  PokeAlertVC.swift
//  FindEmAll
//
//  Created by Porori on 4/19/24.
//

import UIKit

class PokeAlertVC: UIViewController {
    
    private let containerView = AlertContainerView()
    private let titleLabel = PokeTitleLabel(textAlignment: .center, fontSize: 25)
    private let actionName = PokeButton(color: PokeColor.PokeRed)
    
    private var alertTitle: String?
    private var buttonTitle: String?
    
    init(title: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContainer()
        configureTitle()
        configureButton()
    }
    
    private func configureContainer() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.addSubviews(containerView)
        containerView.addSubviews(titleLabel, actionName)
        let width: CGFloat = UIScreen.main.bounds.width
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: width/2),
            containerView.widthAnchor.constraint(equalToConstant: width/1.5)
        ])
    }
    
    private func configureTitle() {
        titleLabel.text = alertTitle ?? "Error Message"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func configureButton() {
        actionName.setTitle(buttonTitle ?? "Pass!", for: .normal)
        actionName.setTitleColor(.systemBackground, for: .normal)
        
        // button is dismissed when tapped
        let action = UIAction { [weak self] action in self?.dismiss(animated: true) }
        actionName.addAction(action, for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionName.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            actionName.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            actionName.heightAnchor.constraint(equalToConstant: 50),
            actionName.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}
