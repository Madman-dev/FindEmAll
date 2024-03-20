//
//  UIHelpers.swift
//  FindEmAll
//
//  Created by Porori on 3/20/24.
//

import UIKit

enum UIHelpers {
    static func createThreeColumnFlowlayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 10
        let minimumSpacing: CGFloat = 5
        let availableWidth = width - (padding * 2) - (minimumSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowlayout = UICollectionViewFlowLayout()
        
        // giving the collectionview cell's flow padding within the collectionview
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        // taking into account the spacing inbetween
        flowlayout.itemSize = CGSize(width: itemWidth - padding, height: itemWidth)
        
        return flowlayout
    }
}
