//
//  UIViewController + Ext.swift
//  FindEmAll
//
//  Created by Porori on 4/19/24.
//

import UIKit

extension UIViewController {
    func presentPokeAlert(title: String, message: String, buttonTitle: String) {
        let alert = PokeAlertVC(title: title, message: message, buttonTitle: buttonTitle)
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .crossDissolve
        present(alert, animated: true)
    }
}
