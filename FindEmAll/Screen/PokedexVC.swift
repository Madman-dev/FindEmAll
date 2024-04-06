//
//  PokedexVC.swift
//  FindEmAll
//
//  Created by Porori on 3/19/24.
//

import UIKit

class PokedexVC: UIViewController {
    let topAnimatingView = AnimatingView(color: .black)
    let bottomAnimatingView = AnimatingView(color: .blue)
    let returnButton = PokeButton(color: .black)
    let firstDisplayView = DataDisplayView()
    let secondDisplayView = DataDisplayView()
    var collectionView: UICollectionView!
    private let allPokemon: [Int] = Array(1...151)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureAnimatingViews()
        
        // animatingView 이후 호출될 수 있도록 시점 변경
        loadAnimatingView()
        configureDataDisplay()
        configureCollectionView()
        configureReturnButton()
        configureDisplayData()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDisplayData() {
        firstDisplayView.set(item: .seen, withCount: 2)
        secondDisplayView.set(item: .captured, withCount: 1)
    }
    
    private func configure() {
        view.backgroundColor = .red
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UIHelpers.createThreeColumnFlowlayout(in: self.view)
        )
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(
            PokeCollectionViewCell.self,
            forCellWithReuseIdentifier: PokeCollectionViewCell.reuseId
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: firstDisplayView.bottomAnchor, constant: 35),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureDataDisplay() {
        view.addSubview(firstDisplayView)
        view.addSubview(secondDisplayView)
        
        NSLayoutConstraint.activate([
            firstDisplayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            firstDisplayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstDisplayView.heightAnchor.constraint(equalToConstant: 50),
            firstDisplayView.widthAnchor.constraint(equalToConstant: view.frame.width/2 - 10),
            
            secondDisplayView.centerYAnchor.constraint(equalTo: firstDisplayView.centerYAnchor),
            secondDisplayView.leadingAnchor.constraint(equalTo: firstDisplayView.trailingAnchor),
            secondDisplayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            secondDisplayView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // 추가 수정할 필요없는 UI
    private func configureAnimatingViews() {
        view.addSubview(bottomAnimatingView)
        
        NSLayoutConstraint.activate([
            bottomAnimatingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomAnimatingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomAnimatingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnimatingView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 180)
        ])
    }
    
    private func configureReturnButton() {
        let padding: CGFloat = 50
        
        view.addSubview(returnButton)
        returnButton.setImage(UIImage(systemName: "arrowshape.backward.fill"), for: .normal)
        returnButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            returnButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            returnButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            returnButton.heightAnchor.constraint(equalToConstant: padding),
            returnButton.widthAnchor.constraint(equalToConstant: padding)
        ])
    }
    
    @objc func backButtonTapped() {
        print("뒤돌아가기 버튼이 눌렸습니다.")
        dismissView()
    }
    
    private func loadAnimatingView() {
        // pokedex는 어떻게 등장하더라?
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        dispatchGroup.enter()
        bottomAnimatingView.animateFull(to: .up) {
            dispatchGroup.leave()
        }
    }
    
//    private func dismissAndAnimateOut() {
//        bottomAnimatingView.animate(to: .down) {
//            return
//        }
//    }
    
    private func dismissView() {
        bottomAnimatingView.animateFull(to: .down) {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    deinit {
        print("Pokedex 화면이 내려갔습니다")
    }
}

extension PokedexVC: UICollectionViewDelegate {
    
}

extension PokedexVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokeCollectionViewCell.reuseId, for: indexPath) as! PokeCollectionViewCell
        
        let encounteredIds = PersistenceManager.shared.fetchEncounteredId()
        if encounteredIds.contains(allPokemon[indexPath.item]) {
            cell.pokeImage.set(img: "circle")
        } else {
            cell.pokeImage.set(img: "clipboard.fill")
        }
        cell.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let animationDuration: Double = 1.0
        let delayBase: Double = 0.3
        
        // 이 계산이 이해가 안되는데?
        let column = Double(cell.frame.maxX / cell.frame.width)
        let row = Double(cell.frame.minY / cell.frame.height)
        let distance = sqrt(pow(column, 3) + pow(row, 3))
        let delay = sqrt(distance) * delayBase
        
        UIView.animate(withDuration: animationDuration, delay: delay,
                       usingSpringWithDamping: 0.8, initialSpringVelocity: 4, options: []) {
            cell.backgroundColor = .white.withAlphaComponent(0.7)
            cell.transform = .identity
        }
    }
}

//extension PokedexVC: SendDataToVCDelegate {
//    func passDataToVC(data: Pokemon) {
//        pokeData = data
//        print("데이터가 넘어왔습니다")
//    }
//}
