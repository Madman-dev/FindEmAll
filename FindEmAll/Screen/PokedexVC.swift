//
//  PokedexVC.swift
//  FindEmAll
//
//  Created by Porori on 3/19/24.
//

import UIKit

class PokedexVC: UIViewController {
    let bottomAnimatingView = AnimatingView(color: PokeColor.PokeGrey)
    let returnButton = PokeButton(color: .white)
    let seenDisplayView = DataDisplayView()
    let caughtDisplayView = DataDisplayView()
    var collectionView: UICollectionView!
    var encounteredId: [Int: Pokemon] = [:]
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimatingViews()
        loadAnimatingView()
        
        configureDataDisplay()
        configureCollectionView()
        configureReturnButton()
        setDisplayViews()
        fetchEncountered()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        configureLayout()
    }

    
    private func setDisplayViews() {
        let totalSeen = PersistenceManager.shared.fetchEncounteredId()
        seenDisplayView.set(item: .seen, withCount: totalSeen.count)
        caughtDisplayView.set(item: .captured, withCount: 0)
        seenDisplayView.setBorder()
        caughtDisplayView.setBorder()
    }
    
    private func configureLayout() {
        view.backgroundColor = PokeColor.PokeRed
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
            collectionView.topAnchor.constraint(equalTo: seenDisplayView.bottomAnchor, constant: 35),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureDataDisplay() {
        view.addSubview(seenDisplayView)
        view.addSubview(caughtDisplayView)
        
        NSLayoutConstraint.activate([
            seenDisplayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            seenDisplayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            seenDisplayView.heightAnchor.constraint(equalToConstant: 50),
            seenDisplayView.widthAnchor.constraint(equalToConstant: view.frame.width/2 - 10),
            
            caughtDisplayView.centerYAnchor.constraint(equalTo: seenDisplayView.centerYAnchor),
            caughtDisplayView.leadingAnchor.constraint(equalTo: seenDisplayView.trailingAnchor),
            caughtDisplayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            caughtDisplayView.heightAnchor.constraint(equalToConstant: 50),
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
        dismissView()
    }
    
    private func loadAnimatingView() {
        // pokedex는 어떻게 등장하더라?
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        dispatchGroup.enter()
        bottomAnimatingView.animateFull(position: .up) {
            dispatchGroup.leave()
        }
    }
    
    private func fetchEncountered() {
        let encounteredId = PersistenceManager.shared.fetchEncounteredId().sorted()
        
        for id in encounteredId {
            NetworkManager.shared.fetchPokemonWithId(number: id) { pokemon, errorMessage in
                if let pokemon = pokemon {
                    self.encounteredId[id - 1] = pokemon
                    DispatchQueue.main.async {
                        // collectionview loads twice
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    private func dismissView() {
        bottomAnimatingView.animateFull(position: .down) {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    deinit {
        print("Pokedex 화면이 내려갔습니다")
    }
}

extension PokedexVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PokeCollectionViewCell {
            
            // print("셀 정보", cell)
            // print("패스", indexPath)
            // when indexPath is selected, update the cell within > need to remove data to make it small.
            if selectedIndexPath?.row == indexPath.row {
                // 셀 다시 선택한 상황
                print("줄었습니다.")
                cell.configureOpenedStack(show: false)
                selectedIndexPath = nil
            } else {
                // 셀 선택 상황
                print("키웠습니다.")
                cell.configureOpenedStack(show: true)
                selectedIndexPath = indexPath
            }
            
            // update the collectionview layout?
            collectionView.performBatchUpdates(nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PokeCollectionViewCell {
            print("다른 셀을 눌렀습니다")
            cell.configureOpenedStack(show: false)
            cell.nameLabel.text = "안눌렸데"
        }
    }
}

extension PokedexVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 151
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokeCollectionViewCell.reuseId, for: indexPath) as! PokeCollectionViewCell
        cell.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        if let pokemon = encounteredId[indexPath.item] {
            // 기본 세팅 상화
            cell.set(data: pokemon)
        } else {
            // 기본 세팅 상화
            cell.pokeImage.image = UIImage(systemName: "clipboard.fill")
            cell.pokeImage.contentMode = .scaleAspectFit
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let animationDuration: Double = 0.7
        let delayBase: Double = 0.2
        let delay = Double(indexPath.row) * delayBase
        
        UIView.animate(withDuration: animationDuration,
                       delay: delay,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 4,
                       options: []) {
            cell.backgroundColor = UIColor.black.withAlphaComponent(0.1)
            cell.transform = .identity
        }
    }
}

extension PokedexVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width
        let padding: CGFloat = 10
        let minimumSpacing: CGFloat = 5
        let availableWidth = width - (padding * 2) - (minimumSpacing * 2)
        let itemWidth = availableWidth / 3
        
        // 셀이 키워졌을 경우의 값
        if selectedIndexPath == indexPath {
            return CGSize(width: availableWidth, height: availableWidth)
        }
        // 기본 셀 사이즈 지정
        return CGSize(width: itemWidth - padding, height: itemWidth)
    }
}
