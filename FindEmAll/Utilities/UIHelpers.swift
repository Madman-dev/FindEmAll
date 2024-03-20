//
//  UIHelpers.swift
//  FindEmAll
//
//  Created by Porori on 3/20/24.
//

import UIKit

enum UIHelpers {
    // Learn again how the cell's size is modified
    // 10
    static func createThreeColumnFlowlayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 8
        let availableWidth = width - (padding * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        return flowLayout
    }
}
