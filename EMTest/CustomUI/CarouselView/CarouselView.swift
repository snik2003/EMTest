//
//  CarouselView.swift
//  EMTest
//
//  Created by Сергей Никитин on 24.03.2023.
//

import UIKit

enum CarouselType {
    case latest
    case flashSale
}

class CarouselView: UIView {
    
    struct CarouselData {
        let latestData: [LatestGoodModel]
        let flashSale: [FlashSaleModel]
    }
    
    // MARK: - Subviews
    
    private lazy var carouselCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.dataSource = self
        collection.delegate = self
        collection.register(FlashSaleCell.self)
        collection.register(LatestGoodCell.self)
        collection.backgroundColor = .clear
        return collection
    }()
    
    
    // MARK: - Properties
    
    private var type: CarouselType!
    
    private var viewModel: HomeViewModelDelegate!
    
    private var carouselData: CarouselData!
    
    private var carouselFlashSaleData: [FlashSaleModel] = []
    
    func setupInitialState(type: CarouselType, viewModel: HomeViewModelDelegate) {
        
        self.type = type
        self.viewModel = viewModel
        
        setupUI()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Setups
private extension CarouselView {
    func setupUI() {
        backgroundColor = .clear
        setupCollectionView()
    }
    
    func setupCollectionView() {
        
        let width = type == .latest ? (UIScreen.main.bounds.width - 12) / 3 : (UIScreen.main.bounds.width - 14) / 2
        let height = self.bounds.height
        
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: width, height: height)
        carouselLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        carouselLayout.minimumLineSpacing = 0.0
        carouselCollectionView.collectionViewLayout = carouselLayout
        
        addSubview(carouselCollectionView)
        
        carouselCollectionView.translatesAutoresizingMaskIntoConstraints = false
        carouselCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        carouselCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        carouselCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        carouselCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

// MARK: - UICollectionViewDataSource
extension CarouselView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return type == .latest ? carouselData.latestData.count : type == .flashSale ? carouselData.flashSale.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if type == .latest {
            let cell: LatestGoodCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.viewModel = viewModel
            cell.configure(model: carouselData.latestData[indexPath.row])
            return cell
        } else if type == .flashSale {
            let cell: FlashSaleCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.viewModel = viewModel
            cell.configure(model: carouselData.flashSale[indexPath.item])
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension CarouselView {
    public func configureView(withLatest latestData: [LatestGoodModel], andFlashSale flashSaleData: [FlashSaleModel]) {
        carouselData = CarouselData(latestData: latestData, flashSale: flashSaleData)
        carouselCollectionView.reloadData()
    }
}
