//
//  CategoryView.swift
//  sopt-37th-02assignment
//
//  Created by 한현서 on 11/13/25.
//

import Foundation
import UIKit
import SnapKit
import Then

final class FoodCategoryView: UIView, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    private let data = CategoryModel.mockData
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self // delegate를 self로 설정
        
        collectionView.isScrollEnabled = false // 스크롤은 바깥의 scrollView가 하도록
        collectionView.backgroundColor = .clear
        
        collectionView.register(FoodCategoryCell.self, forCellWithReuseIdentifier: FoodCategoryCell.identifier)
        
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
            
            let cellHeight: CGFloat = 90
            let spacing: CGFloat = 10
            let inset: CGFloat = 16
            let totalHeight = (cellHeight * 2) + spacing + (inset * 2)
            
            $0.edges.equalToSuperview().inset(inset)
            $0.height.equalTo(totalHeight)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FoodCategoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FoodCategoryCell.identifier,
            for: indexPath
        ) as? FoodCategoryCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: data[indexPath.item])
        return cell
    }
}


extension FoodCategoryView {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 8
        let inset: CGFloat = 0
        
        let totalHorizontalSpacing = (spacing * 4) + (inset * 2)
        let availableWidth = collectionView.bounds.width - totalHorizontalSpacing
        let cellWidth = availableWidth / 5.0
        
        let cellHeight: CGFloat = 90
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
