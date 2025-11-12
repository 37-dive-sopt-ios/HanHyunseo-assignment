//
//  StoreCategoryView.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/13/25.
//

import Foundation
import UIKit
import SnapKit
import Then

final class StoreCategoryView: UIView {
    private let data = StoreModel.mockData
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        layout.itemSize = CGSize(width: 72, height: 90)
        layout.minimumLineSpacing = 8 // 셀 사이의 간격
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false // 스크롤바 숨기기
        collectionView.backgroundColor = .clear
        
        collectionView.register(StoreCategoryCell.self, forCellWithReuseIdentifier: StoreCategoryCell.identifier)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
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
            $0.height.equalTo(122)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension StoreCategoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StoreCategoryCell.identifier,
            for: indexPath
        ) as? StoreCategoryCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: data[indexPath.item])
        return cell
    }
    
}
