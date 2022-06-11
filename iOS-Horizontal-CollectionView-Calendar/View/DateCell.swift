//
//  DateCell.swift
//  iOS-Horizontal-CollectionView-Calendar
//
//  Created by Kevin ahmad on 11/06/22.
//

import UIKit

public class DateCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var dayLabel = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    var currDay = 0
    
    var container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.cornerRadius = 18
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Wed"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
        
    }()
    
    var subtitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "12"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        
        
        contentView.addSubview(container)
        container.anchor(top:contentView.topAnchor,left: contentView.leftAnchor,bottom: contentView.bottomAnchor,right: contentView.rightAnchor)
        
        container.addSubview(titleLabel)
        titleLabel.anchor(top:container.topAnchor,left: container.leftAnchor, right: container.rightAnchor,paddingTop: 20)
        titleLabel.centerX(inView: self)
        
        container.addSubview(subtitleLabel)
        subtitleLabel.anchor(top:titleLabel.bottomAnchor,left: container.leftAnchor,right: container.rightAnchor ,paddingTop: 10)
        
    }
    
    public func setup(title: Int, subtitle: String) {
        self.currDay = title
        self.titleLabel.text = dayLabel[currDay]
        self.subtitleLabel.text = subtitle
    }
}
