//
//  CellBuilder.swift
//  iOS-Horizontal-CollectionView-Calendar
//
//  Created by Kevin ahmad on 11/06/22.
//

import UIKit

public class CellBuilder {
    
    public static func getDateCell(collectionView: UICollectionView, indexPath: IndexPath, startDay: Int, monthYear: String) -> UICollectionViewCell{
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCell", for: indexPath) as? DateCell {
            cell.setup(title: (indexPath.row + startDay - 1) % 7 , subtitle: "\(indexPath.row + 1)", monthYear: monthYear)
            return cell
        }else {
            return UICollectionViewCell()
        }
        
    }
    
    public static func getTopHeaderCell(collectionView: UICollectionView, indexPath: IndexPath, month: Int, year: Int) -> UICollectionViewCell{
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topHeaderCell", for: indexPath) as? TopHeaderCell {
            cell.setup(title: "Calendar", subtitle: "Select Month", month: month,year: year)
            return cell
        }else {
            return UICollectionViewCell()
        }
        
    }
    
}
