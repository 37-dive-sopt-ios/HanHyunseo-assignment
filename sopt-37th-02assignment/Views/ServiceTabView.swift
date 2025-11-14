//
//  ServiceTabView.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/13/25.
//

import Foundation
import UIKit
import SnapKit
import Then

final class ServiceTabView: UIView {
    
    // MARK: - Properties
    
    private let data = ServiceTabModel.mockData
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .baeminWhite
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.clipsToBounds = true
        collectionView.register(ServiceTabCell.self, forCellWithReuseIdentifier: ServiceTabCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        return collectionView
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        
        let firstIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: [])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupHierarchy() {
        self.addSubview(collectionView)
    }
    
    private func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(44)
        }
    }
}

// MARK: - UICollectionViewDataSource & Delegate

extension ServiceTabView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ServiceTabCell.identifier,
            for: indexPath
        ) as? ServiceTabCell else {
            return UICollectionViewCell()
        }
         
        cell.configure(with: data[indexPath.item])
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}
