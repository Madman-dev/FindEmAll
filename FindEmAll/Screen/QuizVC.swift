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
        
        //MARK: - Adding notificationCenter for keyboard events.
        // 뷰를 전체적으로 올린다는 점에서 이슈 발생
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        questionLabel.text = "나는 누구일까요?"
        
        view.addSubviews(topAnimatingView, bottomAnimatingView, actionButton, questionLabel)
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
            
            questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            questionLabel.heightAnchor.constraint(equalToConstant: 50),
            
            firstInfo.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 50),
            secondInfo.topAnchor.constraint(equalTo: firstInfo.bottomAnchor, constant: 10),
            thirdInfo.topAnchor.constraint(equalTo: secondInfo.bottomAnchor, constant: 10),
            fourthInfo.topAnchor.constraint(equalTo: thirdInfo.bottomAnchor, constant: 10),
        ])
    }
    
    private func configureTextfield() {
        view.addSubview(guessingTextfield)
        guessingTextfield.delegate = self
        
        NSLayoutConstraint.activate([
            guessingTextfield.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            guessingTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            guessingTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            guessingTextfield.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // needs to give LayoutConstraint activation OUTSIDE the NSLayoutConstraint.
        textfieldBottomConstraint = guessingTextfield.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        textfieldBottomConstraint?.isActive = true
    }
    
    @objc func keyboardWillShowNotification(notification: Notification) {
        // 너무 복잡하게 되어 있는데? 쉽게 적용할 수 있는 방법이 있지 않을까?
        // guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        // self.view.frame.origin.y = 0 - keyboardSize.height
        
        if guessingTextfield.isEditing {
            moveViewWithNotification(notification: notification, viewBottomConstraint: self.textfieldBottomConstraint, keyboardWillShow: true)
        }
    }
    
    @objc func keyboardWillHideNotification(notification: Notification) {
        // self.view.frame.origin.y = 0
        
        moveViewWithNotification(notification: notification, viewBottomConstraint: self.textfieldBottomConstraint, keyboardWillShow: false)
    }
    
    func moveViewWithNotification(notification: Notification, viewBottomConstraint: NSLayoutConstraint, keyboardWillShow: Bool) {
        // 키보드 규격 확인
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let keyboardHeight = keyboardSize.height
        
        // 키보드 규격을 명확하게 알고 있기에 userInfo는 not optional
        // keyboard animation duration
        let keyboardDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        // keyboard animation curve
        let keyboardCurve = UIView.AnimationCurve(rawValue: notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!
        
        // 키보드가 이동했는지 확인
        if keyboardWillShow {
            // notch를 포함한 디바이스 자체의 safe area가 존재하는지 확인
//            let safeAreaExist = (self.view.window?.safeAreaInsets.bottom != 0)
//            let bottomConstant: CGFloat = 20
            viewBottomConstraint.constant = (-keyboardHeight) - 20
        } else {
            viewBottomConstraint.constant = 20
        }
        
        let animator = UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) {
            [weak self] in
            self?.view.layoutIfNeeded()
        }
        
        animator.startAnimation()
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
