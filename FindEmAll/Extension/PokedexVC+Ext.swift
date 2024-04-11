//
//  PokedexVC+Ext.swift
//  FindEmAll
//
//  Created by Porori on 4/9/24.
//

import UIKit

extension PokedexVC: UICollectionViewDelegateFlowLayout {
    // MARK: - Dynamic Height Calculation
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isSelected = collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false
        expandableCell.frame = CGRect(origin: .zero, size: CGSize(width: collectionView.bounds.width - 40, height: 1000))
        
        expandableCell.isSelected = isSelected
        expandableCell.setNeedsLayout()
        expandableCell.layoutIfNeeded()
        
        let size = expandableCell.systemLayoutSizeFitting(CGSize(width: collectionView.bounds.width - 40, height: .greatestFiniteMagnitude), withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        24
    }
}
