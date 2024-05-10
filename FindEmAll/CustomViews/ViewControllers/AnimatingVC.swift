//
//  AnimatingVC.swift
//  FindEmAll
//
//  Created by Porori on 4/25/24.
//

import UIKit

class AnimatingVC: UIViewController {
    
    let topAnimatingView = AnimatingView(color: PKColor.PokeRed)
    let bottomAnimatingView = AnimatingView(color: PKColor.PokeGrey)
    private let height = (UIScreen.main.bounds.height/2) - 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimatingViews()
    }
    
    private func configureAnimatingViews() {
        view.addSubviews(topAnimatingView, bottomAnimatingView)
        
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
    
    func loadAnimatingView() {
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
    
    func dismissAndAnimateTo(VC destination: UIViewController) {
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
    
    func dismissAnimatingView() {
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
}
