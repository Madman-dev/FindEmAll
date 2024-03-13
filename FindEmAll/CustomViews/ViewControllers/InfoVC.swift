//
//  InfoVC.swift
//  FindEmAll
//
//  Created by Porori on 2/29/24.
//

import UIKit

class InfoVC: UIViewController {
    let firstItemInfoView = InfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        layoutUI()
    }
    
    private func configureBackground() {
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.backgroundColor = UIColor.blue.cgColor
    }
    
    private func layoutUI() {
        view.addSubview(firstItemInfoView)
        firstItemInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstItemInfoView.topAnchor.constraint(equalTo: view.topAnchor),
            firstItemInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstItemInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            firstItemInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //    func animateToCenter(view: UIView, of parent: UIView) {
    //        DispatchQueue.main.async {
    //            let center = parent.center
    //
    //            UIView.animate(withDuration: 0.5) {
    //                view.center = center
    //            }
    //        }
    //    }
    //
    //    func animateBack(view: UIView) {
    //        DispatchQueue.main.async {
    //            UIView.animate(withDuration: 0.5) {
    //                view.transform = .identity
    //            }
    //        }
    //    }
}
