//
//  QuizVC.swift
//  FindEmAll
//
//  Created by Porori on 2/29/24.
//

import UIKit

class QuizVC: AnimatingVC {
    
    //MARK: - Property
    private let inputTextfield = PKTextfield(withSpace: true)
    private let pokeImageview = PKImageView(frame: .zero)
    private let firstInfoview = PKInfoView() // VC로 옮겨서 하나로 만들 수 있는지 시도해보자
    private let secondInfoview = PKInfoView()
    private let thirdInfoview = PKInfoView()
    private let fourthInfoview = PKInfoView()
    private var infoViews = [PKInfoView]()
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
        loadAnimatingView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchData()
    }
    
    //MARK: - Methods
    private func checkIfMatching(name: String, userInput: String?) {
        guard !(inputTextfield.text?.isEmpty ?? true) else {
            presentPKAlert(title: PKInputError.blankTitle.text,
                             buttonTitle: "ok")
            return
        }
        
        if name == userInput {
            presentPKAlert(title: PKInputError.caughtTitle.text,
                             buttonTitle: "ok")
        } else {
            self.returnViewsToOrigin()
            self.inputTextfield.resignFirstResponder()
            presentPKAlert(title: PKInputError.missedTitle.text,
                             buttonTitle: "ok")
        }
    }
    
    private func fetchData() {
        Task {
            do {
                let pokemonData = try await NetworkManager.shared.fetchPokemon()
                savePokemon(with:pokemonData.id)
                updateUI(with: pokemonData)
            } catch {
                if let _ = error as? NetworkError {
                    print("네트워크 오류가 발생했습니다.")
                } else {
                    print("예측 불가능한 에러가 발생했어요.")
                }
            }
        }
    }
    
    private func updateUI(with id: Pokemon) {
        self.pokemonName = id.name
        loadImage(with: id)
    }
    
    private func savePokemon(with id: Int) {
        PersistenceManager.shared.savePokeData(id)
    }
    
    // does not throw an error
    private func loadImage(with data: Pokemon) {
        Task {
            do {
                let image = await NetworkManager.shared.downloadImage(from: data.sprites.frontDefault)
                handleDownload(image, for: data)
            }
        }
    }
    
    private func handleDownload(_ image: UIImage?, for pokemon: Pokemon) {
        let imageStroke = image?.createSilhouette()
        self.populateInfoViews(pokemon: pokemon)
        self.pokeImageview.image = imageStroke
        self.pokeImageview.contentMode = .scaleAspectFit
        self.pokeImageview.countDownTimer()
    }
    
    private func populateInfoViews(pokemon: Pokemon) {
        firstInfoview.updateView(data: pokemon, dataType: .height)
        secondInfoview.updateView(data: pokemon, dataType: .move)
        thirdInfoview.updateView(data: pokemon, dataType: .type)
        fourthInfoview.updateView(data: pokemon, dataType: .weight)
    }
    
    @objc func backButtonTapped() {
        print("데이터가 보내졌습니다.")
        dismissAnimatingView()
    }
    
    private func returnViewsToOrigin() {
        firstInfoview.animateToOrigin(originalPosition[firstInfoview]!)
        secondInfoview.animateToOrigin(originalPosition[secondInfoview]!)
        thirdInfoview.animateToOrigin(originalPosition[thirdInfoview]!)
        fourthInfoview.animateToOrigin(originalPosition[fourthInfoview]!)
    }
    
    private func createDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Autolayout && UI
    private func configureLayout() {
        view.backgroundColor = PKColor.PokeBlack
        
        view.addSubview(pokeImageview)
        infoViews = [firstInfoview, secondInfoview, thirdInfoview, fourthInfoview]
        pokeImageview.backgroundColor = PKColor.PokeBlack
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
            presentPKAlert(title: "이렇게", buttonTitle: "ok")
        }
    }
}
