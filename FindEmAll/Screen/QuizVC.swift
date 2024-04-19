//
//  QuizVC.swift
//  FindEmAll
//
//  Created by Porori on 2/29/24.
//

import UIKit

class QuizVC: UIViewController {
    
    private let topAnimatingView = AnimatingView(color: Color.PokeRed)
    private let bottomAnimatingView = AnimatingView(color: Color.PokeGrey)
    private let guessingTextfield = Textfield(withSpace: true)
    private let pokeImageview = ImageView(frame: .zero)
    private let firstInfo = UIView() // VC로 옮겨서 하나로 만들 수 있는지 시도해보자
    private let secondInfo = UIView()
    private let thirdInfo = UIView()
    private let fourthInfo = UIView()
    private var infoViews = [UIView]()
    private var originalPosition = [UIView: CGPoint]()
    private let padding: CGFloat = 20
    private var pokemonName: String!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureTextfield()
        createDismissKeyboardGesture()
        configureReturnButton()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        configureAnimatingViews()
        loadingView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchData()
    }
    
    private func checkIfMatching(name: String, userInput: String?) {
        guard !(guessingTextfield.text?.isEmpty ?? true) else { return } // 에러핸들링 - 에러 메시지
        
        let writtenAnswer = guessingTextfield.text
        if name == userInput {
            print("맞췄어요!")
        } else {
            print("다시 한번 생각해봐요!")
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
            self.setData(data: pokemon)
        }
    }
    
    private func setData(data: Pokemon) {
        NetworkManager.shared.downloadImage(from: data.sprites.frontDefault) { [weak self] image in
            guard let self = self else { return }
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.populateViews(pokemon: data)
                self.pokeImageview.image = image
                self.pokeImageview.contentMode = .scaleAspectFill
            }
        }
    }
    
    private func populateViews(pokemon: Pokemon) {
        addChild(childVC: PokeInfoVC(pokemon: pokemon, for: .height), to: self.firstInfo)
        addChild(childVC: PokeInfoVC(pokemon: pokemon, for: .move), to: self.secondInfo)
        addChild(childVC: PokeInfoVC(pokemon: pokemon, for: .weight), to: self.thirdInfo)
        addChild(childVC: PokeInfoVC(pokemon: pokemon, for: .type),  to: self.fourthInfo)
    }
    
    private func addChild(childVC: UIViewController, to container: UIView) {
        addChild(childVC)
        container.addSubview(childVC.view)
        
        childVC.view.frame = container.bounds
        childVC.didMove(toParent: self)
    }
    
    //MARK: - UILayout
    private func layoutUI() {
        view.backgroundColor = Color.PitchBlack
        
        view.addSubviews(topAnimatingView, bottomAnimatingView, pokeImageview)
        infoViews = [firstInfo, secondInfo, thirdInfo, fourthInfo]
        pokeImageview.backgroundColor = Color.PitchBlack
        pokeImageview.set(img: "lasso")
        pokeImageview.setBorder()
        
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
            
            firstInfo.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            secondInfo.topAnchor.constraint(equalTo: firstInfo.bottomAnchor, constant: 10),
            thirdInfo.topAnchor.constraint(equalTo: secondInfo.bottomAnchor, constant: 10),
            fourthInfo.topAnchor.constraint(equalTo: thirdInfo.bottomAnchor, constant: 10)
        ])
    }
    
    private func configureReturnButton() {
        let backButton = UIBarButtonItem(
            image: UIImage(
                systemName: "arrowshape.backward.fill")?
                .withTintColor(.white, renderingMode: .alwaysOriginal
                ),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem = backButton
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
    
    //MARK: - Methods
    @objc func backButtonTapped() {
        print("데이터가 보내졌습니다.")
        dismissView()
    }
    
    private func returnBack() {
        firstInfo.animateBack(to: originalPosition[firstInfo]!)
        secondInfo.animateBack(to: originalPosition[secondInfo]!)
        thirdInfo.animateBack(to: originalPosition[thirdInfo]!)
        fourthInfo.animateBack(to: originalPosition[fourthInfo]!)
    }
    
    private func loadingView() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        topAnimatingView.animate(to: .down) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        bottomAnimatingView.animate(to: .up) {
            dispatchGroup.leave()
        }
    }
    
    private func dismissView() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        topAnimatingView.animate(to: .up) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        bottomAnimatingView.animate(to: .down) {
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
        checkIfMatching(name: pokemonName, userInput: textField.text)
        returnBack()
        guessingTextfield.resignFirstResponder()
        return true
    }
}
