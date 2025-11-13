//
//  FoodCategoryView.swift
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
        collectionView.backgroundColor = .white
        
        collectionView.register(FoodCategoryCell.self, forCellWithReuseIdentifier: FoodCategoryCell.identifier)
        
        return collectionView
    }()
    
    private let dividerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let viewMoreButton = UIButton(type: .system).then {
        $0.setTitle("음식배달에서 더보기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        $0.tintColor = .darkGray
        $0.backgroundColor = .baeminWhite
        
        // (아이콘 크기 조절)
        let config = UIImage.SymbolConfiguration(pointSize: 10, weight: .medium)
        let image = UIImage(systemName: "chevron.right", withConfiguration: config)
        $0.setImage(image, for: .normal)
        
        $0.semanticContentAttribute = .forceRightToLeft
        $0.isUserInteractionEnabled = false // 탭 기능 없음
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupHierarchy() {
        self.addSubviews(collectionView, dividerView, viewMoreButton)
    }
    
    private func setupStyle() {
        self.backgroundColor = UIColor(named: "baeminWhite")
    }
    
    private func setupLayout() {
        collectionView.snp.makeConstraints {
            let cellHeight: CGFloat = 90
            let spacing: CGFloat = 10
            let contentHeight = (cellHeight * 2) + spacing + 10
            $0.top.equalToSuperview().inset(1)
            $0.leading.trailing.equalToSuperview().inset(0)
            $0.height.equalTo(contentHeight)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        viewMoreButton.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
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
