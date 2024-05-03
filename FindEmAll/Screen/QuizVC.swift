//
//  QuizVC.swift
//  FindEmAll
//
//  Created by Porori on 2/29/24.
//

import UIKit

class QuizVC: AnimatingVC {
    
    private let inputTextfield = PokeTextfield(withSpace: true)
    private let pokeImageview = PokeImageView(frame: .zero)
    private let firstInfoview = PokeInfoView() // VC로 옮겨서 하나로 만들 수 있는지 시도해보자
    private let secondInfoview = PokeInfoView()
    private let thirdInfoview = PokeInfoView()
    private let fourthInfoview = PokeInfoView()
    private var infoViews = [PokeInfoView]()
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
        NetworkManager.shared.fetchPokemon() { result in
            switch result {
            case .success(let pokemon):
                PersistenceManager.shared.savePokeData(pokemon.id)
                self.pokemonName = pokemon.name
                self.setImage(with: pokemon)
                
            case .failure(let error as NetworkError):
                print("네트워크 오류가 발생했어요. \(error.localizedDescription)")
            case .failure(let error):
                print("예상 범위를 벗어난 에러가 발생했어요. \(error.localizedDescription)")
            }
        }
    }
    
    private func setImage(with data: Pokemon) {
        NetworkManager.shared.downloadImage(from: data.sprites.frontDefault) { [weak self] image in
            guard let self = self else { return }
            guard let image = image else { return }
            DispatchQueue.main.async {
                let imageStroke = image.createSilhouette()
                self.populateInfoViews(pokemon: data)
                self.pokeImageview.image = imageStroke
                self.pokeImageview.contentMode = .scaleAspectFit
                self.pokeImageview.countDownTimer()
            }
        }
    }
    
    private func populateInfoViews(pokemon: Pokemon) {
        firstInfoview.updateView(data: pokemon, dataType: .height)
        secondInfoview.updateView(data: pokemon, dataType: .move)
        thirdInfoview.updateView(data: pokemon, dataType: .type)
        fourthInfoview.updateView(data: pokemon, dataType: .weight)
    }
    
    //MARK: - UILayout
    private func configureLayout() {
        view.backgroundColor = PokeColor.PokeBlack
        
        view.addSubview(pokeImageview)
        infoViews = [firstInfoview, secondInfoview, thirdInfoview, fourthInfoview]
        pokeImageview.backgroundColor = PokeColor.PokeBlack
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
