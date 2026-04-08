//
//  UICollectionView+GridLayout.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func setGridLayout(columns: Int, rowHeight: CGFloat = 180, spacing: CGFloat = 8.0) {
        
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(
                top: spacing,
                leading: spacing,
                bottom: spacing,
                trailing: spacing
            )

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(rowHeight)
            )
            
            let group = NSCollectionLayoutGroup.horizontal( /// 'horizontal(layoutSize:subitem:count:)' was deprecated in iOS 16.0
                layoutSize: groupSize,
                subitem: item,
                count: columns
            )
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        
        self.setCollectionViewLayout(layout, animated: false)
    }
}
