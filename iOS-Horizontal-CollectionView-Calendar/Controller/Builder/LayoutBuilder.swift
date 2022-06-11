//
//  LayoutBuilder.swift
//  iOS-Horizontal-CollectionView-Calendar
//
//  Created by Kevin ahmad on 11/06/22.
//

import UIKit

public class LayoutBuilder {
    
    public static func buildGallerySectionLayout(size: NSCollectionLayoutSize, itemInset:NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 12.0, bottom: 0.0, trailing: 12.0), sectionInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 16.0, leading: 0.0, bottom: 16.0, trailing: 0.0)) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = itemInset
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInset
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return section
    }
    
    public static func buildHeaderSectionLayout(size: NSCollectionLayoutSize, itemInset:NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 12.0, bottom: 0.0, trailing: 12.0), sectionInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 16.0, trailing: 0.0)) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = itemInset
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInset
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return section
    }
    
}
