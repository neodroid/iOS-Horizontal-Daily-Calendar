//
//  HomescreenController.swift
//  iOS-Horizontal-CollectionView-Calendar
//
//  Created by Kevin ahmad on 11/06/22.
//

import UIKit

class HomescreenController: UIViewController, MonthChangeDelegate{
    
    
    
    //MARK: - Properties
    
    let dateFormatter = DateFormatter()
    
    private let calendar = Calendar(identifier: .gregorian)
    private let todayDate = Date()
    private var selectedDate = Date()
    private var selectedMonth = Date()
    private var monthData: MonthMetadata?
    
    //test
    public var string = "6/2022"
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: makeLayout())
        collectionView.backgroundColor = .white
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: "dateCell")
        collectionView.register(TopHeaderCell.self, forCellWithReuseIdentifier: "topHeaderCell")
        
        return collectionView
    }()
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollToDate()
    }
    
    //MARK: - Selectors
    
    @objc func advance() {
        let VC = ChangeMonthController()
        VC.delegate = self
        if let sheet = VC.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        let currData = Calendar.current.dateComponents([.year, .month], from: selectedMonth)
        
        VC.currPickedMonth = currData.month ?? 1
        VC.currPickedYear = currData.year ?? 2022
        self.present(VC, animated: true, completion: nil)
    }
    
    
    //MARK: - Helpers
    
    func scrollToDate() {
        dateFormatter.dateFormat = "dd"
        let todayDateScroll = dateFormatter.string(from: Date())
        if Int(todayDateScroll) ?? 4 > 4 {
            collectionView.scrollToItem(at: (NSIndexPath(item: (Int(todayDateScroll) ?? 1) - 3, section: 1) as IndexPath), at: [], animated: true)
        }
        
        
    }
    
    func userEnterMonthAndYear(month: String, year:String) {
        string = "\(month)/\(year)"
        collectionView.reloadData()
        configureUI()
    }
    
    func configureUI(){
        navigationController?.setNavigationBarHidden(true, animated: false)
        dateFormatter.dateFormat = "MM/yy"
        selectedMonth = dateFormatter.date(from: string) ?? Date()
        
        if let metadata = try? monthMetadata(for: selectedMonth) {
            monthData = metadata
        }
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        
        
    }
    
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            if section == 0 {
                return LayoutBuilder.buildHeaderSectionLayout(size: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)))
            }else{
                return LayoutBuilder.buildGallerySectionLayout(size: NSCollectionLayoutSize(widthDimension: .absolute(95), heightDimension: .absolute(100)))
            }
            
        }
        return layout
        
    }
    
    func showChangeMonth(){
        let VC = ChangeMonthController()
        
        if let sheet = VC.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        self.present(VC, animated: true, completion: nil)
        
    }
    
    
}

// MARK: - Extensions

extension HomescreenController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return monthData?.numberOfDays ?? 1
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let pickedMonthAndYear = Calendar.current.dateComponents([.year, .month], from: selectedMonth)
        let pickedMonth = pickedMonthAndYear.month
        let pickedYear = pickedMonthAndYear.year
        
        if indexPath.section == 0 {
            let cell = CellBuilder.getTopHeaderCell(collectionView: collectionView, indexPath: indexPath, month: pickedMonth ?? 1, year: pickedYear ?? 2022)
            return cell
        }else {
            let cell = CellBuilder.getDateCell(collectionView: collectionView, indexPath: indexPath, startDay: monthData?.firstDayWeekday ?? 0, monthYear: "\(pickedMonth!)/\(pickedYear!)")
            return cell
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if indexPath.section == 0 {
            perform(#selector(advance), with: nil, afterDelay: 0)
        }else if indexPath.section == 1 {
            let currData = Calendar.current.dateComponents([.year, .month], from: selectedMonth)
            let month = MonthTemplate()
            print("picked date = \(indexPath.row + 1)/\(month.shortName[currData.month! - 1])/\(currData.year!)")
        }
        
        
    }
    
    
}

// MARK: - Day Generation

extension HomescreenController {
    
    func monthMetadata(for baseDate: Date) throws -> MonthMetadata {
        guard
            let numberOfDaysInMonth = calendar.range(
                of: .day,
                in: .month,
                for: baseDate)?.count,
            let firstDayOfMonth = calendar.date(
                from: calendar.dateComponents([.year, .month], from: baseDate))
        else {
            fatalError()
        }
        let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        return MonthMetadata(
            numberOfDays: numberOfDaysInMonth,
            firstDay: firstDayOfMonth,
            firstDayWeekday: firstDayWeekday)
    }
    
    
}

