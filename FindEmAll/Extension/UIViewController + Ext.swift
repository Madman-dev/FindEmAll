//
//  UIViewController + Ext.swift
//  FindEmAll
//
//  Created by Porori on 4/19/24.
//

import UIKit

extension UIViewController {
    func presentPKAlert(title: String, buttonTitle: String) {
        let alert = PKAlertVC(title: title, buttonTitle: buttonTitle)
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .crossDissolve
        present(alert, animated: true)
    }
}
