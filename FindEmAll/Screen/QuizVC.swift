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
    let pokeImageview = PokeImageView(withImage: "circle.fill")
    let firstInfo = UIView()
    let secondInfo = UIView()
    let thirdInfo = UIView()
    let fourthInfo = UIView()
    var infoViews = [UIView]()
    let guessingTextfield = Textfield(withSpace: true)
    var textfieldBottomConstraint: NSLayoutConstraint!
    let padding: CGFloat = 20
    private var originalPosition = [UIView: CGPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureTextfield()
        createDismissKeyboardGesture()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        configureAnimatingViews()
        loadingView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        populateViews()
//        fetchData()
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
    
    private func createDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
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
    
    private func layoutUI() {
        view.backgroundColor = .black
        
        view.addSubviews(topAnimatingView, bottomAnimatingView, actionButton, pokeImageview)
        infoViews = [firstInfo, secondInfo, thirdInfo, fourthInfo]
        
        for infoView in infoViews {
            view.addSubview(infoView)
            infoView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
                infoView.heightAnchor.constraint(equalToConstant: 80)
            ])
        }
        
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            pokeImageview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokeImageview.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            pokeImageview.heightAnchor.constraint(equalToConstant: 280),
            pokeImageview.widthAnchor.constraint(equalToConstant: 280),
            
            firstInfo.topAnchor.constraint(equalTo: bottomAnimatingView.topAnchor, constant: 15),
            secondInfo.topAnchor.constraint(equalTo: firstInfo.bottomAnchor, constant: 10),
            thirdInfo.topAnchor.constraint(equalTo: secondInfo.bottomAnchor, constant: 10),
            fourthInfo.topAnchor.constraint(equalTo: thirdInfo.bottomAnchor, constant: 10)
        ])
    }
    
    private func configureTextfield() {
        view.addSubview(guessingTextfield)
        guessingTextfield.delegate = self
        
        NSLayoutConstraint.activate([
            guessingTextfield.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            guessingTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            guessingTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            guessingTextfield.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func returnBack() {
        firstInfo.animateBack(to: originalPosition[firstInfo]!)
        secondInfo.animateBack(to: originalPosition[secondInfo]!)
        thirdInfo.animateBack(to: originalPosition[thirdInfo]!)
        fourthInfo.animateBack(to: originalPosition[fourthInfo]!)
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

extension QuizVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        originalPosition[firstInfo] = firstInfo.frame.origin
        originalPosition[secondInfo] = secondInfo.frame.origin
        originalPosition[thirdInfo] = thirdInfo.frame.origin
        originalPosition[fourthInfo] = fourthInfo.frame.origin
        
        firstInfo.animateToCenter(of: self.view, origin: originalPosition[firstInfo]!)
        secondInfo.animateToCenter(of: self.view, origin: originalPosition[secondInfo]!)
        thirdInfo.animateToCenter(of: self.view, origin: originalPosition[thirdInfo]!)
        fourthInfo.animateToCenter(of: self.view, origin: originalPosition[fourthInfo]!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        returnBack()
        guessingTextfield.resignFirstResponder()
        return true
    }
}
