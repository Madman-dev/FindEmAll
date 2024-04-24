//
//  QuizVC.swift
//  FindEmAll
//
//  Created by Porori on 2/29/24.
//

import UIKit

class QuizVC: UIViewController {
    
    private let topAnimatingView = AnimatingView(color: PokeColor.PokeRed)
    private let bottomAnimatingView = AnimatingView(color: PokeColor.PokeGrey)
    private let inputTextfield = PokeTextfield(withSpace: true)
    private let pokeImageview = PokeImageView(frame: .zero)
    private let firstInfoview = UIView() // VC로 옮겨서 하나로 만들 수 있는지 시도해보자
    private let secondInfoview = UIView()
    private let thirdInfoview = UIView()
    private let fourthInfoview = UIView()
    private var infoViews = [UIView]()
    private var originalPosition = [UIView: CGPoint]()
    private let height = (UIScreen.main.bounds.height/2) - 15
    private let padding: CGFloat = 20
    private var pokemonName: String!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureTextfield()
        createDismissKeyboardGesture()
        configureReturnButton()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        configureAnimatingViews()
        loadAnimatingView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchData()
    }
    
    private func checkIfMatching(name: String, userInput: String?) {
        guard !(inputTextfield.text?.isEmpty ?? true) else {
            presentPokeAlert(title: PokeInputError.blankTitle.text,
                             buttonTitle: "ok")
            return
        }
        
        if name == userInput {
            presentPokeAlert(title: PokeInputError.caughtTitle.text,
                             buttonTitle: "ok")
        } else {
            self.returnBack()
            self.inputTextfield.resignFirstResponder()
            presentPokeAlert(title: PokeInputError.missedTitle.text,
                             buttonTitle: "ok")
        }
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
            
            PersistenceManager.shared.savePokeData(pokemon.id)
            self.pokemonName = pokemon.name
            self.setImage(with: pokemon)
        }
    }
    
    private func setImage(with data: Pokemon) {
        NetworkManager.shared.downloadImage(from: data.sprites.frontDefault) { [weak self] image in
            guard let self = self else { return }
            guard let image = image else { return }
            DispatchQueue.main.async {
                let imageStroke = image.createSilhouette()
                self.populateInfoviews(pokemon: data)
                self.pokeImageview.image = imageStroke
                self.pokeImageview.contentMode = .scaleAspectFit
                self.pokeImageview.countDownTimer()
            }
        }
    }
    
    private func populateInfoviews(pokemon: Pokemon) {
        addChild(childVC: PokeInfoVC(pokemon: pokemon, for: .height), to: self.firstInfoview)
        addChild(childVC: PokeInfoVC(pokemon: pokemon, for: .move), to: self.secondInfoview)
        addChild(childVC: PokeInfoVC(pokemon: pokemon, for: .weight), to: self.thirdInfoview)
        addChild(childVC: PokeInfoVC(pokemon: pokemon, for: .type),  to: self.fourthInfoview)
    }
    
    private func addChild(childVC: UIViewController, to container: UIView) {
        addChild(childVC)
        container.addSubview(childVC.view)
        
        childVC.view.frame = container.bounds
        childVC.didMove(toParent: self)
    }
    
    //MARK: - UILayout
    private func configureLayout() {
        view.backgroundColor = PokeColor.PokeBlack
        
        view.addSubviews(topAnimatingView, bottomAnimatingView, pokeImageview)
        infoViews = [firstInfoview, secondInfoview, thirdInfoview, fourthInfoview]
        pokeImageview.backgroundColor = Color.PokeBlack
        pokeImageview.delegate = self
        pokeImageview.set(img: "lasso")
        
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
            pokeImageview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokeImageview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pokeImageview.heightAnchor.constraint(equalToConstant: 350),
            pokeImageview.widthAnchor.constraint(equalToConstant: 350),
            
            firstInfoview.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            secondInfoview.topAnchor.constraint(equalTo: firstInfoview.bottomAnchor, constant: 10),
            thirdInfoview.topAnchor.constraint(equalTo: secondInfoview.bottomAnchor, constant: 10),
            fourthInfoview.topAnchor.constraint(equalTo: thirdInfoview.bottomAnchor, constant: 10)
        ])
    }
    
    private func configureReturnButton() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "arrowshape.backward.fill")?
                .withTintColor(.white, renderingMode: .alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func configureTextfield() {
        view.addSubview(inputTextfield)
        inputTextfield.delegate = self
        
        NSLayoutConstraint.activate([
            inputTextfield.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            inputTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            inputTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            inputTextfield.heightAnchor.constraint(equalToConstant: 80)
        ])
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
    
    //MARK: - Methods
    @objc func backButtonTapped() {
        print("데이터가 보내졌습니다.")
        dismissAnimatingView()
    }
    
    private func returnBack() {
        firstInfoview.animateBack(to: originalPosition[firstInfoview]!)
        secondInfoview.animateBack(to: originalPosition[secondInfoview]!)
        thirdInfoview.animateBack(to: originalPosition[thirdInfoview]!)
        fourthInfoview.animateBack(to: originalPosition[fourthInfoview]!)
    }
    
    // create a ViewController to subclass into
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
    
    private func dismissAnimatingView() {
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
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    private func createDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    deinit {
        print("QuizVC가 화면에서 내려갔습니다")
    }
}

// MARK: - TextfieldDelegate
extension QuizVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        originalPosition[firstInfoview] = firstInfoview.frame.origin
        originalPosition[secondInfoview] = secondInfoview.frame.origin
        originalPosition[thirdInfoview] = thirdInfoview.frame.origin
        originalPosition[fourthInfoview] = fourthInfoview.frame.origin
        
        firstInfoview.animateToCenter(of: self.view, origin: originalPosition[firstInfoview]!)
        secondInfoview.animateToCenter(of: self.view, origin: originalPosition[secondInfoview]!)
        thirdInfoview.animateToCenter(of: self.view, origin: originalPosition[thirdInfoview]!)
        fourthInfoview.animateToCenter(of: self.view, origin: originalPosition[fourthInfoview]!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkIfMatching(name: pokemonName, userInput: textField.text)
        return true
    }
}

extension QuizVC: PokeImageDelegate {
    func isTimeOver(_ complete: Bool) {
        if complete {
            presentPokeAlert(title: "이렇게", buttonTitle: "ok")
        }
    }
}
